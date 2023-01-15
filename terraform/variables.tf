locals {
    prefix = "slurm-"
}

variable "cidr_blocks" {
    type        = list(list(string))
    description = "List of CIDRs for subnets."
}

variable "labels" {
    type        = map(string)
    description = "List of labels for resources."
}

variable "resources" {
    type        = object({
        disk = number
        cpu = number
        memory = number
    })
    description = "Resources for instances."
}

variable "public_ssh_key_path" {
    type        = string
    description = "SSH public key path to copy to instance."
}

variable "private_ssh_key_path" {
    type        = string
    description = "SSH private key path to copy to instance."
}

variable "az" {
    type        = list(string)
    description = "List of availability zones."
}

variable "vm_count" {
    type        = number
    description = "Number of instances."    
}

variable "vm_image" {
    type        = string
    description = "Image name for instance." 
}

variable "vm_image_tag" {
    type        = string
    description = "Image tag for instance."    
}

variable "folder_id" {
  type = string
  description = "Folder ID for your account." 
}
