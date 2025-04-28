# streamlitdocker - Módulo Criando um Blog com Container Apps
Laboratório DIO - Desafio - Armazenando dados de um E-Commerce na Cloud -  Módulo Criando um Blog com Container Apps

Este repositório tem como objetivo consolidar os conhecimentos adquiridos no módulo *Criando um Blog com Container Apps* onde foram tratados os seguintes assuntos:
* Criação de DockerFile
* Criação do Resource Group e Container Registry
* Deploy de imagem no repositório do ContainerApps
* Criação das variáveis de ambiente no containerapps e deploy da aplicação.

Neste repositório iremos implantar uma aplicação base de um blog desenvolvido utilizando a biblioteca streamlit, seguindo os seguintes passos:
* [Preparação de um ambiente para desenvolvimento utilizando docker](#docker)
* [Criação da imagem streamlit docker](#myimage)
* [Deploy na Azure(TODO)](#deploy)

##Preparação de um ambiente para desenvolvimento utilizando docker
Como iremos fazer a criação e interação para envio de uma imagem do docker, então vamos utilizar a estratégia de configurar um servidor remoto linux e instalar o docker utilizando o comando: 
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
Após a instalação para facilitar a interação com o docker, vamos dar o seguinte comando para cadastrar o usuário como administrador:
```bash
sudo usermod -aG docker $USER
```
E vamos conectar nosso diretório de desenvolvimento com o servidor usando a extensão Remote - SSH
![Extensão](https://assets.digitalocean.com/articles/vscode_remote_ssh/qeXwQwX.png)

## Criação da imagem docker
Foi criado um Dockerfile para fazer a instalação da biblioteca streamlit, bem como outras dependencias no arquivo requirements.txt e criado um main.py com uma página básica.

Após a criação foi dado o seguinte comando para realizar a criação da imagem docker:
`docker build -t streamlitdocker .`

Após a criação da imagem, podemos rodar o container utilizando o comando:
`docker run -p 80:80 --name mystreamlit streamlitdocker`

## Deploy na Azure(TODO)
com a imagem criada, damos os comandos para se logar no serviço container app da azure:
```bash
#login na azure
az login az l
# Create a resource group
az group create --name mycontainerresourcegroup --location eastus
# Create Container Registry
az acr create --resource-group mycontainerresourcegroup --name streamlitcosta --sku Basic

# Login to ACR
az acr login --name streamlitcosta

# Tag the image
docker tag streamlitdocker:latest streamlitcosta.azurecr.io/streamlitcosta:latest

# Push the image
docker push streamlitcosta.azurecr.io/streamlitcosta:latest

# Create Environment container app
az containerapp env create  --name streamlitcosta-env --resource-group mycontainerresourcegroup --location eastus 

# Create Container App
az containerapp create --name streamlitcosta-app --resource-group mycontainerresourcegroup --image streamlitcosta.azurecr.io/streamlitcosta:latest --environment streamlitcosta-env --target-port 80 --ingress external --registry-username streamlitcosta --registry-password 9($password) --registry-server streamlitcosta.azurecr.io
```

