# Ansible

* Ansible architecture
* configuration management
* variables ---> prefernces
* conditions
* loops
* functions or filters
* data types
* developed playbooks
* roles
* Tags, Dynamic inventory, vault, using ssm parameter store, handlers, include import role ...

# Ansible Basics

Ansible server ----> modules/collections -----> remote host

Ansible is developed using Python


roboshop create user  ----> node js
frontend -----> html,css,js ----> name,email,password
adduser(name,email,password){
    ifuseralreadyexsits
    if notavailable create user
    send reponse to frontend


}


# Ansible - Roboshop Example & Concepts

## Custom Module (Roboshop - Create User)

* Custom modules can be created using **Python**
* Stored inside:

  * `library/` directory
  * Can also be included inside **roles**

### Example Module:

```
myroboshop.createuser
    name:
    email:
    password:
```

* Ansible executes **modules/collections on remote servers**

---

## Plugins in Ansible

* Plugins add extra functionality to the **Ansible server (control node)**
* Types include:

  * lookup
  * inventory
  * filter

### Example:

```
lookup('amazon.aws_ssm', 'name', 'region:')
```

---

## Roboshop Example - Add to Cart

### Module:

```
myroboshop.addcart
    product_name:
    product_id:
```

### Condition Check Before Adding:

* Check product price before adding to cart:

```
lookup('roboshop.checkproduct', 'product_id:123')
```

---

## Limitations of Ansible (State Management)

* Ansible is **poor in state management**
* Example:

  * If someone manually modifies infrastructure in console
  * Ansible **cannot detect drift**
  * Running again may create **duplicate resources**

---

## Where Ansible Excels

* Best suited for:

  * Configuration management
  * Managing software inside servers
  * Automating setup and deployments

* Not ideal for:

  * Infrastructure state tracking (compared to Terraform)

---


# Manually Created Infrastructure - Challenges

## Issues

* Time consuming
* Prone to errors
* Difficult to track issues if something goes wrong
* Restoring infrastructure takes a lot of time
* No proper version control


##  Benefits of Infrastructure as Code (IaC)

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

# dynamic block
- It is used for complex nested structures.
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

# functions:
- we cannot define our own functions in terraform 
- we need to use builtin functions

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

# Locals

* Locals can have expressions; you can assign a name to them and use them wherever required.
* Locals are reusable values inside the Terraform code.
* Locals are like variables that hold values against keys.
* You can refer to variables, expressions, and functions inside locals.

Can we override the values given in variables?

* Yes, variables can be overridden.

Variables override:

* We can override variables using tfvars files, CLI arguments, or default values.

Locals override:

* Locals cannot be overridden; they are fixed once defined.

Final point:

* Variables can be overridden, locals cannot be overridden.


# State

Infrastructure as Code (IaC):

* A declarative way of creating infrastructure, where we define the desired state and the IaC tool follows the syntax to provision it.

Where do we declare infrastructure?

* `.tf` files → contain the desired (declarative) infrastructure → expectation

What exists in AWS?

* Actual infrastructure → reality

State files:

* Terraform uses state files to track what resources are created in the provider (e.g., AWS).
* It helps Terraform compare desired state (code) with actual state (real infrastructure).

# Terraform Plan & Apply

## Terraform Plan

* Reads `.tf` files → understands what the user wants (desired state).
* Reads the state file → checks what is already created.
* Queries the provider (e.g., AWS) → verifies if infrastructure already exists.
* Compares desired state vs actual state and shows what will be created/changed.

## Terraform Apply

* Executes the changes from the plan.
* Creates/updates infrastructure in the provider.
* Updates the state file after successful creation.

## Scenario

Initial run:

* State file is empty → nothing is created yet.
* Terraform plans to create resources.

After apply:

* Infrastructure is created.
* State file and `.tf` files are in sync (matched).

Manual change (e.g., instance deleted in console):

* `.tf` files and state file → still show resource exists.
* Actual infrastructure → resource is missing.
* Terraform detects mismatch by checking provider.
* Plan shows changes needed to fix drift (recreate resource).



# When You Change .tf Files

* `.tf` files → Terraform understands what the user now wants (new desired state).
* State file → does not match the updated `.tf` configuration.

Example:

* Actual infrastructure → user no longer wants Route53 records.

What Terraform does:

* Terraform uses the state file to track what is created in the provider.

* When you run Terraform commands, it compares:

  * Desired state (`.tf` files)
  * Current state (state file)
  * Actual infrastructure (provider, e.g., AWS)

* If there is a mismatch, Terraform plans changes to make actual infrastructure match the desired state.

State file storage:

* We should not keep `.tfstate` files locally (not recommended for teams).
* Instead, we store state files remotely using S3 buckets (remote backend).



# S3 Bucket (Remote State)

* Keeping the state file locally will not work in a collaborative environment.
* Terraform will not understand what resources are created by other team members.
* This can lead to:

  * Duplicate resource creation
  * Errors or conflicts during deployment

Solution:

* Store the Terraform state file in a remote backend like an S3 bucket.
* This allows all team members to share the same state and work consistently.



# DynamoDB (State Locking)

* We need to create a table in DynamoDB.
* Go to: DynamoDB → Tables → Create Table →

  * Table name: (any name)
  * Partition key: `LockID` → Create

Purpose:

* DynamoDB is used for **state locking** in Terraform.
* It prevents multiple users from making changes at the same time.

How it works:

* When Terraform runs, it creates a lock entry in the DynamoDB table.
* Other users cannot run Terraform until the lock is released.

Note:

* The actual state file is stored in the S3 bucket.
* DynamoDB does NOT store the full state file — it only stores lock information.

Correction:

* DynamoDB table does NOT contain the state file.
* The state file is only available in the S3 bucket.


native locking:
-------------
no need to depend on anything
use lock file and encrypt 

Previously we used dynamodb in my project but recently we migrated into s3 native locking



# Provisioners

* Provisioners are used to perform actions after creating a resource using Terraform (e.g., a server).

Types of provisioners:

1. **local-exec**
2. **remote-exec**

Explanation:

* The machine where you run Terraform (your laptop) is called **local**.
* The server created by Terraform is called **remote**.

local-exec:

* Executes commands on the **local machine (your laptop)** after the resource is created.

remote-exec:

* Executes commands on the **remote server (created by Terraform)** after the resource is created.


# Provisioners – Failure Behaviour & Types

## Failure Behaviour

* If we get any error in a provisioner, Terraform will **recreate the resource from scratch** in the next run.
* If we do not want this behavior, we can use:

  * `on_failure = continue`
* This means Terraform will **ignore the error and will not recreate the resource**

---

## Types of Provisioners

1. **Creation-time provisioners**

   * Run during resource creation (default behavior)

2. **Destroy-time provisioners**

   * Run during resource destruction
   * Use: `when = destroy`

---

## Remote-exec

* `remote-exec` means executing commands on the **remote server** created by Terraform
* To connect to the server, we need **credentials** (SSH key, username, or password)
* We cannot connect directly without proper authentication






