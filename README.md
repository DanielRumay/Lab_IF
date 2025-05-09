**Proyecto: Sistema de Biblioteca de Recetas de Cocina**
**Descripción del Proyecto**
El Sistema de Biblioteca de Recetas de Cocina es una aplicación web alojada en la nube que permite a los usuarios consultar, gestionar y almacenar recetas culinarias de forma personalizada. El sistema proporciona funcionalidades como la gestión de recetas, favoritos y listas de compras. El acceso a la aplicación es seguro, escalable y está optimizado mediante servicios de AWS que garantizan alta disponibilidad y bajo tiempo de respuesta.

**Servicios Utilizados**
Amazon CloudFront
Se utiliza para distribuir el contenido estático del frontend con baja latencia y alta velocidad a los usuarios finales.

Amazon S3
Almacena los archivos estáticos del frontend de la aplicación (HTML, CSS, JavaScript, imágenes).

Amazon API Gateway
Expone las API RESTful necesarias para interactuar con el backend, sirviendo de puerta de entrada para las peticiones del cliente.

Amazon Cognito
Provee autenticación y autorización de usuarios, asegurando el acceso seguro a los recursos del sistema.

AWS Lambda
Funciona como backend sin servidor (serverless), ejecutando la lógica de negocio para la gestión de recetas, favoritos y compras.

Amazon EFS (Elastic File System)
Sistema de archivos compartido y escalable que permite almacenar y acceder a datos persistentes desde funciones Lambda.

Amazon VPC y subredes privadas
Aíslan los recursos del backend en un entorno seguro, evitando el acceso público directo a datos sensibles.


#COMANDOS PARA EJECUTAR


(terraform init)


(terraform apply)


(terraform plan)


(curl localhost:3000)


(terraform workspace list)


(terraform workspace new dev)


(terraform workspace select default)


(systemctl restart docker)




Estudiantes:
-Rumay Iglesias Eduardo
-Sthefano Jimenez Atoche