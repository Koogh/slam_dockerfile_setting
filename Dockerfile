FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install build-essential -y && \
    apt-get install cmake -y && \
    apt-get install git -y && \
    apt-get install sudo -y && \
    apt-get install wget -y && \
    apt-get install ninja-build -y && \
    apt-get install software-properties-common -y && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y && \
    apt-get install -y ssh && \
    apt-get install -y gcc && \
    apt-get install -y g++ && \
    apt-get install -y gdb && \
    apt-get install -y cmake && \
    apt-get install -y rsync && \
    apt-get install -y tar && \
    apt-get install -y x11-utils && \
    apt-get install -y x11-apps && \
    apt-get install -y zip &&\
    apt-get clean

# install setting 
RUN echo "check_certificate = off" > ~/.wgetrc    

# OpenCV
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN wget https://github.com/opencv/opencv/archive/refs/tags/4.8.1.zip &&\
    unzip 4.8.1.zip &&\
    rm 4.8.1.zip &&\
    cd opencv-4.8.1 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j4 &&\
    make install &&\
    cd ../../

# Eigen
RUN wget https://gitlab.com/libeigen/eigen/-/archive/3.3.8/eigen-3.3.8.zip &&\
    unzip eigen-3.3.8.zip &&\
    rm eigen-3.3.8.zip &&\
    cd eigen-3.3.8 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j4 &&\
    make install &&\
    cd ../../

# Sophus
RUN wget https://github.com/strasdat/Sophus/archive/refs/tags/1.22.10.zip &&\
    unzip 1.22.10.zip &&\
    rm 1.22.10.zip &&\
    cd Sophus-1.22.10 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j4 &&\
    make install && \
    cd ../../

# Pangolin
RUN apt-get install -y mesa-utils && \
    apt-get install -y libgl1-mesa-glx && \
    apt-get install -y libglu1-mesa-dev && \
    apt-get install -y libglew-dev &&\
    apt-get install -y libglvnd-dev &&\
    apt-get install -y libgl1-mesa-dev &&\
    apt-get install -y libegl1-mesa-dev &&\
    apt-get install -y mesa-common-dev

RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip &&\
    unzip v0.6.zip &&\
    rm v0.6.zip &&\
    cd Pangolin-0.6 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j4 &&\
    make install &&\
    cd ../../
    
# PCL
RUN apt-get update && \
    apt-get install -y libpcl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


## Ceres-solver
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    unzip \
    libgoogle-glog-dev \
    libgflags-dev \
    libatlas-base-dev \
    libsuitesparse-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/2.1.0.zip && \
    unzip 2.1.0.zip && \
    rm 2.1.0.zip

RUN cd ceres-solver-2.1.0 && \
    mkdir build && cd build && \
    cmake .. && \
    make -j4 && \
    make install && \
    cd ../../


## miniconda 
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    mkdir -p $CONDA_DIR && \
    bash /tmp/miniconda.sh -b -f -p $CONDA_DIR && \
    rm /tmp/miniconda.sh


ENV PATH="$CONDA_DIR/bin:$PATH"
RUN conda init 


# g2o
RUN apt-get update && apt-get install -y \
    libeigen3-dev \
    libspdlog-dev \
    libsuitesparse-dev \
    qtdeclarative5-dev \
    qt5-qmake libqglviewer-dev-qt5

RUN wget https://github.com/RainerKuemmerle/g2o/archive/refs/heads/master.zip -O g2o-master.zip && \
    unzip g2o-master.zip && \
    rm g2o-master.zip && \
    cd g2o-master && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig



# command - bash
CMD ["bash"]