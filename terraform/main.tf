# Create the date bucket
resource "aws_s3_bucket" "date" {
  bucket = "date"
}

# Generate the timestamp file
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