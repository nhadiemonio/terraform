variable "ssh_key" {
        default = "ron-ramos"
}

variable "flavor_id" {
        default = "3"
}

variable "root_vol_size" {
        default = "64"
}

variable "os_image" {
        default = "3e5597c5-4ee9-46a2-99c0-d21974e428e5"
}

variable "internal_network" {
        default = "default-sre-internal"
}

variable "floating_ip_pool" {
	default = "floating-ip-1255-net"
}
