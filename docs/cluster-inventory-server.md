
## Server 

- Launch `cluster-inventory` and `pubkey-share` containers
  ```bash
  podman run -d --network=host --name=pubkey-share flight-pubkey-share
  podman run -d --network=host --name=cluster-inventory flight-cluster-inventory
  ```
- Check ports open
  ```bash
  ss -tulpn |grep -E '8888|1234'
  ```
- Check hunter inventory
  ```bash
  podman exec -it cluster-inventory /root/bin/hunter list --buffer
  ```

## Client

- Send a packet
  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"hostid": "123456", "hostname": "myhost", "content": "none", "label": "mylabel", "auth_key": "hunter"}' http://SERVER_IP:8888
  ```
- Get SSH pub key
  ```bash
  socat -u TCP:SERVER_IP:1234 STDOUT >> /root/.ssh/authorized_keys
  ```
