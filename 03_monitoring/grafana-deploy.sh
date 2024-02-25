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

echo " > Exposing Grafana on port $GRAFANA_PUBLIC_PORT (Default: tcp/3000)"
kubectl port-forward -n grafana grafana/grafana $GRAFANA_PUBLIC_PORT:3000 --address 0.0.0.0
sleep 4

# Expose grafana
kubectl -n grafana patch svc grafana/grafana -p '{"spec": {"type": "LoadBalancer"}}'

# Get public domain of grafana
GRAFANA_PUBLIC_DOMAIN=$(kubectl -n grafana get svc grafana/grafana | awk '{print $4}' | grep -v 'EXTERNAL-IP')

echo "---------------------------------------------------------------------"
echo " "
echo " > The external domain to view Grafana is:"
echo " http://$GRAFANA_PUBLIC_DOMAIN:$GRAFANA_PUBLIC_PORT"
echo " "
echo " Grafana admin password is: $GRAFANA_ADMIN_PASSWORD"
echo " "
echo "---------------------------------------------------------------------"
sleep 10
