FROM ubuntu:22.04

WORKDIR /app

COPY app /app
COPY bin /usr/local/bin

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y ca-certificates curl wget net-tools unzip tzdata vim supervisor --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo 'Asia/Shanghai' > /etc/timezone; \
    echo 'set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom' >> /etc/vim/vimrc; \
    echo 'set termencoding=utf-8' >> /etc/vim/vimrc; \
    echo 'set encoding=utf-8' >> /etc/vim/vimrc; \
    chmod 777 -R /app; \
    chmod 777 -R /usr/local/bin; \
    useradd -u 1000 -g 0 -m -s /bin/bash user

EXPOSE 7860

ENTRYPOINT ["init"]

CMD [ "supervisord","-c","/app/supervisord.conf" ]
