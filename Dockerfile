FROM ubuntu:16.04
MAINTAINER Marica Antonacci <marica.antonacci@gmail.com>
LABEL description="Container image to run R scripts"

RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update && \
    apt-get install -y \
        ansible git wget


#RUN ansible-galaxy install maricaantonacci.r && \
#    ansible-galaxy install indigo-dc.oneclient && \
#    ansible-playbook /etc/ansible/roles/maricaantonacci.r/tests/base.yml && \
#    ansible-playbook /etc/ansible/roles/indigo-dc.oneclient/tests/test.yml

RUN git clone https://github.com/maricaantonacci/ansible-r.git /etc/ansible/roles/maricaantonacci.r && \
    ansible-galaxy install indigo-dc.oneclient && \
    ansible-playbook /etc/ansible/roles/maricaantonacci.r/tests/base.yml && \
    ansible-playbook /etc/ansible/roles/indigo-dc.oneclient/tests/test.yml    

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV AUTHENTICATION=token
ENV NO_CHECK_CERTIFICATE=true
