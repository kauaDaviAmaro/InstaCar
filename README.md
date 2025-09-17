## InstaCar - Docker e Desenvolvimento

Projeto composto por:
- API Node/TypeScript (`instacar-api`)
- App Flutter Web servido por Nginx (`instacar`)
- Banco de dados Postgres (via Docker Compose)

Guia para subir com Docker e rodar em desenvolvimento local.

### Pré-requisitos
- Docker Desktop instalado e em execução no Windows

### Estrutura
```
InstaCar/
  docker-compose.yml
  instacar-api/
    Dockerfile
    package.json
    src/
  instacar/
    Dockerfile
    pubspec.yaml
    lib/
```

### Executar com Docker
1) Inicie o Docker Desktop.
2) No PowerShell, na raiz do projeto:
```powershell
cd C:\Users\pc\Desktop\InstaCar
docker compose up -d --build
```
3) Verificar serviços:
```powershell
docker compose ps
```

#### Endereços
- Web (Flutter): http://localhost:8080
- API (Node): http://localhost:3000

O `docker-compose.yml` configura a API para Postgres e o Nginx do Web aplica substituição de URLs hardcoded (`localhost:3000` e `10.0.2.2:3000`) para `api:3000` ao servir os assets.

### Variáveis de ambiente (compose)
- API:
  - `PORT=3000`
  - `DB_DIALECT=postgres`
  - `DB_HOST=db`
  - `DB_PORT=5432`
  - `DB_USER=postgres`
  - `DB_PASSWORD=postgres`
  - `DB_NAME=instacar`
- Web:
  - `API_BASE_URL=http://api:3000` (referência)

Personalize no `docker-compose.yml` e recrie os containers.

### Parar e remover
```powershell
docker compose down
# para remover volumes de dados (Postgres):
docker compose down -v
```

### Logs
```powershell
docker compose logs -f api
docker compose logs -f web
docker compose logs -f db
```

## Desenvolvimento local (sem Docker)
### API
1) Instalar dependências:
```powershell
cd instacar-api
npm ci
```
2) `.env` (opcional). Exemplo Postgres local:
```
PORT=3000
DB_DIALECT=postgres
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=instacar
```
3) Rodar:
```powershell
npm run dev
```
4) Produção:
```powershell
npm run build
npm start
```

### Flutter Web
1) Requisitos: Flutter SDK com web habilitado.
2) Dependências:
```powershell
cd instacar
flutter pub get
```
3) Debug:
```powershell
flutter run -d chrome
```
4) Build:
```powershell
flutter build web --release
```

Observação: há URLs hardcoded `http://localhost:3000` no Flutter. Em Docker, o Nginx substitui por `http://api:3000`. Para um controle melhor, centralize `API_BASE_URL` em configuração e use variável em tempo de build.

## Problemas comuns
- Docker não iniciado: mensagens envolvendo `dockerDesktopLinuxEngine` indicam que o Docker Desktop não está rodando.
- Portas em uso: altere mapeamentos no `docker-compose.yml` se `3000` ou `8080` estiverem ocupadas.

## Comandos úteis
```powershell
docker compose build api
docker compose up -d web
docker compose exec api sh
docker compose config
```

## Licença
Defina a licença conforme a necessidade do projeto.


