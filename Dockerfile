# 1. Usar uma imagem base oficial do Python
# Utiliza a imagem 'slim' que é mais leve e consistente com a versão 3.10 mencionada no readme.md.
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho no contêiner
# Isso garante que os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt requirements.txt

# 4. Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação
COPY . .

# 6. Expor a porta em que a aplicação será executada
EXPOSE 8000

# 7. Definir o comando para executar a aplicação quando o contêiner iniciar
# Usa uvicorn para rodar a aplicação FastAPI, escutando em todas as interfaces de rede (0.0.0.0).
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
