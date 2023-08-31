plugin "terraform" {
    // Plugin common attributes
    enabled = true
    preset = "all"
}

plugin "aws" {
    enabled = true
    version = "0.21.1"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
