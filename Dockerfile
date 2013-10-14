FROM ubuntu:12.04
MAINTAINER Ben Firshman "ben@orchardup.com"

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get install -y sudo curl unzip nodejs=0.10.20-1chl1~precise1
RUN curl -L https://en.ghost.org/zip/ghost-0.3.2.zip > /tmp/ghost.zip
RUN useradd ghost
RUN mkdir -p /opt/ghost
WORKDIR /opt/ghost
RUN unzip /tmp/ghost.zip
RUN npm install --production

# Volumes
RUN mkdir /data
VOLUME ["/data"]

ADD run /usr/local/bin/run
ADD config.js /opt/ghost/config.js
RUN chown -R ghost:ghost /opt/ghost

ENV NODE_ENV production
ENV GHOST_URL http://my-ghost-blog.com
EXPOSE 2368
CMD ["/usr/local/bin/run"]

