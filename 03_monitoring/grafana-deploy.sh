# Loading variables from .env file
source $PWD/.env

echo " > Creating the namespace for Grafana"
kubectl create namespace grafana

echo " > Installing Grafana on EKS"
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword=$GRAFANA_ADMIN_PASSWORD \
    --values $GRAFANA_YAML \
    --set service.type=LoadBalancer

echo "> Verifying the Grafana installation"
kubectl get all -n grafana
sleep 4

echo " > Getting the Grafana admin password"
GRAFANA_ADMIN_PASSWORD=$(kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
echo $GRAFANA_ADMIN_PASSWORD
sleep 6
