from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    project_id: str = "demo-project"
    storage_bucket: str = "demo-bucket"
    firebase_credentials_path: str = "./service-account.json"

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")


settings = Settings()
