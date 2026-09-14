output "domain_name" {
  description = "Application domain name"
  value       = aws_route53_record.cloudfront_a.fqdn
}

output "a_record_name" {
  description = "Route 53 A record"
  value       = aws_route53_record.cloudfront_a.name
}

output "aaaa_record_name" {
  description = "Route 53 AAAA record"
  value       = aws_route53_record.cloudfront_aaaa.name
}