FROM debian:sid

WORKDIR /tmp

RUN echo "deb-src http://http.debian.net/debian sid main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y curl devscripts \
 && apt-get build-dep -y xserver-xorg-video-intel \

 && apt-get source xserver-xorg-video-intel \
 && cd xserver-xorg-video-intel* \
 && curl -L https://github.com/brimstone/6430-dual-gpu/raw/master/xserver-xorg-video-intel-2.21.15-1_virtual_crtc.patch > virtual.patch \
 && patch -p1 < virtual.patch \
 && debchange -l "+VIRTUAL" "Adding Virtual patch" \
 && dpkg-buildpackage -us -uc
 
