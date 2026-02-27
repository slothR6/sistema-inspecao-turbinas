# Modelagem Firestore (produção)

## Coleções principais
- `usinas`: id, nome, cliente, localizacao, ativo, created_at, updated_at
- `turbinas`: id, usina_id (ref), modelo, numero_identificacao, status, created_at
- `componentes`: id, turbina_id (ref), nome, categoria, especificacoes
- `checklists`: id, nome, versao, estrutura_json, criado_por, created_at
- `inspecoes`: id, turbina_id, checklist_id, tecnico_id, supervisor_id, status, data_inicio, data_fim, respostas_json, fotos[], assinatura_tecnico_url, assinatura_supervisor_url, pdf_url
- `usuarios`: id, nome, email, role, ativo
- `logs_sistema`: id, usuario_id, acao, modulo, timestamp, metadata
