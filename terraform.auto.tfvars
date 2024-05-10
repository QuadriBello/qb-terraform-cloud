region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

# enable_classiclink = "false" 

# enable_classiclink_dns_support = "false" 

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

name = "Abdul"

tags = {
  Environment     = "production"
  Owner-Email     = "moyor_bello@yahoo.co.uk"
  Managed-By      = "Terraform"
  Billing-Account = "1234567890"
}

environment = "dev"

ami-web = "ami-04b70fa74e45c3917"

ami-bastion = ""

ami-nginx = ""

ami-sonar = ""

keypair = "qb-ex"

account_no = "983212811554"

master-username = "abdul"

master-password = "devopspbl"