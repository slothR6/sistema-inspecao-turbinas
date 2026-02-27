from datetime import datetime, timezone
from typing import Any

from google.cloud import firestore


class FirestoreService:
    def __init__(self, client: firestore.Client | None = None) -> None:
        self.client = client or firestore.Client()

    def get_inspection_bundle(self, inspection_id: str) -> dict[str, Any]:
        inspection_ref = self.client.collection("inspecoes").document(inspection_id)
        inspection_doc = inspection_ref.get()
        if not inspection_doc.exists:
            raise ValueError("Inspeção não encontrada")

        inspection = inspection_doc.to_dict()
        turbina_doc = self.client.collection("turbinas").document(inspection["turbina_id"]).get()
        checklist_doc = self.client.collection("checklists").document(inspection["checklist_id"]).get()
        usina_doc = self.client.collection("usinas").document(turbina_doc.to_dict()["usina_id"]).get()

        return {
            "inspection": inspection,
            "turbina": turbina_doc.to_dict(),
            "checklist": checklist_doc.to_dict(),
            "usina": usina_doc.to_dict(),
        }

    def update_inspection_pdf(self, inspection_id: str, pdf_url: str) -> None:
        self.client.collection("inspecoes").document(inspection_id).update(
            {"pdf_url": pdf_url, "updated_at": datetime.now(timezone.utc).isoformat()}
        )

    def append_log(self, user_id: str, acao: str, modulo: str, metadata: dict[str, Any]) -> None:
        self.client.collection("logs_sistema").add(
            {
                "usuario_id": user_id,
                "acao": acao,
                "modulo": modulo,
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "metadata": metadata,
            }
        )
