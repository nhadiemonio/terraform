variable "test-group-managed-policy" {
  type = list
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess"
  ]
}

variable "frontend-vpc-vars" {
  default = {
    cidr = "10.0.0.0/16"
    name = "frontend-vpc"
  }
}

variable "backend-vpc-vars" {
  default = {
    cidr = "10.1.0.0/16"
    name = "backend-vpc"
  }
}
variable "frontend-subnet-vars" {
  type = map
  default = {
    az1 = {
      subnet = "10.0.0.0/24"
      az = "ap-southeast-1a"
      name = "frontend-subnet-a"
    },
    az2 = {
      subnet = "10.0.4.0/24"
      az = "ap-southeast-1b"
      name = "frontend-subnet-b"
    },
    az3 = {
      subnet = "10.0.8.0/24"
      az = "ap-southeast-1c"
      name = "frontend-subnet-c"
    }
  }
}

variable "backend-subnet-vars" {
  type = map
  default = {
    az1 = {
      subnet = "10.1.0.0/24"
      az = "ap-southeast-1a"
      name = "backend-subnet-a"
    },
    az2 = {
      subnet = "10.1.4.0/24"
      az = "ap-southeast-1b"
      name = "backend-subnet-b"
    },
    az3 = {
      subnet = "10.1.8.0/24"
      az = "ap-southeast-1c"
      name = "backend-subnet-c"
    }
  }
}




