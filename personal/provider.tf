provider "aws" {
  version = "~> 2.8"
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}

