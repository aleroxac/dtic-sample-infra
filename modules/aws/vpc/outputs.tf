## ----- vpc
output "vpc_ids" {
  description = "Map of VPC identifiers to their corresponding VPC IDs."
  value       = { for k, v in aws_vpc.vpcs : k => v.id }
}



## ----- subnet
output "subnet_ids" {
  description = "Map of subnet identifiers to their corresponding subnet IDs."
  value       = { for k, v in aws_subnet.subnets : k => v.id }
}



## ----- internet-gateway
output "igw_ids" {
  description = "Map of Internet Gateway identifiers to their corresponding IGW IDs."
  value       = { for k, v in aws_internet_gateway.igws : k => v.id }
}



## ----- network-acl
output "net_acl_ids" {
  description = "Map of Network ACL identifiers to their corresponding IDs."
  value       = { for k, v in aws_network_acl.nacls : k => v.id }
}



## ----- route-table
output "route_table_ids" {
  description = "Map of route table identifiers to their corresponding IDs."
  value       = { for k, v in aws_route_table.route_tables : k => v.id }
}



## ----- elastip-ip
output "eip_ids" {
  description = "Map of Elastic IP identifiers to their corresponding allocation IDs."
  value       = { for k, v in aws_eip.eips : k => v.id }
}

output "eip_public_ips" {
  description = "Map of Elastic IP identifiers to their corresponding public IPs."
  value       = { for k, v in aws_eip.eips : k => v.public_ip }
}



## ----- nat-gateway
output "nat_gw_ids" {
  description = "Map of NAT Gateway identifiers to their corresponding IDs."
  value       = { for k, v in aws_nat_gateway.nat_gateways : k => v.id }
}
