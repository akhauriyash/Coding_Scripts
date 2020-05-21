ARG IMAGE_NAME
FROM nvidia/cuda:10.2-devel-ubuntu18.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

ENV CUDNN_VERSION 7.6.5.32
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda10.2 \
libcudnn7-dev=$CUDNN_VERSION-1+cuda10.2 \
&& \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*
    
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        wget \
        git \
        python3 \
        python3-dev \
        python3-pip \
        python3-wheel \
        python3-numpy \
        libcurl3-dev  \
        ca-certificates \
        gcc \
        sox \
        libsox-fmt-mp3 \
        htop \
        nano \
        swig \
        cmake \
        libboost-all-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        locales \
        pkg-config \
        libpng-dev \
        libsox-dev \
        libmagic-dev \
        libgsm1-dev \
        libltdl-dev \
        openjdk-8-jdk \
        bash-completion \
        g++ \
        unzip \
	htop \
	vim \
	tmux

RUN apt-get update -y
RUN apt-get install -y git curl ca-certificates bzip2 cmake tree htop bmon iotop sox libsox-dev libsox-fmt-all vim


RUN apt-get update
RUN apt-get install -y xvfb libglib2.0-0 libsm6 libxext6 libxrender-dev
RUN apt-get install -y htop cmake libncurses5-dev libncursesw5-dev git 
# RUN git clone https://github.com/Syllo/nvtop.git
# RUN mkdir -p nvtop/build && cd nvtop/build
# RUN cmake ..
# RUN make
# RUN make install

WORKDIR /cuda_workspace
RUN chmod -R a+w .
