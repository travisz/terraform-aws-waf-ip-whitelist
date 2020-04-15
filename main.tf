locals {
  ip_whitelist = csvdecode(file("${path.root}/${var.csv_name}"))
}

resource "aws_waf_ipset" "ipset" {
  name  = "${var.waf_name}-ipset"

  dynamic "ip_set_descriptors" {
    for_each = local.ip_whitelist

    content {
      type = "IPV4"
      value = ip_set_descriptors.value["ipcidr"]
    }
  }
}

resource "aws_waf_rule" "wafrule" {
  name        = "${var.waf_name}wafrule"
  metric_name = "${var.waf_name}wafrule"

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "wafacl" {
  name        = "${var.waf_name}webacl"
  metric_name = "${var.waf_name}webacl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}
