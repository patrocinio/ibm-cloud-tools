CLUSTER=$1

echo Cluster: $CLUSTER

./reset-api-key.sh $CLUSTER

./target-resource-group.sh $CLUSTER

REGION_NAME=$(ibmcloud ks cluster get --cluster $1 | grep "Master Location:" | awk '{print $3}')

echo Region Name: $REGION_NAME

REGION=$(ibmcloud regions | grep $REGION_NAME | head -1 | awk '{print $1}')

echo Region: $REGION

ibmcloud ks cluster rm -f --cluster $CLUSTER
