resource "aws_db_instance" "postgres-dev" {
  allocated_storage = 20 # Minimum as far as I can tell ()

  identifier          = var.rds_instance_identifier
  db_name             = var.rds-db-name // FIXME: This should be a variable and would need to be replaced in workflows
  engine              = "postgres"
  engine_version      = var.postgres_version # Latest version of PostgreSQL available on AWS RDS (as of 2024-02-06)
  instance_class      = "db.t3.micro"
  username            = var.username
  password            = var.password
  skip_final_snapshot = true
  publicly_accessible = true
  port                = local.db_port

  # Networking
  vpc_security_group_ids = [aws_security_group.free_the_beans_rds_sg.id]
  db_subnet_group_name   = module.vpc.database_subnet_group_name

  parameter_group_name = aws_db_parameter_group.free_the_beans_pg_parameter_group.name
}


resource "aws_db_parameter_group" "free_the_beans_pg_parameter_group" {
  name   = "rds-pg"
  family = "postgres16"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}
