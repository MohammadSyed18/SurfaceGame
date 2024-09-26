"""Validate registered GML resources and event files without claiming compilation."""
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]


def read_asset(path):
    # GameMaker asset files permit trailing commas.
    return json.loads(re.sub(r",(\s*[}\]])", r"\1", path.read_text()))


def main():
    project = read_asset(ROOT / "SurfaceGAME.yyp")
    identifiers = set()
    scripts = []
    for entry in project["resources"]:
        identifier = entry["id"]
        path = ROOT / identifier["path"]
        if not path.is_file(): raise ValueError(f"missing resource: {path}")
        if identifier["name"] in identifiers: raise ValueError("duplicate resource name")
        identifiers.add(identifier["name"])
        asset = read_asset(path)
        if asset["name"] != identifier["name"]: raise ValueError("resource name mismatch")
        if asset["resourceType"] == "GMScript":
            source = path.with_suffix(".gml")
            if not source.is_file(): raise ValueError(f"missing script source: {source}")
            scripts.append(source)
    player = read_asset(ROOT / "objects/oSub/oSub.yy")
    expected = {(0, 0): "Create_0.gml", (3, 0): "Step_0.gml", (8, 64): "Draw_64.gml"}
    events = {(event["eventType"], event["eventNum"]) for event in player["eventList"]}
    if not expected.keys() <= events: raise ValueError("submarine event registration is incomplete")
    sources = [ROOT / "objects/oSub" / name for name in expected.values()] + scripts
    functions = set()
    calls = set()
    for source in sources:
        body = source.read_text()
        functions.update(re.findall(r"function\s+(sub_\w+)\s*\(", body))
        calls.update(re.findall(r"\b(sub_\w+)\s*\(", body))
    if calls - functions: raise ValueError(f"undefined submarine helpers: {sorted(calls-functions)}")
    print(f"Checked {len(identifiers)} registered assets, {len(scripts)} scripts, and submarine events. GameMaker runtime validation is separate.")


if __name__ == "__main__": main()
