provider "aws" {
  version = "~> 2.8"
  region = "ap-southeast-2"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}