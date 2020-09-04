#!/bin/bash

# set -x

# echo $1 ## create or delete
# echo $2 ## GCP Project ID
# echo $3 ## Common Value
# echo $4 ## Region

## Create VPC Network

export _pj=$(echo $2)
export _common=$(echo $3)
export _region=$(echo $4)


create-vpc () {
  gcloud beta compute networks create ${_common}-network \
    --subnet-mode=custom \
    --project ${_pj}
}
check-vpc () {
  gcloud beta compute networks list --project ${_pj} --filter="name=( \"${_common}-network\" )"
  # gcloud beta compute networks list --project ${_pj} | grep ${_common}-network
}

create-subnets () {
  gcloud beta compute networks subnets create ${_common}-subnets \
    --network ${_common}-network \
    --region ${_region} \
    --range 172.16.0.0/12 \
    --project ${_pj}
}
check-subnets () {
  gcloud beta compute networks subnets list \
    --network ${_common}-network \
    --project ${_pj} --filter="name=( \"${_common}-subnets\" )"
}

create-firewall () {
  gcloud beta compute firewall-rules create ${_common}-allow-internal-all \
    --network ${_common}-network \
    --allow tcp:0-65535,udp:0-65535,icmp \
    --project ${_pj}
}
check-firewall () {
  gcloud beta compute firewall-rules list \
    --project ${_pj} --filter="name=( \"${_common}-allow-internal-all\" )"
    # --project ${_pj} | grep ${_common}-allow-internal-all
}


# gcloud beta container clusters create ${_common}-zonal \
#   --network ${_common}-network \
#   --subnetwork ${_common}-subnets \
#   --zone ${_region}-a \
#   --num-nodes 3 \
#   --preemptible \
#   --project ${_pj}
# 
# gcloud beta container node-pools delete default-pool \
#   --cluster ${_common}-zonal \
#   --zone ${_region}-a \
#   --project ${_pj} -q
# 
# gcloud beta container node-pools create ${_common}-zonal-nodepool \
#   --cluster ${_common}-zonal \
#   --zone ${_region}-a \
#   --num-nodes 3 \
#   --preemptible \
#   --project ${_pj}
# 


if [ -f $1 ];then
  echo "No Argument"
  exit 1

elif [ $1 = 'create' ]; then
  echo "your type is create"

  check-vpc
  check-subnets
  check-firewall


elif [ $1 = 'delete' ]; then
  echo "your type is delete"

else
  echo "Error"

fi
