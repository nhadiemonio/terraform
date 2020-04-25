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

variable "key-pairs-vars" {
  type = map
  default = {
    user1 = {
      key_name = "user1"
      pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0k4xVUwlk9I+ZxHb4w1YJVxgMgpuWyB57ReZQ7Q15si0jQ63zxlVBg3LSOi/jy1P2HEKA4v6v8zkLpAKa0LA8+MmS7sik5ShYx1vNelGsaUv30JwiJDR0NMWYR9H9JfyopbJ0lcqDETvQEUnseriycx8WyC1Q9uUJAl0sYdseG7dtrXBUWviqYCoKLEer7nQ5FP4eDUQWBLxV4ys4CVdvkqRSeXgslQHaBnTUP4ReUC8iSyAHFAo26UT0JuMdmVNhsydqEedwNBBjWxJTrjCX/EvcZDIkstvW9IVo7xBmUOBp/DNQbFWw/Lt/x1BrR1CyGnGNpV9wwHLECspTrGUl user1"
    },
    user2 = {
      key_name = "user2"
      pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsUQhrhAymHDNQ8EaQIIzCvJhquF1swL6PRqyEhE/hHJvlOmKBk5oc8N5MnBUXRYQjbhXV1Qezs1oRYxO3x7RQ5WqdDFsnVFPHL9WjyqGniC152j173+RW+7Aknp+phaKZGIyZyQYcDTlsOIXh679uHq1E3W6ZaHs1mpa9R6VKEjoVatPfEs4PtxTkhx8x009GxEPTluR8fkeyAJ68Z8uiZbxaTigtwNABKp8XqmD6ogx6LKjwWBPiBUEBRcfY0KBBvJpMnFchj88B1QcdKYd801ow3DkHKu3SnsWj57Cmlywm3o5ZUzFYCymvVEPMfhv0DbAFx4E5FGTQW9mmltBV user2"
    }
  }
}

variable "allow-public-web" {
  type = map
  default = {
    0 = {
      type = "ingress"
      dest_protocol = "tcp"
      dest_from_port = "80"
      dest_to_port = "80"
      src_cidr = ["0.0.0.0/0"]
    },
    1 = {
      type = "ingress"
      dest_protocol = "tcp"
      dest_from_port = "443"
      dest_to_port = "443"
      src_cidr = ["0.0.0.0/0"]
    }
  }
}

variable "allow-restricted-web" {
  type = map
  default = {
    0 = {
      type = "ingress"
      dest_protocol = "tcp"
      dest_from_port = "80"
      dest_to_port = "80"
      src_cidr = ["10.128.0.0/22","10.129.0.0/22"]
    },
    1 = {
      type = "ingress"
      dest_protocol = "tcp"
      dest_from_port = "443"
      dest_to_port = "443"
      src_cidr = ["10.128.0.0/22","10.129.0.0/22"]
     }
   }
}

variable "bastion-host" {
  default = {
    internal_ip = "10.128.0.254"
    ami_id = "ami-0a1a4d97d4af3009b"
    instance_type = "t2.micro"
    key_name = "user1"
  }
}

variable "web-host" {
  default = {
    ami_id = "ami-0a1a4d97d4af3009b"
    instance_type = "t2.micro"
    key_name = "user1"
  }
}

variable "allow-bastion-ssh" {
  default = {
    type = "ingress"
    dest_protocol = "tcp"
    dest_from_port = "22"
    dest_to_port = "22"
    src_cidr = ["10.128.0.254/32"]
  }
}
variable "allow-restricted-ssh" {
  type = map
  default = {
    0 = {
      type = "ingress"
      dest_protocol = "tcp"
      dest_from_port = "22"
      dest_to_port = "22"
      src_cidr = ["0.0.0.0/0"]
    }
  }
}
