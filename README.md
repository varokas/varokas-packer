# Packer

## Prerequisite
* Packer `brew install packer`

## Prerequisite GCP

* GCloud `brew install google-cloud-sdk`
* Enable gcloud services
```
gcloud services enable sourcerepo.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable servicemanagement.googleapis.com
gcloud services enable storage-api.googleapis.com
```
* Enable default auth
```
gcloud auth application-default login
```

## Install
```
packer build -force jamulus.pkr.hcl 
```

## Ref
* https://cloud.google.com/build/docs/building/build-vm-images-with-packer
