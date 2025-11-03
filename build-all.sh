#!/usr/bin/env bash

export VERSION=$(date +%Y%m%d%H%M)

for i in nginx-example-app demo-app gitops-deployment-app fixme-app blue-velvet-app; do
    export IMAGE="quay.io/openshift-examples/otq-openshift/${i}:${VERSION}"
    echo "Build and push $IMAGE"
    podman manifest rm $IMAGE

    podman build --manifest ${IMAGE} \
        -f nginx-example-app.Containerfile \
        --platform linux/amd64,linux/arm64 .

    podman manifest push ${IMAGE}
done;
