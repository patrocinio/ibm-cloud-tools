CLUSTER=$1

echo Cluster: $CLUSTER

RG=$(ibmcloud ks cluster ls | grep $CLUSTER | awk '{ print $10 }')

echo Resource Group: $RG

ibmcloud target -g $RG
