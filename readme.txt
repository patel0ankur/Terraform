Data Source:
Data Source is to list all the AWS resources in a given region.
availability_zone = data.aws_availability_zones.available.names[0]


To reference a particular instance of a resource you can use:
resource_type.resource_name.index.attribute
${aws_instance.ec2_instance.*.id[count.index]}
${aws_instance.ec2_instance.id[0]}


Length Function:
length determines the length of a given list, map, or string.

count = "${length(data.aws_availability_zones.azs_private.names)}"


Element Function: Returns a single element from a list at the given index.
element(["a", "b", "c"], 1)
b
${element(list, index)}
${element(aws_instance.ec2_instance.*.id, 2)}

Join Function:
join(delim, list)
join(",", aws_instance.foo.*.id)
join(",", var.ami_list)
value = "${join(",",aws_instance.ec2_instance.*.private_ip)}"



Importing existing AWS resources:

Step 1: 
Install terraforming.

Step 2: 
Export the existing AWS resources using terraforming commands. It will generate tf code. Create a main.tf using the generated tf code.

Step 3:
Use terraform import command. 

terraform import [options] ADDR ID 
terraform import aws_instance.ec2_test i-082e34576fhe

ADDR is the address of your Terraform’s defined resource to import to.
ID is your AWS object ID

Step 4: 
Run terraform plan command to verify the changes in resourse definition. 


CloudFormer is a template creation tool to create cloudformation templates from existing resources in AWS.
ct-to-tf is a tool to convert cloudformation templates into terraform templates.





