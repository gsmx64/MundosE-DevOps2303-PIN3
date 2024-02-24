# Loading variables from .env file
source $PWD/.env

kubectl create namespace grafana

helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword=$GRAFANA_ADMIN_PASSWORD \
    --values $GRAFANA_YAML \
    --set service.type=LoadBalancer