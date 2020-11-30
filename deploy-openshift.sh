VPC=patrocinio-vpc
SG=patrocinio-security-group

#ibmcloud login -r us-south -g patrocino-resource-group --sso

#ibmcloud is target --gen 2

function create_gateway {
    ibmcloud is public-gateway-create gateway-us-south-1 $VPC_ID us-south-1
}

function create_subnet {
    GATEWAY_ID=$(ibmcloud is public-gateways | grep gateway-us-south-1 | awk '{ print $1 }')

    echo Gateway: $GATEWAY_ID

    ibmcloud is subnet-create mysubnet1 $VPC_ID --zone us-south-1 --ipv4-address-count 256 --public-gateway-id $GATEWAY_ID
}

function add_sg_rule {
    ibmcloud is security-group-rule-add $SG_ID inbound tcp --port-min 30000 --port-max 32767
}

function create_object_storage {
    ibmcloud resource service-instance-create myvpc-cos cloud-object-storage standard global
}

function create_openshift {
    echo Creating an OpenShift cluster
    ibmcloud oc cluster create vpc-gen2 --name myvpc-cluster --zone us-south-1 --version 4.5_openshift --flavor bx2.4x16 \
        --workers 2 --vpc-id $VPC_ID --subnet-id $SG_ID --cos-instance "$COS_ID"
}

VPC_ID=$(ibmcloud is vpcs | grep $VPC | awk '{ print $1 }')
echo VPC: $VPC_ID

#create_gateway
#create_subnet

SG_ID=$(ibmcloud ks subnets --provider vpc-gen2 --vpc-id $VPC_ID --zone us-south-1 | grep mysubnet1 | awk '{ print $2 }')
echo Subnet: $SG_ID

#add_sg_rule
#create_object_storage

COS_ID=$(ibmcloud resource service-instance myvpc-cos | grep ID | awk '{ print $2 }')
echo COS ID: $COS_ID

create_openshift

