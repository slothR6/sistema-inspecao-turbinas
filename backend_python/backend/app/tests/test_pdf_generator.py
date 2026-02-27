from pathlib import Path

from app.pdf_generator import PdfGenerator


def test_generate_pdf_creates_file() -> None:
    bundle = {
        "usina": {"nome": "Usina Alfa", "cliente": "Cliente X"},
        "turbina": {"numero_identificacao": "T-01", "modelo": "TX"},
        "inspection": {"status": "finalizada", "respostas_json": {"ok": True}},
        "checklist": {"estrutura_json": {"itens": ["torre", "pás"]}},
    }

    result = PdfGenerator().generate("insp-1", bundle)

    assert isinstance(result, Path)
    assert result.exists()
    assert result.stat().st_size > 0
