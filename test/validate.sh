#!/bin/sh
set -eu

python3 - <<'PY'
import json
from pathlib import Path

build = json.loads(Path(".deploy/build.yaml").read_text(encoding="utf-8"))

assert build["serviceId"] == "rustdesk-server"
assert build["runtime"]["type"] == "container-mirror"
assert build["runtime"]["version"] == "1.1.15"
assert build["deploy"]["defaultTarget"] == "full"
assert build["deploy"]["productionRegistry"] == "acr"

image_names = [image["name"] for image in build["images"]]
assert image_names == ["hbbs", "hbbr"]
for image in build["images"]:
    assert image["dockerfile"] == "Dockerfile"
    assert image["context"] == "."

dockerfile = Path("Dockerfile").read_text(encoding="utf-8").strip()
assert dockerfile == "FROM rustdesk/rustdesk-server:1.1.15"
PY
