# GotPhoto
GotPhoto Case Study 

This case study was made using docker compose and terraform, following the steps in the docker compose file:

- LocalStack: start server
- Terraform linter: check terraform code
- Terraform init: wait the linter step and initialize
- Terraform plan: wait the init step and plan
- Terraform apply: wait the plan step and apply generating a file with the actual timestamp and upload it to s3
- S3 file exists: wait the apply step and checks if the uploaded file exists
- S3 file download: wait for the file exists step and download the file
- Compare files: wait for the file download step and generate a checksum of both files and compare 

How to run
---

__All steps__
```shell
docker compose up
```

__Just the linter__
```shell
docker compose up terraform-linter
```

CI/CD
---

I created a github actions `yml` file in `.github/workflows` with the following steps, that should run when a pull request or a merge in the main branch occurs:

- test: runs the terraform linter 
- plan: starts the localstack container and runs the terraform init and plan
- apply: starts the localstack container and runs the terraform init and apply
