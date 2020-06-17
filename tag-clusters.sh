ids=$(ibmcloud resource search 'type:k8\-cluster' | grep CRN: | awk '{print $2}')

for id in $ids
do
  echo Cluster: $id
  ibmcloud resource tag-attach --tag-names no-owner --resource-id $id
done
