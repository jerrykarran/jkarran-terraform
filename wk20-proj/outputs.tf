output "Jenkins_Server" {
  description = "Output the ID for the Jenkins Server"
  value       = aws_instance.jenkins_server.id
}

output "Security_Group" {
  description = "Security Grouyp for our Web Server"
  value       = aws_security_group.jenkins_security_group.id
}