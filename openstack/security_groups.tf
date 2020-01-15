resource "openstack_networking_secgroup_v2" "allow-elasticsearch" {
  name        = "allow-elasticsearch"
  description = "allow-elasticsearch"
}

resource "openstack_networking_secgroup_rule_v2" "allow-elasticsearch-9200-01" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9200
  port_range_max    = 9200
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.allow-elasticsearch.id}"
}

resource "openstack_networking_secgroup_rule_v2" "allow-elasticsearch-9300-01" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9300
  port_range_max    = 9300
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.allow-elasticsearch.id}"
}

