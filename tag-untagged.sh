#!/bin/bash
clusters=$(ibmcloud ks cluster ls | awk '{print $1}')

for c in $clusters
do
  echo Cluster: $c
  tags=$(ibmcloud resource search "type:k8\-cluster AND name:$c" | grep "Tags:" | awk '{print $2}')
  echo Tags: $tags
  if [[ -n "$tags" && $tags =~ "owner:" ]]
  then
    echo Found owner tag
  else
    echo Unclaimed cluster $c... Tagging it..
    crn=$(ibmcloud resource search "type:k8\-cluster AND name:$c" | grep "CRN:" | awk '{print $2}')
    echo CRN: $crn
    ibmcloud resource tag-attach --tag-names no-owner --resource-id $crn
  fi
done

#ids=$(ibmcloud resource search 'type:k8\-cluster' | grep CRN: | awk '{print $2}')

#for id in $ids
#do
#  echo Cluster: $id
#  ibmcloud resource tag-attach --tag-names no-owner --resource-id $id
#done
