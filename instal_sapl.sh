#!/bin/bash
# Script de instalação automatizada do SAPL em VPS Ubuntu/Debian

set -e

echo "==== Instalação do SAPL ===="

# 1. Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root (sudo)."
  exit 1
fi

# 2. Atualiza o sistema
apt update && apt upgrade -y

# 3. Instala dependências do sistema
apt install -y git python3 python3-pip python3-venv postgresql postgresql-contrib libpq-dev

# 4. Cria usuário e banco de dados PostgreSQL
sudo -u postgres psql <<EOF
CREATE USER sapl_user WITH PASSWORD 'sapl_senha';
CREATE DATABASE sapl_db OWNER sapl_user;
EOF

# 5. Clona o projeto SAPL do GitHub
cd /opt || exit 1
git clone https://github.com/interlegis/sapl.git sapl

# 6. Cria e ativa ambiente virtual Python
cd /opt/sapl
python3 -m venv venv
source venv/bin/activate

# 7. Instala dependências Python
pip install --upgrade pip
pip install -r requirements.txt

# 8. Configura variáveis de ambiente
cat <<EOT > /opt/sapl/.env
DATABASE_URL=postgres://sapl_user:sapl_senha@localhost:5432/sapl_db
SECRET_KEY=$(openssl rand -hex 32)
DEBUG=False
EOT

# 9. Migrações do banco de dados
python manage.py migrate

# 10. Cria superusuário admin
python manage.py shell <<EOF
from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@exemplo.com', 'admin123')
EOF

echo "==== Instalação concluída! ===="
echo "Para iniciar o SAPL, execute:"
echo "cd /opt/sapl"
echo "source venv/bin/activate"
echo "python manage.py runserver 0.0.0.0:8000"
echo "Acesse http://sispat.vps-kinghost.net:8000 com usuário admin e senha admin123"
