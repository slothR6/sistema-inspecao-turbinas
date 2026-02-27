from pathlib import Path
from tempfile import NamedTemporaryFile
from typing import Any

import qrcode
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Image, Paragraph, SimpleDocTemplate, Spacer, Table

from .watermark import draw_watermark


class PdfGenerator:
    def generate(self, inspection_id: str, bundle: dict[str, Any]) -> Path:
        with NamedTemporaryFile(delete=False, suffix=".pdf") as fp:
            output = Path(fp.name)

        doc = SimpleDocTemplate(str(output), pagesize=A4)
        styles = getSampleStyleSheet()

        usina = bundle["usina"]
        turbina = bundle["turbina"]
        inspection = bundle["inspection"]
        checklist = bundle["checklist"]

        rows = [
            ["Usina", usina.get("nome", "-")],
            ["Cliente", usina.get("cliente", "-")],
            ["Turbina", turbina.get("numero_identificacao", "-")],
            ["Modelo", turbina.get("modelo", "-")],
            ["Inspeção", inspection_id],
            ["Status", inspection.get("status", "-")],
        ]

        qr_file = output.with_suffix(".qr.png")
        qrcode.make(f"inspection:{inspection_id}").save(qr_file)

        story = [
            Paragraph("Laudo de Inspeção de Turbina Eólica", styles["Title"]),
            Spacer(1, 10),
            Table(rows),
            Spacer(1, 12),
            Paragraph("Checklist", styles["Heading2"]),
            Paragraph(str(checklist.get("estrutura_json", {})), styles["BodyText"]),
            Spacer(1, 12),
            Paragraph("Respostas", styles["Heading2"]),
            Paragraph(str(inspection.get("respostas_json", {})), styles["BodyText"]),
            Spacer(1, 12),
            Paragraph("QR Code de validação", styles["Heading2"]),
            Image(str(qr_file), width=120, height=120),
        ]

        doc.build(story, onFirstPage=lambda c, _: draw_watermark(c), onLaterPages=lambda c, _: draw_watermark(c))
        return output
