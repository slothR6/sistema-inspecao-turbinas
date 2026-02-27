from reportlab.lib.colors import Color
from reportlab.pdfgen.canvas import Canvas


def draw_watermark(canvas: Canvas, text: str = "CONFIDENCIAL") -> None:
    canvas.saveState()
    canvas.setFillColor(Color(0.85, 0.85, 0.85, alpha=0.25))
    canvas.setFont("Helvetica-Bold", 52)
    canvas.translate(300, 400)
    canvas.rotate(45)
    canvas.drawCentredString(0, 0, text)
    canvas.restoreState()
