output "instance_public_ip" {
  value       = aws_instance.bitcoin_node.public_ip
  description = "The public IP address of the Bitcoin node instance."
}