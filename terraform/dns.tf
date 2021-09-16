resource "aws_route53_zone" "interview" {
  name = "interview.foston.me"
}

resource "aws_route53_record" "load_balancer" {
  name    = "www"
  type    = "A"
  zone_id = aws_route53_zone.interview.id

  alias {
    name                   = aws_elb.web.dns_name
    zone_id                = aws_elb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "web_servers" {
  count   = length(aws_instance.web)
  name    = "www${count.index + 1}"
  type    = "A"
  zone_id = aws_route53_zone.interview.zone_id
  records = [aws_instance.web[count.index].public_ip]
  ttl     = 300
}

output "zone_name_servers" {
  value = aws_route53_zone.interview.name_servers
}
