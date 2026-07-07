resource "aws_security_group" "rds" {

  name = "${var.project_name}-rds-sg"

  description = "Allow ECS only"

  vpc_id = var.vpc_id

  ingress {

    from_port = 5432

    to_port = 5432

    protocol = "tcp"

    security_groups = [

      var.ecs_security_group_id

    ]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }

  tags = {

    Name = "${var.project_name}-rds-sg"

  }

}
resource "aws_db_subnet_group" "db_subnet_group" {

  name = "${var.project_name}-db-subnet"

  subnet_ids = var.private_subnets

  tags = {

    Name = "${var.project_name}-db-subnet"

  }

}
resource "aws_db_instance" "postgres" {

  identifier = "${var.project_name}-db"

  engine = var.engine

  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [

    aws_security_group.rds.id

  ]

  publicly_accessible = false

  multi_az = false

  storage_encrypted = true

  backup_retention_period = var.backup_retention

  deletion_protection = var.deletion_protection

  skip_final_snapshot = true

  apply_immediately = true

  tags = {

    Name = "${var.project_name}-postgres"

  }

}
