#Create DynamoDB table for Terraform state locking
#resource "aws_dynamodb_table" "terraform_locks" {
#  name           = "terraform_locks"
#  billing_mode   = "PAY_PER_REQUEST"
#  hash_key       = "LockID"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}

# S3 bucket to store Terraform state
#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "terraform-state"  # Change to your desired bucket name
#}
#
#resource "aws_s3_bucket_public_access_block" "terraform_state_access" {
#  bucket = aws_s3_bucket.terraform_state.id
#
#  block_public_acls       = true
#  ignore_public_acls      = true
#  block_public_policy     = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket" "date" {
  bucket = "date"
}

resource "null_resource" "generate_file" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "$(date +%s)" > timestamp.txt
    EOT
  }
}

# Read the content of the generated file
data "local_file" "timestamp_file" {
  depends_on = [null_resource.generate_file]
  filename   = "timestamp.txt"
}

# Upload the file to an S3 bucket
resource "aws_s3_object" "timestamp_object" {
  depends_on = [aws_s3_bucket.date]
  bucket = "date"
  key    = "timestamp.txt"
  content = data.local_file.timestamp_file.content
}