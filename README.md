# terraform-waf-regional-ip-whitelist
Terraform Module to create a Regional WAF, block access by default and only allowed trusted IPs from a CSV.

**NOTE**: This uses **WAF Classic**. Once WAFv2 is fully implemented in Terraform it will be updated.

## Usage

### CSV Creation
Create a CSV in your root module.  Example format:

```csv
domain,ipcidr,comment
MyTestWAF,192.168.1.1/32,Some comment
```

```hcl
module "waf" {
  source = "git::https://github.com:travisz/terraform-aws-waf-ip-whitelist.git?ref=master"
  waf_name = "MyTestWAF"
  csv_name = "path/to/csv"
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| waf_name | Name of the WAF | string | `` | yes |
| csv_name | CSV file to read (relative to root module path) | string | `` | yes |
