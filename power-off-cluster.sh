CLUSTER=$1

echo Cluster: $CLUSTER

RG=$(ibmcloud ks cluster ls | grep $CLUSTER | awk '{ print $10 }')

echo Resource Group: $RG

ibmcloud target -g $RG

ID=$(ibmcloud ks cluster get --cluster $CLUSTER | grep ID: | grep -v "Resource Group ID" | awk '{print $2}')

echo ID: $ID

for vs in $(ibmcloud sl vs list | grep $ID | awk '{ print $1 }')
do
  echo Virtual Machine: $vs
  ibmcloud sl vs power-off $vs -f
done
