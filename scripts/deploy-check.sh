#!/usr/bin/env bash

set -u

DEPLOYMENT="${1:-dummy-service}"
NAMESPACE="${2:-default}"
TIMEOUT="${3:-90s}"

echo "======================================"
echo " Kubernetes Deployment Check"
echo "======================================"
echo "Deployment : $DEPLOYMENT"
echo "Namespace  : $NAMESPACE"
echo "Timeout    : $TIMEOUT"
echo

echo "Checking deployment..."
if ! kubectl get deployment "$DEPLOYMENT" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "ERROR: Deployment '$DEPLOYMENT' was not found."
    exit 1
fi

echo "Waiting for rollout to complete..."
echo

if kubectl rollout status \
    deployment/"$DEPLOYMENT" \
    -n "$NAMESPACE" \
    --timeout="$TIMEOUT"; then

    echo
    echo "SUCCESS: Rollout completed successfully."

    echo
    echo "Deployment status:"
    kubectl get deployment "$DEPLOYMENT" -n "$NAMESPACE"

    echo
    echo "Pod status:"
    kubectl get pods -n "$NAMESPACE" \
        -l app="$DEPLOYMENT" \
        -o wide

    exit 0

else

    echo
    echo "ERROR: Rollout did not complete within $TIMEOUT."
    echo "Deployment is considered FAILED."

    echo
    echo "Deployment status:"
    kubectl get deployment "$DEPLOYMENT" -n "$NAMESPACE"

    echo
    echo "Pod status:"
    kubectl get pods -n "$NAMESPACE" \
        -l app="$DEPLOYMENT" \
        -o wide

    echo
    echo "Recent deployment events:"
    kubectl describe deployment "$DEPLOYMENT" -n "$NAMESPACE" | tail -40

    exit 1
fi
