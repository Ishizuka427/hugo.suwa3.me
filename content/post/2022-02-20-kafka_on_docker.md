---
title: "kafka on Docker"
date: "2022-02-20T00:00:00.000Z"
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

# Kafka on Docker
なんだか二度目な気がするけれど気のせいです

## docker-compose.yml

```docker-compose.yml
version: "3"
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:5.5.1
    hostname: zookeeper
    container_name: zookeeper
    ports:
      - "32181:32181"
    environment:
      ZOOKEEPER_CLIENT_PORT: 32181
      ZOOKEEPER_TICK_TIME: 2000

  broker:
    image: confluentinc/cp-kafka:5.5.1
    hostname: broker
    container_name: broker
    depends_on:
      - zookeeper
    ports:
      - "9092:9092"
      - "29092:29092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: "zookeeper:32181"
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://broker:29092,PLAINTEXT_HOST://localhost:9092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      CONFLUENT_SUPPORT_METRICS_ENABLE: "false"

  cli:
    image: confluentinc/cp-kafka:5.5.1
    hostname: cli
    container_name: cli
    depends_on:
      - broker
    entrypoint: /bin/sh
    tty: true

networks:
  default:
    external:
      name: iot_network
```

そういえば、先日知ったのですが！docker-compose コマンドが、Docker CLI にサブコマンド compose という形で実装されて `docker compose ps` ができるようになったらしいです。Usage を見ると docker-compose のほうが少しだけ Options の種類が多そうに見えるのですが、docker-compose で非推奨のものはわざわざ実装しないという方針のよう？  
[docker-composeとComposeコマンドの互換性](https://docs.docker.com/compose/cli-command-compatibility/)  
  
実際に `docker compose ps` で各コンテナの様子を見てみます。

```sh
suwa3@mb12 kafka-on-docker % docker compose ps 
WARN[0000] network default: network.external.name is deprecated in favor of network.name 
NAME                COMMAND                  SERVICE             STATUS              PORTS
broker              "/etc/confluent/dock…"   broker              running             0.0.0.0:9092->9092/tcp, :::9092->9092/tcp, 0.0.0.0:29092->29092/tcp, :::29092->29092/tcp
cli                 "/bin/sh"                cli                 running             9092/tcp
zookeeper           "/etc/confluent/dock…"   zookeeper           running             2181/tcp, 2888/tcp, 3888/tcp, 0.0.0.0:32181->32181/tcp, :::32181->32181/tcp
```
おおー  
ちなみに `docker-compose ps` だと？  
```sh
suwa3@mb12 kafka-on-docker % docker-compose ps
  Name               Command            State                                           Ports                                         
--------------------------------------------------------------------------------------------------------------------------------------
broker      /etc/confluent/docker/run   Up      0.0.0.0:29092->29092/tcp,:::29092->29092/tcp, 0.0.0.0:9092->9092/tcp,:::9092->9092/tcp
cli         /bin/sh                     Up      9092/tcp                                                                              
zookeeper   /etc/confluent/docker/run   Up      2181/tcp, 2888/tcp, 0.0.0.0:32181->32181/tcp,:::32181->32181/tcp, 3888/tcp      
```
ついでに `docker ps`  
```sh
suwa3@mb12 kafka-on-docker % docker ps
CONTAINER ID   IMAGE                             COMMAND                  CREATED         STATUS         PORTS                                                                                      NAMES
067c2378baa3   confluentinc/cp-kafka:5.5.1       "/bin/sh"                4 minutes ago   Up 4 minutes   9092/tcp                                                                                   cli
c5e59034f74d   confluentinc/cp-kafka:5.5.1       "/etc/confluent/dock…"   4 minutes ago   Up 4 minutes   0.0.0.0:9092->9092/tcp, :::9092->9092/tcp, 0.0.0.0:29092->29092/tcp, :::29092->29092/tcp   broker
1a46f79259cb   confluentinc/cp-zookeeper:5.5.1   "/etc/confluent/dock…"   4 minutes ago   Up 4 minutes   2181/tcp, 2888/tcp, 3888/tcp, 0.0.0.0:32181->32181/tcp, :::32181->32181/tcp                zookeeper
```
docker compose ps と docker ps は、Docker CLI ということで見え方が似ていますね。  
脱線しているので Kafka に戻りたいと思います。

## Topicの作成
コンテナの起動は確認できたので、Topic を作成したいと思います。  
broker コンテナに接続します。  
```sh
% docker exec -it broker /bin/bash
```
kafka-topics コマンド (使い方は `kafka-topics --help` で確認)  
--bootstrap-server: 接続先のKafkaサーバーを指定します  
--create: 新規 Topic を作成します  
--topic: 作成、変更、記述、削除するトピックを指定します  
--partitions: パーティション数を指定します  
--replication-factor: クラスター全体のレプリカの総数。今回は係数1で指定しているため、コピーが1つ作られます  
```sh
root@broker:/# kafka-topics --bootstrap-server broker:9092 --create --topic sample-topic --partitions 3 replication-factor 1
Created topic sample-topic.
```
Topic の確認  
--describe: Topic の詳細を見ることができます  
```sh
root@broker:/# kafka-topics --bootstrap-server broker:9092 --describe --topic sample-topic
Topic: sample-topic	PartitionCount: 3	ReplicationFactor: 1	Configs: 
	Topic: sample-topic	Partition: 0	Leader: 1	Replicas: 1	Isr: 1
	Topic: sample-topic	Partition: 1	Leader: 1	Replicas: 1	Isr: 1
	Topic: sample-topic	Partition: 2	Leader: 1	Replicas: 1	Isr: 1
```
Consumer のグループIDなどを確認します
```sh
root@broker:/# kafka-consumer-groups --describe --bootstrap-server broker:9092 --all-groups

Consumer group 'G1' has no active members.

GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
G1              sample-topic    0          0               0               0               -               -               -
G1              sample-topic    1          1               1               0               -               -               -
G1              sample-topic    2          0               0               0               -               -               -
```

## Consumer の設定

cli コンテナに接続します  

```sh
docker exec -it cli /bin/bash
```
` kafka-console-consumer` コマンドを使用することで Consumer として操作することができます。  
--group: Consumer のグループIDを指定します  
--from-beginning: offsetの最初から読み込みます  
```sh
root@cli:/# kafka-console-consumer --bootstrap-server broker:29092 --topic sample-topic --group G1 --from-beginning
```
※プロンプトには何も表示されません  

## Producer の設定
別ターミナルを立ち上げて cli コンテナに接続します  
```sh
docker exec -it cli /bin/bash
```
`kafka-console-producer` コマンドを使用することで Producer として操作することができます。  
```sh
root@cli:/# kafka-console-producer --broker-list broker:29092 --topic sample-topic
>
```
`>` の後ろに`testing!!`と書いてみます  
  
先程の Consumer の設定をしたタブに戻り確認すると  
```sh
root@cli:/# kafka-console-consumer --bootstrap-server broker:29092 --topic sample-topic --group G1 --from-beginning
testing!!
```
無事に、`testing!!`を確認することができました。  
  
参照:   
[KafkaをローカルのDocker環境で、さくっと動かしてみました 　第１回](https://qiita.com/turupon/items/12268ddb95ecd7b7ae07)  
[KafkaをローカルのDocker環境で、さくっと動かしてみました 　第２回](https://qiita.com/turupon/items/59eb602766a38bc3b621)  
