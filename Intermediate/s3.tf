resource "aws_s3_bucket" "firstbucket"{
	bucket ="<provide a unique name>"
	acl = "private"
	tags ={
	name ="first bucket"
	}
	versioning {
	enabled = true
	}
}