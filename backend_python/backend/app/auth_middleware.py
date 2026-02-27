from fastapi import Header, HTTPException
from firebase_admin import auth


async def get_current_user(authorization: str = Header(default="")) -> dict:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Token ausente")
    token = authorization.replace("Bearer ", "")
    try:
        decoded = auth.verify_id_token(token)
    except Exception as exc:  # pragma: no cover
        raise HTTPException(status_code=401, detail="Token inválido") from exc
    return decoded


def assert_role(user: dict, roles: set[str]) -> None:
    role = user.get("role")
    if role not in roles:
        raise HTTPException(status_code=403, detail="Sem permissão para esta ação")
