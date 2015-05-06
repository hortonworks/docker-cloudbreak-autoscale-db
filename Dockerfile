FROM postgres:9.4.1

ENV PCDB_VERSION 0.5.2
ADD https://github.com/sequenceiq/docker-pcdb/releases/download/v${PCDB_VERSION}/pcdb-${PCDB_VERSION}.tgz /initdb/
ADD /start /

ENTRYPOINT [ "/start" ]
CMD ["postgres"]
