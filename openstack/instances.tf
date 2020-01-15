resource "openstack_compute_instance_v2" "elasticsearch" {
  count           = 3
  name            = "${format("elasticsearch-%02d", count.index+1)}"
  flavor_id       = "${var.flavor_id}"
  key_pair        = "${var.ssh_key}"
  security_groups = ["allow-ssh","allow-elasticsearch"]

  block_device {
    uuid                  = "${var.os_image}"
    source_type           = "image"
    volume_size           = "${var.root_vol_size}"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  block_device {
    source_type           = "blank"
    destination_type      = "volume"
    volume_size           = 32
    boot_index            = 1
    delete_on_termination = true
  }

  network {
    name = "${var.internal_network}"
    fixed_ip_v4 = "${format("172.20.128.1%02d", count.index+1)}"
  }
}

resource "openstack_networking_floatingip_v2" "fip_0" {
  pool = "${var.floating_ip_pool}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_0" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_0.address}"
  instance_id = "${openstack_compute_instance_v2.elasticsearch.0.id}"
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "${var.floating_ip_pool}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.elasticsearch.1.id}"
}

resource "openstack_networking_floatingip_v2" "fip_2" {
  pool = "${var.floating_ip_pool}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_2" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_2.address}"
  instance_id = "${openstack_compute_instance_v2.elasticsearch.2.id}"
}

