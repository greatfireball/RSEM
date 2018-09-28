FROM ubuntu:18.04
LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the RSEM pipeline" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/RSEM.git"

RUN apt-get update

# RSEM
RUN apt-get install -y rsem

# STAR
RUN apt-get install -y make
ENV SW=/root/software/
RUN mkdir -p ${SW}
WORKDIR ${SW}
ENV STAR="STAR"
COPY ${STAR} ${STAR}
WORKDIR "${SW}/${STAR}/source"
RUN make STAR
ENV PATH="${PATH}:${SW}/${STAR}/bin/Linux_x86_64/"
WORKDIR ${SW}

# BOWTIE and BOWTIE2
RUN apt-get install -y bowtie
RUN apt-get install -y bowtie2

# samtools
RUN apt-get install -y samtools

# boost C++
RUN apt-get install -y libboost-all-dev
