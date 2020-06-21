  CLUSTER=$1

#  ./target-resource-group.sh $1

REGION_NAME=$(ibmcloud ks cluster get --cluster $1 | grep "Master Location:" | awk '{print $3}')

echo Region Name: $REGION_NAME

REGION=$(ibmcloud regions | grep $REGION_NAME | awk '{print $1}')

echo Region: $REGION

yes | ibmcloud ks api-key reset --region $REGION
