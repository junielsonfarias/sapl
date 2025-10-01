# Instalação Simplificada do SAPL em VPS (Ubuntu/Debian)

Este guia mostra como instalar o SAPL em uma VPS de forma simples, usando o script automatizado `install_sapl.sh`.

## Pré-requisitos
- VPS com Ubuntu ou Debian (recomendado Ubuntu 20.04 ou superior)
- Acesso root ou permissão para usar `sudo`

## Passo a Passo

### 1. Acesse sua VPS


Conecte-se à sua VPS usando SSH:

```bash
ssh root@sispat.vps-kinghost.net
```

Você já estará como root e conectado à VPS correta.

---

### 2. Baixe o script de instalação


Baixe o script de instalação diretamente do GitHub:

```bash
wget https://raw.githubusercontent.com/junielsonfarias/sapl/3.1.x/instal_sapl.sh
```

---

### 3. Dê permissão de execução ao script


```bash
chmod +x instal_sapl.sh
```

---

### 4. Execute o script como root



```bash
mv instal_sapl.sh /opt/
cd /opt
sudo ./instal_sapl.sh
```

O script irá:
- Atualizar o sistema
- Instalar dependências
- Configurar o banco de dados
- Baixar o SAPL
- Instalar dependências Python
- Configurar variáveis de ambiente
- Aplicar migrações
- Criar usuário admin

---

### 5. Inicie o SAPL manualmente

Após a instalação, rode:

```bash
cd /opt/sapl
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000
```

---

### 6. Acesse o SAPL

Abra o navegador e acesse:


```
http://sispat.vps-kinghost.net:8000
```

Login padrão:
- Usuário: `admin`
- Senha: `admin123`

---

## Observações Importantes
- Troque a senha do admin após o primeiro acesso!
- Para uso em produção, recomenda-se configurar um serviço (systemd) e um servidor web (nginx/gunicorn).
- Este guia é para instalação rápida e testes. Para ambientes críticos, siga as recomendações de segurança do SAPL.

---

Pronto! O SAPL estará disponível para uso.
