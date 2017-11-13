#FROM ysihaoy/scala-play:2.12.3-2.6.2-sbt-0.13.15
FROM setusoft/scala-sbt-nodejs

# caching dependencies
COPY ["build.sbt", "/tmp/build/"]
COPY ["project/plugins.sbt", "project/build.properties", "/tmp/build/project/"]

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
COPY . /root/app/

WORKDIR /root/app

RUN npm install

RUN sbt compile 
RUN sbt test:compile

EXPOSE 9000
CMD ["sbt"]