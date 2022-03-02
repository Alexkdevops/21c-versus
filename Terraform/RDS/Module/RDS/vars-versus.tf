variable "db_name" {
  description = "Name of MySQL db instance."
}
variable "sg_name" {
  description = "Name of Security group."
}
variable "mysql_sg_name" {
  description = "Name of Security group for MySQL db instance."
}
variable "from_port" {
  description = "Default port 'from' for MySQL."
}
variable "to_port" {
  description = "Default port 'to' for MySQL."
}
variable "protocol" {
  description = "Default protocol for MySQL."
}
variable "from_port_egress" {
  description = "Default port 'from' in egress, out for all."
}
variable "to_port_egress" {
  description = "Default port 'to' in egress, out for all."
}
variable "protocol_egress" {
  description = "Default protocol for egress, out for all."
}
variable "cidr_blocks_egress" {
  description = "Default cidr block for egress, going anywhere."
}
variable "identifier" {
  description = "The name of the RDS MySQL instance."
}
variable "allocated_storage" {
  description = "Allocated storage for MySQL db instance. The allocated storage in gibibytes."
}
variable "engine" {
  description = "Engine for DB instance."
}
variable "engine_version" {
  description = "Version of MySQL db instance."
}
variable "instance_class" {
  description = "The instance type of the RDS MySQL instance."
}
variable "name" {
  description = "The name of the database to create when the DB instance is created."
}
variable "db_username" {
  description = "Username for the master DB user."
}
variable "db_password" {
  description = "Password for the master DB user."
}
variable "parameter_group_name" {
  description = "The db parameter group name."
}
variable "storage_type" {
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)."
}
variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
}
variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
}
variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
}
variable "self" {
  description = "Whether the security group itself will be added as a source to this ingress or egress rule."
}
