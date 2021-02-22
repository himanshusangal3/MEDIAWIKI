# MEDIAWIKI
MEDIAWIKI PROBLEM STATEMENT
###########################################################################################################

Prequisite : Running Kubernetes cluster with kubectl command should be fine.

###########################################################################################################

Objective : Script_deploy_mediawiki.sh  script use for deploy mediawiki pod

#############################################################################################################

Execution : 
Step 1 ) Clone this repo.
Step 2 ) Switch to the master branch
Step 3 ) Go inside the branch and run below command to create service sccount
kubectl create -f helm-service-account.yaml
Step 4 ) Run shell script with below command to deploy all the resources in curret section
sh Script_deploy_mediawiki.sh

###########################################################################################################

Resources creation : Resources will be created when you triggered
NAME:   my-release
LAST DEPLOYED: Sun Feb 21 15:55:26 2021
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME                      DATA  AGE
my-release-mariadb        1     0s
my-release-mariadb-tests  1     0s

==> v1/PersistentVolumeClaim
NAME                            STATUS   VOLUME  CAPACITY  ACCESS MODES  STORAGECLASS  AGE
my-release-mediawiki-mediawiki  Pending  0s

==> v1/Pod(related)
NAME                  READY  STATUS   RESTARTS  AGE
my-release-mariadb-0  0/1    Pending  0         0s

==> v1/Secret
NAME                  TYPE    DATA  AGE
my-release-mariadb    Opaque  2     0s
my-release-mediawiki  Opaque  1     0s

==> v1/Service
NAME                  TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)       AGE
my-release-mariadb    ClusterIP     10.100.242.178  <none>       3306/TCP      0s
my-release-mediawiki  LoadBalancer  10.107.73.144   <pending>    80:31034/TCP  0s

==> v1beta1/StatefulSet
NAME                DESIRED  CURRENT  AGE
my-release-mariadb  1        1        0s

######Get the Mediawiki URL by running:##################################################################
  export APP_HOST=$(kubectl get svc --namespace default my-release-mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
  export APP_PASSWORD=$(kubectl get secret --namespace default my-release-mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)
  export APP_DATABASE_PASSWORD=$(kubectl get secret --namespace default my-release-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)
########Get your MediaWiki login credentials by running:###################################################

echo Username: user

echo Password: $(kubectl get secret --namespace default my-release-mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)
