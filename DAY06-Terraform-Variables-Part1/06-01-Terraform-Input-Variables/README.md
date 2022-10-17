# Terraform Input Variables

## Step-00: Introduction
- **v1:** Input Variables - Basics
- **v2:** Provide Input Variables when prompted during terraform plan or apply
- **v3:** Override default variable values using CLI argument `-var` 
- **v4:** Override default variable values using Environment Variables
- **v5:** Provide Input Variables using `terraform.tfvars` files
- **v6:** Provide Input Variables using `<any-name>.tfvars` file with CLI 
argument `-var-file`
- **v7:** Provide Input Variables using `auto.tfvars` files
- **v8-01:** Implement complex type constructors like `list` 
- **v8-02:** Implement complex type constructors like `maps`
- **v9:** Implement Custom Validation Rules in Variables
- **v10:** Protect Sensitive Input Variables
- **v11:** Understand about `File` function

## Pre-requisite
- Create a new EC2 Key pair with name as `terraform-key`
- In all the templates listed below V1 to V12, we will be using `key_name      = "terraform-key"` incase if you want to login to EC2 Instance you can use this key


## Step-01: Input Variables Basics 
- **Reference Sub folder:** v1-Input-Variables-Basic
- Create / Review the terraform manifests
  - c1-versions.tf
  - c2-variables.tf
  - c3-security-groups.tf
  - c4-ec2-instance.tf
- We are going to define `c3-variables.tf` and define the below listed variables
  - aws_region is a variable of type `string`
  - ec2_ami_id is a variable of type `string`
  - ec2_instance_count is a variable of type `number`
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
http://<Public-IP-Address>

# Clean-Up
terraform destroy -auto-approve
rm -rf .terraform*
rm -rf terraform.tfstate*
```

## Step-02: Input Variables Assign When Prompted
- **Reference Sub folder:** v2-Input-Variables-Assign-when-prompted
- Add a new variable in `variables.tf` named `ec2_instance_type` without any default value. 
- As the variable doesn't have any default value when you execute `terraform plan` or `terraform apply` it will prompt for the variable. 

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

## Step-03: Input Variables Override default value with cli argument `-var`
- **Reference Sub folder:** v3-Input-Variables-Override-default-with-cli
- We are going to override the default values defined in `variables.tf` by providing new values using the `-var` argument using CLI
```
# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Option-1 (Always provide -var for both plan and apply)
# Review the terraform plan
terraform plan -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1"

# Create Resources (optional)
terraform apply -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1"

# Option-2 (Generate plan file with -var and use that with apply)
# Generate Terraform plan file
terraform plan -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1" -out v3out.plan

# Create / Deploy Terraform Resources using Plan file
terraform apply v3out.plan 
```

## Step-04: Input Variables Override with Environment Variables
- **Reference Sub folder:** v4-Input-Variables-Override-with-Environment-Variables
- Set environment variables and execute `terraform plan` to see if it overrides default values 
```
# Sample
export TF_VAR_variable_name=value

# SET Environment Variables
export TF_VAR_ec2_instance_count=1
export TF_VAR_ec2_instance_type=t3.large
echo $TF_VAR_ec2_instance_count, $TF_VAR_ec2_instance_type

# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan

# UNSET Environment Variables after demo
unset TF_VAR_ec2_instance_count
unset TF_VAR_ec2_instance_type
echo $TF_VAR_ec2_instance_count, $TF_VAR_ec2_instance_type
```

## Step-05: Assign Input Variables from terraform.tfvars
- **Reference Sub folder:** v5-Input-Variables-Assign-with-terraform-tfvars
- Create a file named `terraform.tfvars` and define variables
- If the file name is `terraform.tfvars`, terraform will auto-load the variables present in this file by overriding the `default` values in `variables.tf`
```
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
http://<Elastic-IP-Address>
```

## Step-06: Assign Input Variables with -var-file argument
- **Reference Sub folder:** v6-Input-Variables-Assign-with-tfvars-var-file
- If we plan to use different names for  `.tfvars` files, then we need to explicitly provide the argument `-var-file` during the `terraform plan or apply`
- We will use following things in this example
  - **c2-variables.tf:** aws_region variable will be picked with default value
  - **terraform.tfvars:** ec2_instance_count variable will be picked from this file
  - **web.tfvars:** ec2_instance_type variable will be picked from this file
  - **app.tfvars:** ec2_instance_type variable will be picked from this file
```
# Initialize Terraform
terraform init

# Validate Terraform configuration files
terraform validate

# Format Terraform configuration files
terraform fmt

# Review the terraform plan
terraform plan -var-file="web.tfvars"
terraform plan -var-file="app.tfvars"
```

## Step-07: Auto load input variables with .auto.tfvars files
- **Reference Sub folder:** v7-Input-Variables-Assign-with-auto-tfvars
- We will create a file with extension as `.auto.tfvars`. 
- With this extension, whatever may be the file name, the variables inside these files will be auto loaded during `terraform plan or apply`
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


## References
- [Terraform Input Variables](https://www.terraform.io/language/expressions/types)
- [Resource: AWS EC2 Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: AWS Security Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Sensitive Variables - Additional Reference](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables)



