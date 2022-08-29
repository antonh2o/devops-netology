FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.5@sha256:76344d5f89b13147743db0487eb76b03a7f9f0cd55abe8ab887069711f2ee27d
LABEL elasticsearch DZ6.5 netology
ENV PATH=/usr/lib:/usr/lib/jvm/jre-11/bin:$PATH
ENV bootstrap.memory_lock=true
ENV discovery.type=single-node
ENV path.data=/var/lib/data
ENV path.logs=/var/lib/logs
ENV path.repo=/elasticsearch/snapshots
ENV node.name=netology_test
ENV ES_HEAP_SIZE="4g"
EXPOSE 9200

ADD elasticsearch.yml /elasticsearch/config/
ENV ES_HOME=/elasticsearch
RUN mkdir /var/lib/logs \
    && chown elasticsearch:elasticsearch /var/lib/logs \
    && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data \
    && chown -R elasticsearch:elasticsearch /elasticsearch/
RUN mkdir /elasticsearch/snapshots &&\
chown elasticsearch:elasticsearch /elasticsearch/snapshots
USER elasticsearch
