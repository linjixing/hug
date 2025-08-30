FROM ubuntu:22.04

COPY bin/* /usr/local/bin/
COPY etc/* /usr/local/etc/

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
    useradd -m -s /bin/bash -G root user

ENTRYPOINT ["init"]

CMD [ "supervisord","-c","/usr/local/etc/supervisord.conf" ]
