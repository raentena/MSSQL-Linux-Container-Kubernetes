#!/bin/bash 

HOST=$(hostname)
if [ $HOST != 'master.example.local' ]
then 
echo "Error 23"
exit 23
fi 

yum install haproxy -y &> /dev/null 
if [ $? -ne 0 ]
then
echo "Error" 
exit 24 
fi 

function haconfig()
{
cat <<EOF
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    stats socket /var/lib/haproxy/stats

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend http_front
  bind *:80
  stats uri /haproxy?stats
  default_backend http_back

backend http_back
  balance roundrobin
  server kube 192.168.1.5:80
  server kube 192.168.1.6:80
EOF
}

haconfig > /etc/haproxy/haproxy.cfg 

systemctl enable haproxy &> /dev/null 
systemctl start haproxy &> /dev/null
if [ $? -ne 0 ]
then
echo "Error 25" 
exit 25 
fi 
echo "HAproxy: master.example.local will act as loadbalancer/proxy for ingress"
echo 
echo "                          /--> node1.example.local"
echo "master.example.local -----|"
echo "                          \--> node2.example.local"
echo 