#FROM ysihaoy/scala-play:2.12.3-2.6.2-sbt-0.13.15
FROM smartkit/scala-sbt-nodejs:2.12.2-0.13.16-6


# Install Java.
RUN  apt-get -y install python-software-properties
RUN  apt-get -y install software-properties-common
# Install Java.
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer


# caching dependencies
COPY ["build.sbt", "/tmp/build/"]
COPY ["project/plugins.sbt", "project/build.properties", "/tmp/build/project/"]
COPY ["project/build.properties", "/"]

#RUN apk add --no-cache git
#RUN apk add --update nodejs
RUN apt-get install git
#RUN apt-get update
#RUN apt-get install nodejs

RUN cd /tmp/build 
RUN sbt compile 
RUN sbt test:compile 
# clean
RUN rm -rf /tmp/build


# copy code
COPY . /app/

WORKDIR /app

#RUN git clone git://github.com/gpgekko/sbt-autoprefixer /root/.sbt/0.13/staging/a13d8a10bd266a4d281d/sbt-autoprefixer
COPY sbt-autoprefixer /root/.sbt/0.13/staging/a13d8a10bd266a4d281d/

RUN npm install

#RUN sbt update 
#RUN sbt compile 
#RUN sbt test:compile
RUN sbt  

EXPOSE 9000
#CMD ["sbt"]
