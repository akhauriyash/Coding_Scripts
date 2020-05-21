
DOCKER_GID=$(id -g)
DOCKER_GNAME=$(id -gn)
DOCKER_UNAME=$(id -un)
DOCKER_UID=$(id -u)
DOCKER_PASSWD="password"
DOCKER_TAG="cuda_$DOCKER_UNAME"
DOCKER_NAME="cudadev_$DOCKER_UNAME"


# Absolute path of script eg /home/yakhauri/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path of directory of script eg /home/yakhauri/bin 
SCRIPTPATH=$(dirname "$SCRIPT")

docker build --tag=$DOCKER_TAG \
			 --build-arg IMAGE_NAME=$DOCKER_TAG \
			 --build-arg GID=$DOCKER_GID \
			 --build-arg GNAME=$DOCKER_GNAME \
			 --build-arg UNAME=$DOCKER_UNAME \
			 --build-arg UID=$DOCKER_UID \
			 --build-arg PASSWD=$DOCKER_PASSWD \
			 .


docker run --name $DOCKER_NAME -it \
	-v $SCRIPTPATH:/cuda_workspace  \
	$DOCKER_TAG bash
