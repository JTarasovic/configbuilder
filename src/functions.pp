# !file

watch_url() {
    while :;
    do
        curl -s -o /dev/null -w "%{http_code} - %{size_download}\n" --connect-timeout 2 -k "$1";
        sleep "${2:-5}";
    done
}

!ifdef (git) (
clean () {
    old=$(git rev-parse --abbrev-ref HEAD);
    git checkout "${1:-master}" && git pull && git remote prune origin && git br -D "$old"
}
)(# git functions omitted)

!ifdef (aws) (
cf_validate() {
    aws cloudformation validate-template --template-body "file://$1" | jq '.'
}
)(# aws functions omitted)

!ifdef (kubectl) (
node2instance() {
    kubectl get node "$1" -o jsonpath="{.spec.providerID}" | cut -d "/" -f 5
}

pods_ready() {
    namespace="$1"
    label_selector="$2"

    while IFS="|" read -r pod node statuses;
    do
        [[ "$statuses" =~ false ]] && echo "$pod in $namespace has unready containers on instance $node"
    done < <(kubectl -n "$namespace" get pod -l "$label_selector" -o jsonpath='{range .items[*]}{.metadata.name}|{.spec.nodeName}|{.status.containerStatuses[*].ready}{"\n"}{end}')
}
)(# kubectl functions omitted)
