FROM hseeberger/scala-sbt

# caching dependencies
COPY ["build.sbt", "/tmp/build/"]
COPY ["project/plugins.sbt", "project/build.properties", "/tmp/build/project/"]

RUN apt-get install git

RUN cd /tmp/build && \
  sbt compile && \
  sbt test:compile && \
  rm -rf /tmp/build

# copy code
COPY . /root/app/
WORKDIR /root/app
#RUN sbt compile && sbt test:compile
RUN sbt run

EXPOSE 9000
#CMD ["sbt run"]

