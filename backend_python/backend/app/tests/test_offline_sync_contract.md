# Simulação de falha de conexão e sincronização offline

## Cenário
1. No app Flutter, desligar conectividade e iniciar inspeção.
2. Preencher checklist dinâmico, anexar fotos e assinatura.
3. Confirmar incremento de pendências no `SyncProvider`.
4. Restabelecer conexão e executar sincronização.
5. Validar flush da fila e atualização em Firestore.

## Resultado esperado
- Nenhuma perda de dados durante modo offline.
- Registros sincronizados automaticamente quando rede disponível.
