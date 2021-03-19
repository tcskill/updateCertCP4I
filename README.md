# updateCertCP4I

This script will automate the update of the certificates for an IBM Cloud Pak for Integration installation.
For the default installation of CP4I, certificates with expiry dates of 3 months are generated so certificates may need to be refreshed after a 3 month period of time.

Note:  This scenario is typical in a development install.  It is highly recommended in a production install to use certificates with a much longer expiry date.


### New in this release 

* Initial release containing the script to rotate the certs
* Coming soon updating the other components of CP4I


### Deploying and Running

```
1.  Clone this repo
2.  cd <updateCertCP4I>\lib
3.  .\updateCerts.sh
```

### Important Prerequisites

This expects that you have a valid openshift token to communicate with the OpenShift server.  If you haven't done this and logged in to OpenShift please do that prior to running this script.





