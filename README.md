# tay5111-ea3

## Instrucciones Evaluación Parcial EA3: Almacenamiento en la nube 35%

Cada alumno, deberá enviar código que Terraform, que permita desplegar la siguiente infraestructura el AWS.

 1. Cree una VPC, utilizando el módulo de AWS
    (terraform-aws-modules/vpc/aws) considerando el siguiente detalle:

    <p>name = "my-vpc" <br>
    cidr = "10.0.0.0/16" <br>
    azs = ["us-east-1a", "us-east-1b", "us-east-1c"] <br>
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] <br>
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] <br>
    enable_nat_gateway = true <br>
    enable_vpn_gateway = false <br></p>

tags = Terraform = "true", Environment = "prd"

 1. Cree un "Security Group" que permita conexiones al puerto tcp/80
    (http), tcp/443 (https) y tcp/22 (ssh).
 2. Cree un bucket S3, copie el siguiente archivo “.php”:

***index.php***

    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
    <title>My Website Home Page</title>
    </head>
    <body>
    <h1>Welcome to my website</h1>
    <p>Now hosted on: <?php echo gethostname(); ?></p>
    <p><?php
    $my_current_ip=exec("ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'");
    echo $my_current_ip; ?></p>
    </body>
    </html>

 4. Lanze 3 Instancias Virtuales en EC2, cada una en una AZ distinta
    (availability zone) y en las subredes públicas disponibles. Para
    cada una de estas instancias, asocie la llave de usuario (Key user)
    "vockey" y el "Security Group" configurado en el punto 1.
 5. Lance un volumen EFS y montelo dentro de cada una de las instancia EC2 en el path /var/www/html.
    
 6. Instale el servicio webserver (apache) y php en cada instancia EC2 (Puedes usar “EC2 user data” para realizar esto.

    sudo yum install -y httpd php
    systemctl start httpd
    systemctl enable httpd


  7. Copie desde el bucket S3, el archivo “index.php” hacie el path /var/www/html (EFS). 

  8. Cree un Balanceador de Carga (ALB) en AWS adjuntando las 3 máquinas creadas antes como targets. Este LB también debe aceptar conexiones en el puerto 80 desde cualquier dirección IP.

