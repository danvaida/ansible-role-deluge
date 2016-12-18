FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install build-essential \
                       ca-certificates \
                       gcc \
                       libffi-dev \
                       libssl-dev \
                       libyaml-dev \
                       openssh-client \
                       python-dev \
                       python-pip

RUN pip install ansible==2.2

COPY run-tests.sh run-tests.sh
CMD ["./run-tests.sh"]
