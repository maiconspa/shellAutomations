#!/bin/bash

# --- Variáveis ---
# O tipo de criptografia recomendado pelo GitHub
CRYPT_TYPE="ed25519"
# O diretório padrão para as chaves
SSH_DIR="$HOME/.ssh"
# Nome de arquivo padrão para a chave
DEFAULT_KEY_NAME="id_ed25519"

# --- Funções ---
# Função para verificar se o diretório SSH existe
check_ssh_dir() {
    if [ ! -d "$SSH_DIR" ]; then
        echo "O diretório $SSH_DIR não existe. Criando agora..."
        mkdir -p "$SSH_DIR"
        chmod 700 "$SSH_DIR"
    fi
}

# --- Lógica principal do script ---
echo "--- Gerador de Chave SSH ---"
echo ""

# 1. Checar e criar o diretório .ssh se necessário
check_ssh_dir

# 2. Perguntar o e-mail
read -p "Digite seu e-mail para usar como comentário na chave (ex: seu_email@exemplo.com): " EMAIL
if [ -z "$EMAIL" ]; then
    echo "E-mail não fornecido. Usando um valor padrão para continuar."
    EMAIL="chave_ssh_automatica"
fi

# 3. Perguntar o nome do arquivo da chave
read -p "Dê um nome para o arquivo da chave (padrão: $DEFAULT_KEY_NAME): " KEY_NAME_INPUT
KEY_NAME="${KEY_NAME_INPUT:-$DEFAULT_KEY_NAME}"
FULL_PATH="$SSH_DIR/$KEY_NAME"

# 4. Checar se a chave já existe
if [ -f "$FULL_PATH" ]; then
    read -p "O arquivo $FULL_PATH já existe. Deseja substituí-lo? (s/n) " REPLACE
    if [[ ! "$REPLACE" =~ ^[Ss]$ ]]; then
        echo "Operação cancelada. Nenhuma chave foi gerada."
        exit 1
    fi
fi

# 5. Gerar a chave
echo "Gerando a chave SSH do tipo $CRYPT_TYPE..."
ssh-keygen -t "$CRYPT_TYPE" -C "$EMAIL" -f "$FULL_PATH"

# 6. Adicionar a chave ao ssh-agent
echo "Iniciando o ssh-agent..."
eval "$(ssh-agent -s)"
echo "Adicionando a chave recém-criada ao ssh-agent..."
ssh-add "$FULL_PATH"

# 7. Exibir a chave pública para copiar
echo "--- Chave Pública Gerada ---"
echo "Sua chave pública foi salva em $FULL_PATH.pub"
echo "Para adicioná-la à sua conta do GitHub, copie o conteúdo abaixo:"
echo "------------------------------------------------------------"
cat "$FULL_PATH.pub"
echo "------------------------------------------------------------"
echo "Agora, vá para as configurações de SSH do seu GitHub e cole a chave."

exit 0
