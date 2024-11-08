#!/bin/bash

# Generate unique customer ID and credentials
CUSTOMER_ID=$1
CUSTOMER_NAME=$2

# Create customer-specific certificates
./scripts/generate-certs.sh $CUSTOMER_ID

# Create customer-specific OpenSearch role and user
./scripts/create-opensearch-user.sh $CUSTOMER_ID

# Generate customer-specific configuration
./scripts/generate-client-config.sh $CUSTOMER_ID $CUSTOMER_NAME

# Create customer deployment package
./scripts/package-client.sh $CUSTOMER_ID