# Loading variables from .env file
source $PWD/.env

echo " > Creating the namespace for Grafana"
kubectl create namespace grafana

echo " > Installing Grafana on EKS"
#helm install grafana grafana/grafana \
#    --namespace grafana \
#    --set persistence.storageClassName="gp2" \
#    --set persistence.enabled=true \
#    --set adminPassword=$GRAFANA_ADMIN_PASSWORD \
#    --set service.type=LoadBalancer

helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --values $PWD/03_monitoring/grafana/deployment.yaml \
    --set-file grafana-datasources=$PWD/03_monitoring/grafana/datasources.yaml \
    --set-file grafana-providers=$PWD/03_monitoring/grafana/providers.yaml \
    --set-file grafana-dashboards-3119=$PWD/03_monitoring/grafana/dashboards-3119.yaml \
    --set-file grafana-dashboards-6417=$PWD/03_monitoring/grafana/dashboards-6417.yaml \
    --set adminPassword=$GRAFANA_ADMIN_PASSWORD \
    --set service.type=LoadBalancer

# Wait to ensure the grafana is ready.
echo " > Waiting for grafana to be ready..."
sleep 20

echo "> Verifying the Grafana installation"
kubectl get all -n grafana
sleep 4

# Patching the service to LoadBalancer
kubectl -n grafana patch svc grafana -p '{"spec": {"type": "LoadBalancer"}}'

# Get public domain of grafana
GRAFANA_PUBLIC_DOMAIN=$(kubectl -n grafana get svc grafana | awk '{print $4}' | grep -v 'EXTERNAL-IP')

echo "---------------------------------------------------------------------"
echo " "
echo " > The external domain to view Grafana is:"
echo "   http://$GRAFANA_PUBLIC_DOMAIN"
echo "   Admin password: $GRAFANA_ADMIN_PASSWORD"
echo " "
echo "---------------------------------------------------------------------"
sleep 4

export GRAFANA_PUBLIC_DOMAIN
