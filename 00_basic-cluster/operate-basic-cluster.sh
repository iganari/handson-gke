#!/bin/bash

echo $1 ## create or delete
echo $2
echo $3

## Create VPC Network

export _pj=$(echo $2)
export _common=$(echo $3)
export _region='asia-northeast1'

gcloud beta compute networks create ${_common}-network \
  --subnet-mode=custom \
  --project ${_pj}

gcloud beta compute networks subnets create ${_common}-subnets \
  --network ${_common}-network \
  --region ${_region} \
  --range 172.16.0.0/12 \
  --project ${_pj}

gcloud beta compute firewall-rules create ${_common}-allow-internal-all \
  --network ${_common}-network \
  --allow tcp:0-65535,udp:0-65535,icmp \
  --project ${_pj}

gcloud beta container clusters create ${_common}-zonal \
  --network ${_common}-network \
  --subnetwork ${_common}-subnets \
  --zone ${_region}-a \
  --num-nodes 3 \
  --preemptible \
  --project ${_pj}

gcloud beta container node-pools delete default-pool \
  --cluster ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_pj}

gcloud beta container node-pools create ${_common}-zonal-nodepool \
  --cluster ${_common}-zonal \
  --zone ${_region}-a \
  --num-nodes 3 \
  --preemptible \
  --project ${_pj}

