#! /bin/bash
 
echo "starting all journalnode"
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-master2 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-master3 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-worker1 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-worker2 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-worker3 /opt/hadoop/bin/hdfs --daemon start journalnode 
 
echo "starting hadoop-master1..."
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start namenode
sleep 2
echo "starting hadoop-master2..."
docker exec hadoop-master2 /opt/hadoop/bin/hdfs --daemon start namenode
echo "starting hadoop-master3..."
docker exec hadoop-master3 /opt/hadoop/bin/hdfs --daemon start namenode
sleep 2
echo "starting zkfc..."
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start zkfc
echo "starting dfs..."
docker exec hadoop-worker1 /opt/hadoop/sbin/start-dfs.sh
#docker exec hadoop-worker2 /opt/hadoop/sbin/start-dfs.sh
#docker exec hadoop-worker3 /opt/hadoop/sbin/start-dfs.sh
sleep 3
echo "starting yarn..."
docker exec hadoop-master1 /opt/hadoop/sbin/start-yarn.sh
#docker exec hadoop-master2 /opt/hadoop/sbin/start-yarn.sh
#docker exec hadoop-master3 /opt/hadoop/sbin/start-yarn.sh
docker exec hadoop-master1 /opt/hadoop/bin/mapred --daemon start historyserver
echo "Done!"
