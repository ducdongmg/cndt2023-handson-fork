#!/bin/bash

helmfile sync -f helm/helmfile.yaml
kubectl get pods -n prometheus
kubectl apply -f ingress.yaml
