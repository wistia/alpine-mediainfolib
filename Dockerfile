FROM alpine-zenlib as zenlib

FROM alpine
RUN apk update && apk add git automake make autoconf libtool gcc libc-dev zlib-dev g++
COPY --from=zenlib /usr/local/lib/libzen.a /usr/local/lib/libzen.a
COPY --from=zenlib /usr/local/include/ZenLib /usr/local/include/ZenLib/
COPY --from=zenlib /ZenLib/Project/GNU/Library/libzen-config /bin/libzen-config
RUN git clone https://github.com/MediaArea/MediaInfoLib.git
WORKDIR /MediaInfoLib/Project/GNU/Library
RUN ./autogen.sh && ./configure --enable-static && make && make install
