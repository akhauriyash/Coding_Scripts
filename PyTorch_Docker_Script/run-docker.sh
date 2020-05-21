#!/bin/sh

# $1 --> Docker Tag Name and Password

DOCKER_GID=$(id -g)
DOCKER_GNAME=$(id -gn)
DOCKER_UNAME=$(id -un)
DOCKER_UID=$(id -u)
DOCKER_PASSWD="$1"
DOCKER_TAG="$1_$DOCKER_UNAME"
DOCKER_NAME="$1_dev_$DOCKER_UNAME"
SCRIPT_PATH_DOCKER="/workspace/$1"

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
# Repo Link
DEEPEX_REPO=https://github.com/drimpossible/Deep-Expander-Networks.git
# Repo Local Clone Path 
DEEPEX_LOCAL=$SCRIPTPATH/Deep-Expander-Networks
# Repo Docker Clone Path
DEEPEX_DOCKER="/workspace/Deep-Expander-Networks"
# clone repos as needed
git clone $DEEPEX_REPO $DEEPEX_LOCAL ||  git -C "$DEEPEX_LOCAL" pull


filename='clone_repo_list.txt'
n=1
while read line; do
	SUBSTRING=$(echo $line| cut -d'/' -f 5)
	SUBSTRING=${SUBSTRING%".git"}
	repo[$n]=$line
	repo_local[$n]=${SCRIPTPATH}/${SUBSTRING}
	repo_docker[$n]=/workspace/${SUBSTRING}
	git clone ${repo[$n]} ${repo_local[$n]} || git -C ${repo_local[$n]} pull
	echo "Mounting ${repo_local[$n]} into ${repo_docker[$n]}"
	n=$((n+1))
done<$filename

# Build the Docker image
docker build --tag=$DOCKER_TAG \
             --build-arg GID=$DOCKER_GID \
             --build-arg GNAME=$DOCKER_GNAME \
             --build-arg UNAME=$DOCKER_UNAME \
             --build-arg UID=$DOCKER_UID \
             --build-arg PASSWD=$DOCKER_PASSWD \
             .

n=$((n-1))
# Launch container with current directory mounted
touch docrun.sh
echo "docker run --gpus all --name $DOCKER_NAME -it \\
--shm-size 32G \\
-v $SCRIPTPATH:$SCRIPT_PATH_DOCKER \\" >> docrun.sh
i=1
while [ $i -le $n ]
	do
		echo "-v ${repo_local[$i]}:${repo_docker[$i]} \\" >> docrun.sh
		i=$((i+1))
	done
echo "$DOCKER_TAG bash\n" >> docrun.sh

