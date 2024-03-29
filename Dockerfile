FROM maven:3.6-jdk-11

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install --no-install-recommends python3 2>&1 \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install git procps lsb-release \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY . /jsh



RUN cd /jsh && mvn package -DskipTests

ENV DEBIAN_FRONTEND=

RUN chmod u+x /jsh/jsh 
RUN chmod u+x /jsh/tools/test 
RUN chmod u+x /jsh/tools/coverage 
RUN chmod u+x /jsh/tools/analysis

EXPOSE 8000

RUN chmod u+x /jsh/jsh
RUN chmod u+x /jsh/tools/test
RUN chmod u+x /jsh/tools/coverage
RUN chmod u+x /jsh/tools/analysis