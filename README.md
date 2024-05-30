# terraform
different terraform scripts

Check out different branches for different cloud providers.

# Deploying VMs in Virtualbox using Terraform Provider terrafarm/virtualbox

Credit to: https://www.roksblog.de/terraform-virtualbox-provider-terrafarm/


Deploy multiple VMs in virtualbox using Terraform and Cloud-init

This very simple terraform manifest can deploy multiple VMs in virtualbox. See my blogpost for more information:

https://www.roksblog.de/terraform-virtualbox-provider-terrafarm/

In order to use this code you must have:

    A machine with Terraform and Virtualbox

In order to run this:

    clone the git repo
    cd into the cloned directory
    We need to adjust PATH variable in PowerShell for vboxmanage binary

 $env:PATH = $env:PATH + ";C:\Program Files\Oracle\VirtualBox"

    run:

 terraform init

    run:

terraform plan

    run:

terraform apply

## Useful links
https://registry.terraform.io/providers/shekeriev/virtualbox/latest/docs

other Providers: https://registry.terraform.io/search/providers?q=virtualbox
