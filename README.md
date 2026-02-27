# Sistema de Inspeção de Turbinas Eólicas

Arquitetura base de produção com **Flutter (Web + Android)**, **Firebase**, **FastAPI** e **Google Cloud Run**.

## Estrutura do monorepo

```text
/frontend_flutter        # App único Flutter (Web + Android) com módulos administrativos e de campo
/backend_python/backend  # API FastAPI para laudos, segurança e integração com Firestore/Storage
/infra                   # Regras Firebase e documentação de modelagem
/scripts                 # Scripts de deploy
```

## Frontend Flutter

### Organização de pastas

```text
lib/
  core/
    services/
    models/
    repositories/
    providers/
    utils/
  modules/
    auth/
    dashboard/
    usinas/
    turbinas/
    checklists/
    inspecoes/
  shared/
    widgets/
    themes/
```

### Capacidades implementadas no código base
- Login com Firebase Auth e recuperação de perfil de role em `usuarios`.
- Controle de sessão com `AuthProvider`.
- Roteamento e proteção de páginas por autenticação/role.
- Base de CRUD de usinas com repository isolado.
- Fundação de modo offline com cache local do Firestore habilitado.
- Indicador de pendências de sincronização no dashboard.
- Página de inspeção preparada para renderização dinâmica por JSON + fotos + assinatura.

## Backend Python (FastAPI)

### Organização

```text
backend/app/
  main.py
  config.py
  firestore_service.py
  storage_service.py
  pdf_generator.py
  watermark.py
  auth_middleware.py
  tests/
```

### Fluxo de geração automatizada de laudo
1. Recebe `inspection_id` em `/inspections/generate-pdf`.
2. Valida token Firebase + role autorizada (`admin|gestor|supervisor`).
3. Busca inspeção, turbina, checklist e usina no Firestore.
4. Gera PDF com dados estruturados + QR Code + marca d'água.
5. Envia PDF para Google Cloud Storage.
6. Atualiza `pdf_url` da inspeção.
7. Registra auditoria em `logs_sistema`.

## Firestore (modelagem)
Coleções normalizadas em `infra/firestore_schema.md`:
- usinas
- turbinas
- componentes
- checklists
- inspecoes
- usuarios
- logs_sistema

## Segurança Firebase
Arquivo: `infra/firebase.rules`
- `admin`: acesso total.
- `gestor`: leitura geral e gestão de entidades.
- `tecnico`: leitura e atualização apenas de inspeções atribuídas.
- `supervisor`: leitura geral e atualização de status para finalização/aprovação.

## Testes
- Unitário de geração de PDF (`test_pdf_generator.py`).
- Healthcheck da API (`test_main.py`).
- Documento de cenário para falha de conexão/sincronização offline (`test_offline_sync_contract.md`).

## Deploy

### Backend (Cloud Run)
```bash
./scripts/deploy_backend.sh
```

### Frontend Web (Firebase Hosting)
```bash
./scripts/deploy_frontend_web.sh
```

## Próximos passos recomendados
1. Adicionar migrations/versionamento de schema via validações server-side.
2. Implementar builder visual de checklist no Flutter com persistência de `estrutura_json`.
3. Incluir fila assíncrona para geração de laudos em lote (Cloud Tasks/PubSub).
4. Integrar observabilidade (OpenTelemetry + Cloud Logging).
5. Adicionar camada de integração ERP e módulo IA para análise preditiva de falhas.
