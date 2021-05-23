FROM tomcat:9.0.46-jdk16-openjdk-slim-buster

RUN echo "fedlet.dataserv.local" > /etc/hostname
RUN echo "PS1='\033[01;32m${debian_chroot:+($debian_chroot)}\u@\h\033[00m\]:\w\$'" >> /root/.bashrc

RUN apt-get update
RUN apt-get -y install vim jq net-tools

RUN useradd -ms /bin/bash -u 1111 forgerock
RUN echo "forgerock     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers



COPY fedlet*.war /usr/local/tomcat/webapps/fedlet.war
WORKDIR /root
RUN mkdir -p ./fedlet
RUN mkdir -p ./images
COPY conf/* ./fedlet/

COPY PrimaryProductName.png ./images/

COPY bootstrap.env .
COPY start.sh .
COPY set-providers.sh .
COPY utils.sh .
COPY entrypoint.sh .
COPY changeImage.sh .
RUN chmod +x start.sh
RUN chmod +x entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/root/entrypoint.sh"]
