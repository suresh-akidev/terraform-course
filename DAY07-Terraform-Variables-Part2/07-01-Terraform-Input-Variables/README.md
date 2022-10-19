# Terraform Input Variables

## Step-08: Implement complex type cosntructors like `list` and `maps`
- **Reference Sub folder:** v8-Input-Variables-Lists-Maps
- [Type Constraints](https://www.terraform.io/docs/language/expressions/types.html)
### Step-08-01: Implement Vairable Type as List
- **list (or tuple):** a sequence of values, like ["us-west-1a", "us-west-1c"]. Elements in a list or tuple are identified by consecutive whole numbers, starting with zero.
- Implement List function for variable `ec2_instance_type`
```
# Implement List Function in variables.tf
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t3.micro", "t3.small", "t3.medium"]
}

# Reference Values from List in ec2-instance.tf
instance_type = var.ec2_instance_type[0] --> t3.micro
instance_type = var.ec2_instance_type[1] --> t3.small
instance_type = var.ec2_instance_type[2] --> t3.medium

# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan 
```

### Step-08-02: Implement Vairable Type as Map
- **map (or object):** a group of values identified by named labels, like {name = "Mabel", age = 52}.
- Implement Map function for variable `ec2_instance_tags`
```
# Implement Map Function for tags
variable "ec2_instance_tags" {
  description = "EC2 Instance Tags"
  type = map(string)
  default = {
    "Name" = "ec2-web"
    "Tier" = "Web"
  }

# Reference Values from Map in ec2-instance.tf
tags = var.ec2_instance_tags  

# Implement Map Function for Instance Type
# Important Note: comment "ec2_instance_type" variable with list function
variable "ec2_instance_type_map" {
  description = "EC2 Instance Type using maps"
  type = map(string)
  default = {
    "small-apps" = "t3.micro"
    "medium-apps" = "t3.medium" 
    "big-apps" = "t3.large"
  }

# Reference Instance Type from Maps Variables
instance_type = var.ec2_instance_type_map["small-apps"]
instance_type = var.ec2_instance_type_map["medium-apps"]
instance_type = var.ec2_instance_type_map["big-apps"]

# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan 
```



## Step-09: Implement Custom Validation Rules in Variables
- **Reference Sub folder:** v9-Input-Variables-Validation-Rules
- Understand and implement custom validation rules in variables
- [Terraform Console](https://www.terraform.io/docs/cli/commands/console.html)
- The `terraform console` command provides an interactive console for evaluating expressions.
### Step-09-01: Learn Terraform Length Function
- [Terraform Length Function](https://www.terraform.io/docs/language/functions/length.html)
```t
# Go to Terraform Console
terraform console

# Test length function
Template: length()
length("hi")
length("hello")
length(["a", "b", "c"]) # List
length({"key" = "value"}) # Map
length({"key1" = "value1", "key2" = "value2" }) #Map
```

### Step-09-02: Learn Terraform SubString Function
- [Terraform Sub String Function](https://www.terraform.io/docs/language/functions/substr.html)
```t
# Go to Terraform Console
terraform console

# Test substr function
Template: substr(string, offset, length)
substr("terraform course", 1, 4)
substr("terraform course", 0, 6)
substr("terraform course", 0, 1)
substr("terraform course", 0, 0)
substr("terraform course", 0, 10)
```

### Step-09-03: Implement Validation Rule for ec2_ami_id variable
```
variable "ec2_ami_id" {
  description = "AMI ID"
  type = string  
  default = "ami-0be2609ba883822ec"
  validation {
    condition = length(var.ec2_ami_id) > 4 && substr(var.ec2_ami_id, 0, 4) == "ami-"
    error_message = "The ec2_ami_id value must be a valid AMI id, starting with \"ami-\"."
  }
}
```
- **Run Terraform commands**
```
# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan
```

## Step-10: Protect Sensitive Input Variables
- **Reference Sub folder:** v10-Sensitive-Input-Variables
- [AWS RDS DB Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
- When using environment variables to set sensitive values, keep in mind that those values will be in your environment and command-line history
`Example: export TF_VAR_db_username=admin TF_VAR_db_password=adifferentpassword`
- When you use sensitive variables in your Terraform configuration, you can use them as you would any other variable. 
- Terraform will `redact` these values in command output and log files, and raise an error when it detects that they will be exposed in other ways.
- **Important Note-1:** Never check-in `secrets.tfvars` to git repositories
- **Important Note-2:** Terraform state file contains values for these sensitive variables `terraform.tfstate`. You must keep your state file secure to avoid exposing this data.
```
# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan -var-file="secrets.tfvars"

# Create Resources
terraform apply -var-file="secrets.tfvars"

# Verify Terraform State files
grep password terraform.tfstate
grep username terraform.tfstate 

# Destroy Resources
terraform destroy var-file="secrets.tfvars"

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
```

### Variable Definition Precedence
- [Terraform Variable Definition Precedence](https://www.terraform.io/docs/language/values/variables.html#variable-definition-precedence)


## Step-11: Understand about `File` function
- **Reference Sub folder:** v11-File-Function
- Understand about [Terraform File Function](https://www.terraform.io/docs/language/functions/file.html)

```t
# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan 

# Create Resources
terraform apply 

# Access Application
http://<Public-IP>

# Destroy Resources
terraform destroy -auto-approve
```


## References
- [Terraform Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [Resource: AWS EC2 Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: AWS Security Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Sensitive Variables - Additional Reference](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables)



