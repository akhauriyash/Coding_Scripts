FROM pytorch/pytorch:1.3-cuda10.1-cudnn7-devel
MAINTAINER Yash Akhauri <akhauri.yash@gmail.com>
ARG PYTHON_VERSION=3.6

WORKDIR /workspace

RUN apt-get update
RUN apt-get install -y xvfb libssl-dev build-essential libglib2.0-0 libsm6 libxext6 libxrender-dev zsh ssh rsync sudo vim htop

RUN apt-get update
RUN apt remove --purge --auto-remove cmake
RUN apt install -y libprotobuf-dev protobuf-compiler

ARG version=3.16
ARG build=2
RUN mkdir /workspace/temp
RUN cd /workspace/temp
RUN wget -P /workspace/temp/ https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
RUN tar -xzvf /workspace/temp/cmake-$version.$build.tar.gz
RUN ls
RUN pwd
RUN cd /workspace/cmake-$version.$build/
RUN /workspace/cmake-$version.$build/bootstrap
RUN make -j$(nproc)
RUN make install

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update 
RUN apt-get install -y g++-6
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 100
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 50

# Use these to add PATHS as needed
# ENV PYTHONPATH "${PYTHONPATH}:/workspace/path/to/repo/src"
# ENV PATH "${PATH}:/workspace/path/to/library"

ARG GID
ARG GNAME
ARG UNAME
ARG UID
ARG PASSWD

RUN groupadd -g $GID $GNAME
RUN useradd -M -u $UID $UNAME -g $GNAME
RUN usermod -aG sudo $UNAME
RUN echo "$UNAME:$PASSWD" | chpasswd
RUN echo "root:$PASSWD" | chpasswd
RUN ln -s /workspace /home/$UNAME
RUN chown -R $UNAME:$GNAME /home/$UNAME
USER $UNAME
ENV UNAME $UNAME

COPY requirements.txt .
RUN pip install --user -r requirements.txt
RUN pip install --user git+https://github.com/Xilinx/brevitas.git

WORKDIR /home/$UNAME/repo

ENTRYPOINT /bin/bash
