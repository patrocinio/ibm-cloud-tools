CLUSTER=$1

echo Cluster: $CLUSTER

target-resource-group.sh $CLUSTER

ID=$(ibmcloud ks cluster get --cluster $CLUSTER | grep ID: | grep -v "Resource Group ID" | awk '{print $2}')

echo ID: $ID

for vs in $(ibmcloud sl vs list | grep $ID | awk '{ print $1 }')
do
  echo Virtual Machine: $vs
  ibmcloud sl vs power-off $vs -f
done
