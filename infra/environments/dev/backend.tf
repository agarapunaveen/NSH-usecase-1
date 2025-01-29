  terraform {
    backend "s3" {
     bucket = "52297389-dev-1"
    key    = "terraform-dev.tfstate"
    dynamodb_table = "lock-state"
    region = "us-east-1"
    }
  }
 