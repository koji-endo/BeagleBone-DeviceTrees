# docker build -t IMAGE_NAME .
# docker run -v $PWD:/root -it IMAGE_NAME make src/arm/am5729-beagleboneai-prugpuoff-in.dtb
FROM ubuntu:20.04
WORKDIR /root
RUN apt update && apt install -y device-tree-compiler make cpp
