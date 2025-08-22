Ansible architecture
configuration management
variables ---> prefernces
conditions
loops
functions or filters
data types
developed playbooks
roles
Tags, Dynamic inventory, vault, using ssm parameter store, handlers, include import role ...


ansible server ----> modules/collections -----> remote host
ansible is devloped using pyhon

roboshop create user  ----> node js
frontend -----> html,css,js ----> name,email,password
adduser(name,email,password){
    ifuseralreadyexsits
    if notavailable create user
    send reponse to frontend


}


roboshop create user using ansible:
------------------------------------
custom module
library ----> roles can also include custom modules
write python code
myroboshop.createuser
    name:
    email:
    password:
ansible executes modules/collectiions are in remote server

plugins: lookup('amazon.aws_ssm','name','region:'') ----> ansible server
plugins add extra functionlity to the ansible server like lookup,inventory, filter.....

myroboshop.addcart
    product_name:
    product_id:
you want to check the prize before adding to the cart
lookup('roboshop.checkproduct','product_id:'123')


ansible is very poor in state mangement
ex: if someone edits the infra m,anullay in console ansible cannotdetect it may create duplictae resources if you run again

ansible is perfect for doing configurations within the server

manually created infra:
===========================
time
errors
if something goes wrong tracking is very diffcult
restoring infra is time taking
version control

## ✅ Benefits of Infrastructure as Code (IaC)

- **Version Control**  
  Enables:
  - Change tracking
  - Code reviews
  - Collaboration using Git
  - Rollbacks and audits

- **CRUD Operations Simplified**  
  Easy to Create, Read, Update, and Delete infrastructure through code.

- **Consistency Across Environments**  
  Avoid the "works in dev, fails in prod" issue by replicating the same infra in every environment.

- **Inventory Management**  
  Easily understand what resources are in use by reading the code.

- **Cost Efficiency**  
  - Automatically shut down resources during non-business hours.
  - Schedule start/stop based on usage.

- **Dependency Management**  
  Automatically handles relationships between resources (e.g., attach an instance to a VPC or subnet).

- **Modular Approach**  
  Use reusable Terraform modules for better code structure and DRY principles.

---

## ⚙️ Installing Terraform on Windows

1. **Download Terraform:**
   - Go to [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
   - Select `AMD64` version for Windows

2. **Extract & Place:**
   - Unzip the Terraform binary
   - Place it in a folder (e.g., `C:\Softwares\Terraform`)

3. **Set System Path:**
   - Go to `System Properties` → `Advanced` → `Environment Variables`
   - Under `System variables`, find `Path` → `Edit` → `Add` the Terraform folder path

4. **Verify Installation:**
   ```bash
   terraform --version
   ```

---
## 🚀 Getting Started with Terraform & AWS

1. **Create Terraform GitHub Repo**
   ```bash
   git clone <your_repo_url>
   cd terraform/
   ```

2. **Define Provider Configuration (`provider.tf`)**
   Example for AWS:
   ```hcl
   provider "aws" {
     region = "us-east-1"
   }
   ```

3. **Configure AWS CLI**
   ```bash
   aws configure
   ```

4. **Terraform Commands**
   ```bash
   terraform init            # Initialize the project
   terraform plan            # Show what will be created/changed
   terraform apply           # Apply changes
   terraform apply -auto-approve  # Apply without manual approval
   ```
  ## Terraform variables:
  To store the values we can use wherver we want. It is DRY prinicple
   
   ```
## Step 4: Variables

- Variables allow you to set default values.
- If you don't want to use default values, you can override them.

### Ways to Override Variables (Precedence Order):

1. **Command Line**
   ```bash
   terraform plan -var "sg_name=cmd_allow_all"
   ```
2. **`.tfvars` File**
   - Use a file like `variables.tfvars` to store variable values.
3. **Environment Variables**
   ```bash
   export TF_VAR_sg_name=env_allow_all
   unset TF_VAR_sg_name  # Unset to fall back to default
   ```
4. **Default Values**
5. **Prompt Input**
   - If no value is provided, Terraform will prompt for it.

## Step 5: Conditions

Use a ternary expression like this:
```hcl
condition ? "this value is true" : "this value is false"
```

## Step 6: Loops

### 1. Count-Based Loops
- Define `count` in the resource block.
- Use `count.index` to iterate over the instances.

### 2. For Loops

tomap:{}
toset:[]

Use based on data structure:
- Use `count` if you have a **list**
- Use `for_each` if you have a **map or set**


## Step 7: Interpolation

- Combine variables with strings using `${}` syntax:
  ```hcl
  "Security group name is ${var.sg_name}"
  ```

- Use **dynamic block** for complex nested structures.
Dynamic block:
=================
ex: we have ingress and outgress that is not key values we need to change port number(22,.....)
for this we will use dyanamic loops

dynamic: here we need to mention the repeative blocks

dynamic "setting" {
    for_each = var.settings
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}

functions:
============
we cannot define our own functions in terraform 
we need to use builtin functions

common tags:
version =1.0
terraform= true
project= roboshop

variable tags:
component =cart
name= cart
version=1.1

merge tags:
version =1.1
terraform= true
project= roboshop
component =cart
name= cart


Data sources:
=============
variables ----> inputs
outputs -----> print the info after creating the resources

it can query the info from the provider

locals:
============
locals can have expressions,you can assign a name to it and use it wherever you require

local are like variables holding the values agianst keys,
but you can refer variables inside locals,expressions,functions....

can we override the values that given in variables?
no we can't
variables override: we can mention in variables that want to override
locals override: we can mention those variables that no need to override

variables can be overriden, locals cannot be ovveriden

state:
=======
Iaac: Declarative way of creating infra, whatever we declare Iaac tool should follow the
 sysntax

on which files are declaring 
.tf files ---> it contain desired or declarative  infra ----> expetation
what exsits in aws ---> actual infra ----> reality
state files ---> terraform use this file to track what is created in provider

terraform plan
=============
reads .tf ---> understand what user wants
read state file ---> empty ---> it is not created and also
query the provider ---> to check alreday infra exsits or not

it starts create
terraform apply:

created infra
terraform plan:
reads .tf files,state file ----> matched

i deleted instance	in console manullay
reads .tf files,state file ----> not matched
check provider to verify desired infra vs actual infra


when you change tf files
=======================
.tf ---> understand what user wants
state file ---> not matched

actual infra ----> user don't want route r53 records

terraform uses state files to track what is created in the provider every time.
we run terraform commands terraform check whether the desired infra is matched or not with actula infra thourht the stae file

we cannot put .state files in local for this we user s3 buckets

s3bucket: (state.tf)
=================
keeping state file in local will not work in collabarative environment.
terraform doesn't understand what are the resources created by others
so it may create duplicate resources or else it will give erros


DynamoDB:
===========
- we need to create table in dynamo db
DynamoDB ---> tables ---> create table ----> name ----> partition key (LockID) --> create
for locking purpose we will use dyanamo db
- to see the state file
DynamoDB ---> tables ---> created table ----> expore items ---> it conatin state file
same state file is available under s3 bucket

native locking:
-------------
no need to depend on anything
use lock file and encrypt 

Previously we used dynamodb in my project but recently we migrated into s3 native locking



provisioners:
===========
when you create the server using terraform. we can take some actions using provisioners
1.local-exec
2.remote-exec

where i am running terraform command that is local to terraform (laptop)
remote means server i created using terraform

After creating server if i do any actions in local that is local-exec
After creating server if i do any actions in remote that is remote-exec

failure behaviour:
------------------------
if we get any error it agian create from the scratch so we don't want to stop we will face any error then we can use
on_failure = continue means it will not recreate

here we have 2 types of provinsers
creation time provisioners
destory time provisioners

provisioners will run during creation time. If yu want to run while destory we can use
when = destroy

remote exec:
means we need to connect to the server for this we need credinatilas. bacuse we cannot connect directly.





