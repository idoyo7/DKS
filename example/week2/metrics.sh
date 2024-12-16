#/bin/bash
# metrics-server
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm upgrade --install metrics-server metrics-server/metrics-server --set 'args[0]=--kubelet-insecure-tls' -n kube-system

kubectl get all -n kube-system -l app.kubernetes.io/instance=metrics-server
kubectl get apiservices |egrep '(AVAILABLE|metrics)'

