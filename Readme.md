This document has basic instructions to setup a centralized logging server with Opensearch and Opensearch Dashboards. 

These can be deployed in two formats as listed below

## Contents
1. Docker Compose for local development and testing 
2. As a Kamal accessory

## How to run in Docker 

1. Pull the Repo
2. Create Certificates
> #### Local Certs
>openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout opensearch.key -out opensearch.crt
>
> Create the certificates so that it can be used with a username and password.
> These certs are locally signed, which means they won't be verified by a CA.
> You can look up instructions to create signed certs either on Chatgpt or Claude
3. Run Docker build `docker-compose up --build`
4. Test if Opensearch is running in Localhost: 
> curl -k -u admin:SamplePassword1!  https://localhost:9200/_cat/indices
5. Test Opensearch Dashboard
> Visit http://localhost:5601 (login with username/password)

## Setup as a Kamal Accessory
1. Create the certs as per above instructions if you are self-signing
2. Copy over the `accessory` section to you Kamal Config
3. Update the Host URL for both `Opensearch` and `Opensearch Dashboard` 
4. Make sure the `opensearch-dashboard` env->Host is correctly pointing to the Opensearch Server URL. 
5. Run Kamal deploy
6. Check for errors in the logs `kamal accessory logs opensearch`. 
7. If all looks good, test for Opensearch Server.
> curl -k -u admin:SamplePassword1!  https://5.161.118.44:9200/_cat/indices
8. Visit the Dashboard URL and test. 

I usually mount an external storage with my VPS and use that as the main storage. This is before you trigger
the Kamal job
```
df -h # Lists all drives. Identify your storage. In my case it was `sdb`, located at `/dev/sdb`
mkdir -p /root/storage
mount /dev/sdb /root/storage # Mount the storage
echo "/dev/sdb /root/storage ext4 defaults 0 0" >> /etc/fstab # Ensure it stays mounted after reboot
df -h # To confirm if sdb is mounted to the exact location

# Permissions
cd /root/storage
sudo chown -R 1000:1000 opensearch_data # Docker runs as 1000
sudo chmod 750 opensearch_data/ # Permissions
```