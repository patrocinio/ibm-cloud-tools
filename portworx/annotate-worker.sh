NODES=$(oc get nodes -o custom-columns=NAME:.metadata.name --no-headers)

oc annotate node $NODES kubeadm.alpha.kubernetes.io/cri-socket=/var/run/crio/crio.sock