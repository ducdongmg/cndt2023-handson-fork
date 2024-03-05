#!/bin/bash

helmfile sync  -f helm/helmfile.yaml

kubectl get service,deployment  -n argo-cd

kubectl apply -f ingress/ingress.yaml
