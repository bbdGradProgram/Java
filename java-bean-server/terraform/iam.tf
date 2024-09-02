resource "aws_iam_role" "ec2-role" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  description           = "Allows EC2 instances to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonRDSFullAccess", "arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
  max_session_duration  = 3600
  name                  = "FreeTheBeanEC2Role"
  path                  = "/"

}

resource "aws_iam_instance_profile" "free-the-beans-instance-profile" {
  name = "FreeTgeBeansInstanceProfile"
  role = aws_iam_role.ec2-role.name
}