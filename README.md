# Configuración de ambiente agéntico

## 0. Eliminar cualquier rastro de instalación anterior.
  
  docker compose down --volumes --remove-orphans


## 1. Construir la imagen del ambiente agéntico

 docker-compose build --no-cache


## 2. Levantar el ambiente agéntico

 docker-compose up -d


## 3. Ejecutar comandos de Configuración


### 3.1 Ingresar al contenedor que está en ejecución llamado entorno-agentico

 docker exec -it entorno-agentico bash
 
### 3.2 Ejecutar el wizard y completar los pasos que sugiere  

 gentle-ai
 
 
## 4. Abrir opencode

 opencode
 
### 4.1 Seleccionar el agente Gentleman desde la tecla tab y ya puedes empezar a trabajar.


## 5. Ver la presentación de Alan Buscaglia para que comprendas el por qué decidió configurar este tipo de ambiente agéntico 

./from-chat-to-cognitive-system/index.html
 
