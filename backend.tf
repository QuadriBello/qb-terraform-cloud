# terraform {
#   backend "s3" {
#     bucket         = "abdulpbl18"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

terraform {
  cloud {
    organization = "qbdevops"

    workspaces {
      name = "qb-terraform-cloud"
    }
  }
}