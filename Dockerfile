FROM ubuntu:22.04 as builder
RUN apt update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends
RUN apt install apt-transport-https -y
RUN apt install software-properties-common -y
#RUN apt install openssl -y
RUN apt install wget -y
RUN apt install gawk -y
RUN mkdir -p /home/scripts

ADD . /home/scripts
RUN chmod u+x /home/scripts/install.sh && /home/scripts/install.sh

FROM ubuntu:22.04
RUN apt update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends
RUN useradd -M -s /bin/bash -u 10001 -g 0 gouser
RUN mkdir -p /home/scripts

COPY --from=builder /usr/local/go /usr/local/go

ENV PATH=/usr/local/go/bin:$PATH
#RUN echo $PATH

RUN echo "go version" > /home/scripts/Check.sh
RUN echo "go help" >> /home/scripts/Check.sh
RUN chmod a+x /home/scripts/Check.sh

USER gouser
CMD ["/bin/sh","/home/scripts/Check.sh"]