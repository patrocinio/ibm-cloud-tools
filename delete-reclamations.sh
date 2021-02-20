LIST=$(ibmcloud resource reclamations -q | tail -n +2 | awk '{print $1}')

for r in $LIST 
do
    echo Deleting reclamation $r
    ibmcloud resource reclamation-delete -f $r
done