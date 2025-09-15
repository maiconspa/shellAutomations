#!/bin/bash

# Este script instala o OpenJDK 17 no Ubuntu.

# 1. Atualiza os pacotes do sistema
echo "Atualizando a lista de pacotes..."
sudo apt update -y

# 2. Instala o OpenJDK 17
# O pacote "openjdk-17-jdk" inclui o JRE (Java Runtime Environment) e o JDK (Java Development Kit)
echo "Instalando o OpenJDK 17..."
sudo apt install openjdk-17-jdk -y

# 3. Verifica a instalação
echo "Verificando a versão do Java instalada..."
java -version

echo "Instalação do OpenJDK 17 concluída com sucesso!"

# 4. (Opcional) Configura a variável de ambiente JAVA_HOME
# Isso é útil para muitas aplicações e frameworks (como Maven, Gradle)
echo "Configurando a variável de ambiente JAVA_HOME..."
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' | sudo tee -a /etc/environment
echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/environment
source /etc/environment
echo "Variável JAVA_HOME configurada. É recomendado reiniciar o terminal para que as mudanças tenham efeito."
