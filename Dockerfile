FROM rockylinux/rockylinux:latest


RUN dnf -y install epel-release 
RUN     dnf -y install rust gcc gcc-c++ make openssl-devel libffi-devel snappy  libunwind-devel python3-devel python3-virtualenv python3-pip 
RUN    pip3 install --upgrade pip 
RUN     MDB_FORCE_SYSTEM=1 pip install crossbar 

