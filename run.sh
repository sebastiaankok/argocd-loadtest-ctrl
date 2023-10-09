#!/bin/bash

function create {
    i=$1
    cat << EOF > app-$1.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app${i}
  labels:
    load-test: 'true'
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    namespace: default
    name: 03795-sebastiaan-playground
  project: default
  source:
    kustomize:
      namePrefix: app${i}
    path: kustomize-guestbook
    repoURL: https://github.com/argoproj/argocd-example-apps
    targetRevision: HEAD
  syncPolicy:
    automated: {}
EOF
}

for i in {1..25}
do
   create $i &
done

wait
