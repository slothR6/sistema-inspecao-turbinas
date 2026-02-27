from pathlib import Path

from google.cloud import storage


class StorageService:
    def __init__(self, bucket_name: str, client: storage.Client | None = None) -> None:
        self.client = client or storage.Client()
        self.bucket = self.client.bucket(bucket_name)

    def upload_pdf(self, inspection_id: str, file_path: Path) -> str:
        blob = self.bucket.blob(f"laudos/{inspection_id}.pdf")
        blob.upload_from_filename(file_path)
        return blob.public_url
