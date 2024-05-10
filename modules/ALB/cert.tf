# The entire section creates a certificate, public zone, and validates the certificate using DNS method.

# Create the certificate using a wildcard for all the domains created in qbdevops.co.uk
resource "aws_acm_certificate" "qbdevops" {
  domain_name       = "*.qbdevops.co.uk"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "qbdevops" {
  name         = "qbdevops.co.uk"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "qbdevops" {
  for_each = {
    for dvo in aws_acm_certificate.qbdevops.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.qbdevops.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "qbdevops" {
  certificate_arn         = aws_acm_certificate.qbdevops.arn
  validation_record_fqdns = [for record in aws_route53_record.qbdevops : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.qbdevops.zone_id
  name    = "tooling.qbdevops.co.uk"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.qbdevops.zone_id
  name    = "wordpress.qbdevops.co.uk"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}

