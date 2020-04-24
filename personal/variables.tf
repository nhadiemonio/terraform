variable "user-list" {
  type = list
  default = [
    "test-user-1",
    "test-user-2",
    "test-user-3"
  ]
}

variable "test-group-managed-policy" {
  type = list
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess"
  ]
}

variable "frontend-vpc-vars" {
  default = {
    cidr = "10.128.0.0/16"
    name = "frontend-vpc"
  }
}

variable "backend-vpc-vars" {
  default = {
    cidr = "10.129.0.0/16"
    name = "backend-vpc"
  }
}
variable "frontend-subnet-vars" {
  type = map
  default = {
    az1 = {
      subnet = "10.128.0.0/24"
      az = "ap-southeast-2a"
      name = "frontend-subnet-a"
    },
    az2 = {
      subnet = "10.128.4.0/24"
      az = "ap-southeast-2b"
      name = "frontend-subnet-b"
    },
    az3 = {
      subnet = "10.128.8.0/24"
      az = "ap-southeast-2c"
      name = "frontend-subnet-c"
    }
  }
}

variable "backend-subnet-vars" {
  type = map
  default = {
    az1 = {
      subnet = "10.129.0.0/24"
      az = "ap-southeast-2a"
      name = "backend-subnet-a"
    },
    az2 = {
      subnet = "10.129.4.0/24"
      az = "ap-southeast-2b"
      name = "backend-subnet-b"
    },
    az3 = {
      subnet = "10.129.8.0/24"
      az = "ap-southeast-2c"
      name = "backend-subnet-c"
    }
  }
}




