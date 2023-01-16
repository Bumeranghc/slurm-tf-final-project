labels = {
    "project"   = "slurm",
    "env"       = "lab"
}
cidr_blocks = [
    [
        "10.10.0.0/24"
    ],
    [
        "10.10.1.0/24"
    ],
    [
        "10.10.2.0/24"
    ]
]
resources = {
    disk    = 20
    cpu     = 4
    memory  = 8
}
public_ssh_key_path     = ""
private_ssh_key_path    = ""
az = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
]
vm_count    = 3
