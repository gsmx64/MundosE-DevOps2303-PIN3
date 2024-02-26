# Loading variables from .env file
source $PWD/.env

echo " > Creating the namespace for Grafana"
kubectl create namespace grafana

echo " > Installing Grafana on EKS"
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set-file $PWD/03_monitoring/provisioning/datasources.yaml:/etc/grafana/provisioning/datasources.yaml \
    --set-file $PWD/03_monitoring/provisioning/dashboards/dashboard-3119.json:/etc/grafana/provisioning/dashboards/dashboard-3119.json \
    --set-file $PWD/03_monitoring/provisioning/dashboards/dashboard-6417.json:/etc/grafana/provisioning/dashboards/dashboard-6417.json \
    --set adminPassword=$GRAFANA_ADMIN_PASSWORD \
    --set service.type=LoadBalancer

echo "> Verifying the Grafana installation"
kubectl get all -n grafana
sleep 4

# Patching the service to LoadBalancer
#kubectl -n grafana patch svc grafana -p '{"spec": {"type": "LoadBalancer"}}'

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
