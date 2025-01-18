#!/bin/zsh

# 호스트에서 X11 디스플레이 권한 부여
xhost +local:docker

# 환경 변수 설정
CONTAINER_NAME="slam"
IMAGE_NAME="slam:v1"

HOST_MNT_DIR="/home/${USER}"                    # 호스트의 마운트 디렉토리
CONTAINER_HOME_DIR="/mnt"

HOST_DATA_DIR="/mnt"                  # 호스트의 데이터 디렉토리
CONTAINER_DATA_DIR="/data"


# 도커 실행
docker run -it --rm \
    --name "${CONTAINER_NAME}" \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v "${HOST_MNT_DIR}:${CONTAINER_HOME_DIR}:rw" \
    -v "${HOST_DATA_DIR}:${CONTAINER_DATA_DIR}:rw" \
    --privileged \
    "${IMAGE_NAME}" \
    /bin/bash