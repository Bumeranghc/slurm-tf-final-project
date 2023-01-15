# Slurm Terraform and Packer Practicum
## For Packer with Ansible provisioner under Ubuntu
Add to /etc/ssh/ssh_config the next lines:
```
PubkeyAcceptedAlgorithms ssh-rsa
HostkeyAlgorithms ssh-rsa
```
## Run Packer
Install in setup Yandex Cloud CLI.
```
cd packer
export YC_TOKEN=$(yc iam create-token)
export YC_IMAGE_TAG=<image number, e.g. 1>
export YC_FOLDER_ID=<folder ID from your account>
export YC_ZONE=<zone, e.g. ru-central1-a>
export YC_SUBNET_ID=<subnet ID from your account, must be located in zone defined by YC_ZONE>
packer build nginx.pkr.hcl
```