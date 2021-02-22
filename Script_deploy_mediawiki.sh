#To install helm in exiting kubernetes cluster
if ! which helm > /dev/null 2>&1; then
     curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
     chmod 700 get_helm.sh
     ./get_helm.sh
     #Init Tiller pod
     helm init --service-account helm
     #Wait for Tiller pod to be up about 50
     sleep 50
fi



#Install helm release
if ! helm ls | grep "my-release" > /dev/null 2>&1; then
    helm install --name my-release stable/mediawiki
fi

#Host name for access mediawiki
export APP_HOST=$(kubectl get svc --namespace default my-release-mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo $APP_HOST
# APP Password for access mediawiki
export APP_PASSWORD=$(kubectl get secret --namespace default my-release-mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)
echo $APP_PASSWORD
export APP_DATABASE_PASSWORD=$(kubectl get secret --namespace default my-release-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)
echo $APP_DATABASE_PASSWORD

#To upgrade existing helm release
helm upgrade my-release stable/mediawiki --set mediawikiHost=$APP_HOST,mediawikiPassword=$APP_PASSWORD,mariadb.db.password=$APP_DATABASE_PASSWORD

echo Username: user
echo Password: $(kubectl get secret --namespace default my-release-mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)
