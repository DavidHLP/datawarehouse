#! /bin/bash
echo "====================hadoop-master1:status===================="
docker exec hadoop-master1 jps
echo "====================hadoop-master2:status===================="
docker exec hadoop-master2 jps
echo "====================hadoop-master3:status===================="
docker exec hadoop-master3 jps
echo "====================hadoop-worker1:status===================="
docker exec hadoop-worker1 jps
echo "====================hadoop-worker2:status===================="
docker exec hadoop-worker2 jps
echo "====================hadoop-worker3:status===================="
docker exec hadoop-worker3 jps
echo "=========================zoo1:status========================="
docker exec zoo1 /apache-zookeeper-3.7.1-bin/bin/zkServer.sh status
echo "=========================zoo2:status========================="
docker exec zoo2 /apache-zookeeper-3.7.1-bin/bin/zkServer.sh status
echo "=========================zoo3:status========================="
docker exec zoo3 /apache-zookeeper-3.7.1-bin/bin/zkServer.sh status
echo "============================================================="