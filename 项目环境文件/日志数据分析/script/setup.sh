# SSH 配置检查
docker exec hadoop-master1 ssh -o StrictHostKeyChecking=no hadoop-master2 exit
docker exec hadoop-master1 ssh -o StrictHostKeyChecking=no hadoop-master3 exit
docker exec hadoop-master2 ssh -o StrictHostKeyChecking=no hadoop-master1 exit
docker exec hadoop-master2 ssh -o StrictHostKeyChecking=no hadoop-master3 exit
docker exec hadoop-master3 ssh -o StrictHostKeyChecking=no hadoop-master1 exit
docker exec hadoop-master3 ssh -o StrictHostKeyChecking=no hadoop-master2 exit

# 启动 journalnode
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-master2 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-master3 /opt/hadoop/bin/hdfs --daemon start journalnode

# 可以不启动 worker 节点上的 journalnode
docker exec hadoop-worker1 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-worker2 /opt/hadoop/bin/hdfs --daemon start journalnode
docker exec hadoop-worker3 /opt/hadoop/bin/hdfs --daemon start journalnode

# 初始化 NameNode
docker exec hadoop-master1 bash /opt/hadoop/bin/hdfs namenode -format -force
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start namenode

# Bootstrap Standby
docker exec -it hadoop-master2 bash /opt/hadoop/bin/hdfs namenode -bootstrapStandby -force
docker exec hadoop-master2 /opt/hadoop/bin/hdfs --daemon start namenode

docker exec -it hadoop-master3 bash /opt/hadoop/bin/hdfs namenode -bootstrapStandby -force
docker exec hadoop-master3 /opt/hadoop/bin/hdfs --daemon start namenode

# 停止 DFS
docker exec hadoop-master1 /opt/hadoop/sbin/stop-dfs.sh

# Zookeeper 数据重新格式化（如果需要）
docker exec -it hadoop-master1 bash /opt/hadoop/bin/hdfs zkfc -formatZK -force

# 启动 zkfc 和 DFS/YARN
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon start zkfc
docker exec hadoop-master1 /opt/hadoop/sbin/start-dfs.sh
docker exec hadoop-master1 /opt/hadoop/sbin/start-yarn.sh

docker exec hadoop-master1 /opt/hadoop/sbin/stop-yarn.sh
docker exec hadoop-master1 /opt/hadoop/sbin/stop-dfs.sh
docker exec hadoop-master1 /opt/hadoop/bin/hdfs --daemon stop zkfc
