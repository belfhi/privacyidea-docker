FROM python:3.10.9-slim-bullseye

ENV DEBIAN_FRONTEND noninteractive 
ENV PI_HOME /etc/privacyidea
RUN apt update  \
  && apt install --no-install-recommends -y \
  build-essential \
  python3-dev \
  libffi-dev \
  libjpeg-dev \
  zlib1g-dev \
  libpq-dev\
  && apt clean && rm -rf /var/lib/apt/lists/*
  
RUN mkdir -p $PI_HOME &&  \
    groupadd -g 500 privacy && \
    useradd  -g 500 -u 500 -d $PI_HOME -s /bin/bash pi && \
    chown -R 500:500 $PI_HOME

WORKDIR $PI_HOME
USER pi

RUN python3 -m venv $PI_HOME
ENV PATH="$PI_HOME/bin:${PATH}"
RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
    wheel \
    uwsgi \
    psycopg2 \
    pymysql
RUN pip3 install -r https://raw.githubusercontent.com/privacyidea/privacyidea/v3.7/requirements.txt
RUN pip3 install privacyidea==3.7

RUN mkdir $PI_HOME/config
COPY ./app/privacyidea.ini $PI_HOME/
COPY ./app/privacyideaapp.wsgi $PI_HOME/
COPY ./app/pi.cfg $PI_HOME/config/

EXPOSE 3031
CMD ["uwsgi", "privacyidea.ini"]
