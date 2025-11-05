import json
import tomli_w
from pathlib import Path

# Setup directories
locales_dir = Path("frontend/public/locales")
output_dir = Path("frontend/public/locales")
output_dir.mkdir(exist_ok=True)

# Find all translation.json files
json_files = sorted(locales_dir.glob("*/translation.json"))

print(f"Found {len(json_files)} translation files\n")

# Convert each file
for json_file in json_files:
    locale = json_file.parent.name

    # Create output locale directory
    locale_output = output_dir / locale
    locale_output.mkdir(exist_ok=True)

    # Convert JSON to TOML
    toml_file = locale_output / "translation.toml"

    with open(json_file) as j:
        with open(toml_file, 'wb') as t:
            tomli_w.dump(json.load(j), t)

    print(f"Converted {locale}")

print(f"\nDone! Converted {len(json_files)} files to {output_dir}/")
