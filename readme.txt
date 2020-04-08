Data Source:
Data Source is to list all the aws resources in a given region.
availability_zone = data.aws_availability_zones.available.names[0]

resource_type.resource_name.index.attribute
${aws_instance.ec2_instance.*.id[count.index]}
