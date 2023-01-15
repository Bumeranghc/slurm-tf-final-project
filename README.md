# Slurm Terraform and Packer Practicum
## Prepare your environment
Before start, please install and initialize Yandex Cloud CLI, then prepare your environment:
```
export YC_TOKEN=$(yc iam create-token)
export TF_VAR_folder_id=<folder ID from your account>
export TF_VAR_vm_image=nginx
export TF_VAR_vm_image_tag=1
```
## For Packer with Ansible provisioner under Ubuntu
Add to /etc/ssh/ssh_config the next lines:
```
PubkeyAcceptedAlgorithms ssh-rsa
HostkeyAlgorithms ssh-rsa
```
## Run Packer
Create image:
```
cd packer
packer build nginx.pkr.hcl
```
## Run Terraform
```
cd terraform
terraform init
terraform apply --auto-approve
```