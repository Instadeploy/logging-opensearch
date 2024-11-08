#!/bin/bash

# Create certs directory if it doesn't exist
mkdir -p certs

# Generate root CA
openssl genrsa -out certs/root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key certs/root-ca-key.pem -subj "/C=US/ST=State/L=City/O=Org/CN=RootCA" -out certs/root-ca.pem -days 730

# Generate node certificate
openssl genrsa -out certs/node-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in certs/node-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out certs/node-key.pem
openssl req -new -key certs/node-key.pem -subj "/C=US/ST=State/L=City/O=Org/CN=node" -out certs/node.csr
openssl x509 -req -in certs/node.csr -CA certs/root-ca.pem -CAkey certs/root-ca-key.pem -CAcreateserial -sha256 -out certs/node.pem -days 730

# Generate admin certificate
openssl genrsa -out certs/admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in certs/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out certs/admin-key.pem
openssl req -new -key certs/admin-key.pem -subj "/C=US/ST=State/L=City/O=Org/CN=admin" -out certs/admin.csr
openssl x509 -req -in certs/admin.csr -CA certs/root-ca.pem -CAkey certs/root-ca-key.pem -CAcreateserial -sha256 -out certs/admin.pem -days 730

# Clean up temporary files
rm certs/*-temp.pem certs/*.csr certs/*.srl

# Set proper permissions
chmod 600 certs/*.pem

echo "Certificates generated successfully in the certs directory"