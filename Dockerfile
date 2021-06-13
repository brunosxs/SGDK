FROM i386/alpine

# Set-up argument defaults
ARG JDK_VER=8

# Install supporting packages
RUN apk update && \
    apk add --no-cache \
      bash \
      make \
      openjdk${JDK_VER}-jre \
      freetype \
      wine && \
        rm -fr /var/cache/apk/*

# Set-up SGDK
COPY . /sgdk
ENV GDK=/sgdk

COPY entry_point.sh /entry_point.sh
RUN chmod +rwx /entry_point.sh

# Create wrappers to execute .exe files using wine
RUN /sgdk/bin/create-bin-wrappers.sh

# Set-up mount point and make command
VOLUME /src
WORKDIR /src

ENTRYPOINT [ "/entry_point.sh" ]
