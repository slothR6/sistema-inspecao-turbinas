from pathlib import Path

import firebase_admin
from fastapi import Depends, FastAPI, HTTPException
from firebase_admin import credentials
from pydantic import BaseModel

from .auth_middleware import assert_role, get_current_user
from .config import settings
from .firestore_service import FirestoreService
from .pdf_generator import PdfGenerator
from .storage_service import StorageService

cred = credentials.Certificate(settings.firebase_credentials_path)
if not firebase_admin._apps:
    firebase_admin.initialize_app(cred)

app = FastAPI(title="Backend de Inspeções de Turbinas")
firestore_service = FirestoreService()
storage_service = StorageService(settings.storage_bucket)
pdf_generator = PdfGenerator()


class GeneratePdfRequest(BaseModel):
    inspection_id: str


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/inspections/generate-pdf")
def generate_pdf(payload: GeneratePdfRequest, user: dict = Depends(get_current_user)) -> dict[str, str]:
    assert_role(user, {"admin", "gestor", "supervisor"})

    try:
        bundle = firestore_service.get_inspection_bundle(payload.inspection_id)
        pdf_path = pdf_generator.generate(payload.inspection_id, bundle)
        pdf_url = storage_service.upload_pdf(payload.inspection_id, Path(pdf_path))
        firestore_service.update_inspection_pdf(payload.inspection_id, pdf_url)
        firestore_service.append_log(
            user_id=user.get("uid", "system"),
            acao="geracao_pdf",
            modulo="inspecoes",
            metadata={"inspection_id": payload.inspection_id, "pdf_url": pdf_url},
        )
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc

    return {"inspection_id": payload.inspection_id, "pdf_url": pdf_url}
