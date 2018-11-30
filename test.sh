#!/bin/bash

set -e
set -x


kubectl apply -f crds.yaml
kubectl apply -f parent.yaml
uid=$(kubectl get dave/parent -o jsonpath="{.metadata.uid}")
kubectl apply -f <(sed s/DAVE_UID/$uid/g child.yaml)
kubectl delete dave/parent

echo "Successfully cascaded delete with a child resource"

kubectl apply -f crds.yaml
kubectl apply -f parent.yaml
uid=$(kubectl get dave/parent -o jsonpath="{.metadata.uid}")
kubectl apply -f <(sed s/DAVE_UID/$uid/g cluster-child.yaml)
kubectl delete dave/parent

echo "Successfully cascaded delete with a cluster child resource"
