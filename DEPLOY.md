# Deploy Mapas Culturais Base Project no Dokploy

Este guia explica como fazer o deploy do projeto Mapas Culturais Base Project no Dokploy usando Nixpacks.

## 📋 Pré-requisitos

- Dokploy instalado e configurado
- Acesso a uma instância PostgreSQL
- Acesso a uma instância Redis (opcional, mas recomendado)
- Domínio configurado

## 🚀 Deploy Rápido

### 1. Conectar Repositório

No Dokploy, adicione este repositório:
```
https://github.com/vitfera/mapasculturais-base-project
```

Branch: `nixpacks`

### 2. Configurar Variáveis de Ambiente

**Obrigatórias:**
```env
DB_HOST=seu-postgres-host
DB_NAME=mapas
DB_USER=mapas_user
DB_PASS=sua_senha_segura
BASE_URL=https://seu-dominio.com
BASE_DOMAIN=seu-dominio.com
```

**Plugin WhatsApp (Opcional):**
```env
WHATSAPP_ENABLED=true
WHATSAPP_NUMBER=5511999999999
WHATSAPP_MESSAGE=Olá! Gostaria de falar com vocês.
```

**Outras configurações:**
```env
APP_MODE=production
REDIS_CACHE=redis:6379
MAILER_FROM=noreply@seu-dominio.com
```

### 3. Deploy

1. Configure as variáveis de ambiente no Dokploy
2. Faça o deploy do branch `nixpacks`
3. Aguarde o build e deploy
4. Acesse seu domínio

## 🐳 Deploy com Docker Compose

Alternativamente, use o arquivo `docker-compose.dokploy.yml`:

```bash
# Clone o repositório
git clone https://github.com/vitfera/mapasculturais-base-project.git
cd mapasculturais-base-project
git checkout nixpacks

# Configure as variáveis de ambiente
cp .env.example .env
# Edite o .env com suas configurações

# Execute com Docker Compose
docker-compose -f docker-compose.dokploy.yml up -d
```

## 📁 Estrutura dos Arquivos de Deploy

```
├── Dockerfile                     # Imagem Docker otimizada para produção
├── nixpacks.toml                  # Configuração do Nixpacks
├── dokploy.yml                    # Configuração completa do Dokploy
├── docker-compose.dokploy.yml     # Docker Compose para desenvolvimento
├── .dockerignore                  # Arquivos excluídos do build
└── docker/
    ├── production/
    │   └── apache.conf            # Configuração Apache para produção
    └── db/
        └── init.sql               # Script de inicialização do PostgreSQL
```

## ⚙️ Configurações Avançadas

### Banco de Dados

O projeto usa PostgreSQL com PostGIS. Configure:

```sql
-- Extensões necessárias (criadas automaticamente)
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION unaccent;
```

### Cache Redis

Para melhor performance, configure Redis:

```env
REDIS_CACHE=redis:6379
```

### SSL/HTTPS

Configure SSL no Dokploy ou use um proxy reverso (Nginx/Traefik).

### Volumes Persistentes

Dados importantes são salvos em volumes:

- `/var/www/html/files` - Uploads dos usuários
- `/var/www/html/assets` - Assets compilados
- `/var/www/html/logs` - Logs da aplicação

## 🔧 Plugins Incluídos

### WhatsApp Floating Button

Plugin de botão flutuante do WhatsApp configurável via variáveis de ambiente:

```env
WHATSAPP_ENABLED=true
WHATSAPP_NUMBER=5511999999999
WHATSAPP_MESSAGE=Sua mensagem personalizada
```

### Outros Plugins

- `MultipleLocalAuth` - Autenticação local e social
- `ValuersManagement` - Gestão de validadores

## 📊 Monitoramento

### Health Checks

A aplicação expõe um endpoint de health check em `/health`.

### Logs

Logs são salvos em `/var/www/html/logs` e podem ser acessados via:

```bash
docker logs mapas-app
```

### Métricas

Configure monitoramento através do Dokploy ou ferramentas externas.

## 🛠️ Troubleshooting

### Build Falhou

1. Verifique os logs de build no Dokploy
2. Confirme que todas as dependências estão instaladas
3. Verifique o arquivo `nixpacks.toml`

### Aplicação não inicia

1. Verifique as variáveis de ambiente
2. Confirme conectividade com PostgreSQL
3. Verifique logs da aplicação

### Problemas de banco

1. Confirme que PostGIS está instalado
2. Verifique permissões do usuário
3. Execute o script `docker/db/init.sql` manualmente se necessário

### Performance

1. Configure Redis para cache
2. Otimize configurações do PostgreSQL
3. Use CDN para assets estáticos

## 📞 Suporte

- **Documentação Mapas Culturais**: https://github.com/mapasculturais/mapasculturais
- **Issues**: https://github.com/vitfera/mapasculturais-base-project/issues
- **Plugin WhatsApp**: https://github.com/RedeMapas/plugin-WhatsAppFloating

## 🔄 Atualizações

Para atualizar o projeto:

1. Faça pull das últimas alterações
2. Refaça o deploy no Dokploy
3. Execute migrações se necessário

---

**Deploy realizado com ❤️ usando Dokploy e Nixpacks**