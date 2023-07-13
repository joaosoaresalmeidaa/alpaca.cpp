#!/bin/bash

csv_file="prompts.csv"

# Inicializa o chat_mac em segundo plano
./chat_mac > /dev/null 2>&1 &

# Função para enviar prompt e receber resposta
send_prompt() {
    prompt="$1"
    response=$(echo "$prompt" | ./chat_mac)
    echo "$response"
}

# Loop para processar os prompts da coluna "Prompt" do arquivo CSV
tail -n +2 "$csv_file" | cut -d ',' -f 3 | while IFS= read -r prompt
do
    # Envia o prompt para o chat_mac e recebe a resposta
    response=$(send_prompt "$prompt")

    # Faz o que você quiser com a resposta, por exemplo, imprimir na tela
    echo "$response"

done

# Finaliza o chat_mac
pkill chat_mac