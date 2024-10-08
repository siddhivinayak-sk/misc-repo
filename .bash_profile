#!/bin/bash

# generated by Git for Windows
test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc

K8S_CONTEXT=
K8S_NAMESPACE=

d() {
	docker $*
}

k8() { 
    if [ "$#" -eq 0 ]; then
        echo 'K8S_CONTEXT:' $K8S_CONTEXT
        echo 'K8S_NAMESPACE:' $K8S_NAMESPACE
    fi
    if [ -n "$K8S_CONTEXT" ]; then
	    CURRENT_K8S_CONTEXT=$K8S_CONTEXT
    else
	    CURRENT_K8S_CONTEXT=$(kubectl config current-context)
    fi
    if [ -n "$K8S_NAMESPACE" ]; then
	    CURRENT_K8S_NAMESPACE=$K8S_NAMESPACE
    else
	    CURRENT_K8S_NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')
    fi
    export TITLEPREFIX="Git Bash - K8S_CONTEXT: $CURRENT_K8S_CONTEXT   K8S_NAMESPACE: $CURRENT_K8S_NAMESPACE   "
}

k() {
    k8 1
    if [ -n "$K8S_CONTEXT" ] && [ -n "$K8S_CONTEXT" ]; then
        kubectl --context=$K8S_CONTEXT --namespace=$K8S_NAMESPACE  $*
    elif [ -n "$K8S_CONTEXT" ]; then
        kubectl --context=$K8S_CONTEXT  $*
    elif [ -n "$K8S_NAMESPACE" ]; then
        kubectl --namespace=$K8S_NAMESPACE  $*
    else
        kubectl $*
    fi
}

wk() {
    k8 1
    if [ -n "$K8S_CONTEXT" ] && [ -n "$K8S_CONTEXT" ]; then
        winpty kubectl --context=$K8S_CONTEXT --namespace=$K8S_NAMESPACE  $*
    elif [ -n "$K8S_CONTEXT" ]; then
        winpty kubectl --context=$K8S_CONTEXT  $*
    elif [ -n "$K8S_NAMESPACE" ]; then
        winpty kubectl --namespace=$K8S_NAMESPACE  $*
    else
        winpty kubectl $*
    fi
}

h() {
    k8 1
    if [ -n "$K8S_CONTEXT" ] && [ -n "$K8S_CONTEXT" ]; then
        helm --kube-context=$K8S_CONTEXT --namespace=$K8S_NAMESPACE  $*
    elif [ -n "$K8S_CONTEXT" ]; then
        helm --kube-context=$K8S_CONTEXT  $*
    elif [ -n "$K8S_NAMESPACE" ]; then
        helm --namespace=$K8S_NAMESPACE  $*
    else
        helm $*
    fi
}

i() {
    k8 1
    if [ -n "$K8S_CONTEXT" ] && [ -n "$K8S_CONTEXT" ]; then
        istioctl --context=$K8S_CONTEXT --namespace=$K8S_NAMESPACE  $*
    elif [ -n "$K8S_CONTEXT" ]; then
        istioctl --context=$K8S_CONTEXT  $*
    elif [ -n "$K8S_NAMESPACE" ]; then
        istioctl --namespace=$K8S_NAMESPACE  $*
    else
        istioctl $*
    fi
}

kres(){ 
    k set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S) 
}

k8

# This command is used a LOT both below and in daily life
# alias k=kubectl
alias kv='k version'

# Execute a k command against all namespaces
alias kca='f(){ k "$@" --all-namespaces;  unset -f f; }; f'

# Apply a YML file
alias kaf='k apply -f'

# Drop into an interactive terminal on a container
alias keti='k exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='k config use-context'
alias kcsc='k config set-context'
alias kcdc='k config delete-context'
alias kccc='k config current-context'

# List all contexts
alias kcgc='k config get-contexts'

# General aliases
alias kdel='k delete'
alias kdelf='k delete -f'
alias kg='k get'
alias ke='k edit'
alias kd='k describe'

# Pod management.
alias kgp='k get pods'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='k edit pods'
alias kdp='k describe pods'
alias kdelp='k delete pods'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'

# Service management.
alias kgs='k get svc'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='k edit svc'
alias kds='k describe svc'
alias kdels='k delete svc'

# Ingress management
alias kgi='k get ingress'
alias kei='k edit ingress'
alias kdi='k describe ingress'
alias kdeli='k delete ingress'

# Namespace management
alias kgns='k get namespaces'
alias kens='k edit namespace'
alias kdns='k describe namespace'
alias kdelns='k delete namespace'
alias kcn='k config set-context $(k config current-context) --namespace'

# ConfigMap management
alias kgcm='k get configmaps'
alias kecm='k edit configmap'
alias kdcm='k describe configmap'
alias kdelcm='k delete configmap'

# Secret management
alias kgsec='k get secret'
alias kdsec='k describe secret'
alias kdelsec='k delete secret'

# Deployment management.
alias kgd='k get deployment'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='k edit deployment'
alias kdd='k describe deployment'
alias kdeld='k delete deployment'
alias ksd='k scale deployment'
alias ksda='k scale deployment --all'
alias krsd='k rollout status deployment'

# Rollout management.
alias kgrs='k get rs'
alias krh='k rollout history'
alias kru='k rollout undo'

# Port forwarding
alias kpf="k port-forward"

# Tools for accessing all information
alias kga='k get all'
alias kgaa='k get all --all-namespaces'

# Logs
alias kl='k logs'
alias klf='k logs -f'

# File copy
alias kcp='k cp'

# Node Management
alias kgno='k get nodes'
alias keno='k edit node'
alias kdno='k describe node'
alias kdelno='k delete node'

# Exec
alias kx='wk exec -ti'

# Run
alias kr='wk run -ti'

# Misc
alias x='exit'

# Helm
alias hv='h version'
alias hl='h ls -a'
alias hu='h uninstall'


# functions
kgdls() {
   k get deployment | awk -F ' ' '{printf $1" "}' | cut -c6-
}

ksrd() { 
   k scale deployment --replicas=$1 $(kgdls)
}

kf() {
    if [ "$3" ]; then
      k get $1 | grep $2 | awk -F ' ' '{printf $1"\n"}' | head -n $3 | tail -1
    else
      k get $1 | grep $2 | awk -F ' ' '{printf $1" "}'
    fi
}

kgpn() {
    if [ "$2" ]; then
      kf pod $1 $2
    else
	  kf pod $1 1
    fi
}

kgdn() {
    if [ "$2" ]; then
      kf deployment $1 $2
    else
	  kf deployment $1 1
    fi
}

kgcmn() {
    if [ "$2" ]; then
      kf ConfigMap $1 $2
    else
	  kf ConfigMap $1 1
    fi
}

klp() {
   kl $(kgpn $1)
}

klfp() {
   klf $(kgpn $1)
}

kedn() {
   ked $(kgdn $1)
}

kecmn() {
   kecm $(kgcmn $1)
}

kxn() {
   kx $(kgpn $1) -- $2
}

kpfn() {
    if [ "$3" ]; then
      kpf $(kgpn $1) $2 $3
    else
      kpf $(kgpn $1) $2
    fi
}
