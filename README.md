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
Add to `/etc/ssh/ssh_config` the next lines if you have problems with ssh connection for Ansible:
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
Create infrastructure:
```
cd terraform
terraform init
terraform apply --auto-approve
```
## Connect to instances
If you would like to connect to instance from instance group, use an IP from instances_exteranl_ips output and centos as username.
You can provide your public key to set up instances during infrastructure creation using variable `public_ssh_key_path`.

If you don't use your own keys, to get a private key you should run:
```
terraform output -raw private_key
```
## Clear created resources
Destroy created infrastructure:
```
terraform destroy --auto-approve
```
You need to delete an image created with Packer manually from Yandex Cloud.