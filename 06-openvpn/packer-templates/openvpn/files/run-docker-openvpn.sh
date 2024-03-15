#!/usr/bin/env bash

set -euf -o pipefail

# 169.254.169.254는 EC2의 메타 데이터를 가져올 수 있는 메타 데이터 서버.
# EC2 내부에서 아래 URL에 요청을하면 현재 Public IP를 알 수 있음
public_ip=`curl 169.254.169.254/latest/meta-data/public-ipv4`

echo "------------------"
echo $OVPN_NETWORK
echo $OVPN_ROUTES
echo $OVPN_DNS_SERVERS
echo "------------------"
## Run openvpn-ldap-otp container
docker run \
 --name openvpn \
 --restart always \
 --volume openvpn-data:/etc/openvpn \
 --detach=true \
 -p 1194:1194/udp \
 --cap-add=NET_ADMIN \
 -e "OVPN_SERVER_CN=${OVPN_SERVER_CN:-$public_ip}" \
 -e "OVPN_ENABLE_COMPRESSION=false" \
 -e "OVPN_NETWORK=${OVPN_NETWORK:-172.22.16.0 255.255.240.0}" \
 -e "OVPN_ROUTES=${OVPN_ROUTES:-172.22.16.0 255.255.240.0}" \
 -e "OVPN_DNS_SERVERS=${OVPN_DNS_SERVERS}" \
 -e "OVPN_NAT=true" \
 -e "USE_CLIENT_CERTIFICATE=true" \
 wheelybird/openvpn-ldap-otp:v1.4

## Wait to ready OpenVPN Server
until echo "$(docker exec openvpn show-client-config)" | grep -q "END PRIVATE KEY" ;
do
  sleep 1
  echo "working..."
done

## Generate OpenVPN client configuration file
docker exec openvpn show-client-config > /opt/openvpn/fastcampus.ovpn