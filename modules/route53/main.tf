variable "zone_id" {}
variable "record_name" {}
variable "cloudfront_domain_name" {}
variable "cloudfront_zone_id" {}

resource "aws_route53_record" "frontend" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"
  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}