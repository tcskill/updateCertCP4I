#!/bin/bash

# delete common services secret
oc delete secret cs-ca-certificate-secret -n ibm-common-services

# force the leaf certificates to be updated
mkdir secret_backup
cd secret_backup

oc get certs -o custom-columns=:spec.secretName,:spec.issuerRef.name --no-headers |egrep "cs-ca-clusterissuer|cs-ca-issuer" | while read secretName issuerName
do
oc get secret $secretName -o yaml -n ibm-common-services > secret.$secretName.yaml
oc delete secret $secretName -n ibm-common-services
done

# restart key pods

oc delete pod -l app=auth-idp -n ibm-common-services
oc delete pod -l app=auth-pap -n ibm-common-services
oc delete pod -l app=auth-pdp -n ibm-common-services


# refresh cluster secret and recreate route if needed (common services < v3.6.2)

csversion=$(oc get subscription ibm-common-service-operator -n ibm-common-services -ojsonpath="{.status.installedCSV}")
csversion=${csversion##ibm-common-service-operator.v3.}
#echo ${csversion}

if (( $(bc <<< "$csversion<6.2") > 0 )); then 
    echo "common services version is older than v3.6.2 - additional cert updates required" 
    oc delete secret ibmcloud-cluster-ca-cert -n ibm-common-services
    oc delete route cp-console -n ibm-common-services ; 
else echo "common services version is v3.6.2 or newer - no additional update required" ;
fi





