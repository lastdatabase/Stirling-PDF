#!/bin/bash
# Execute git mv operations from properties to TOML to preserve history

set -e

# Array of locale pairs: "old_locale:new_locale"
locales=(
  "ar_AR:ar-AR"
  "az_AZ:az-AZ"
  "bg_BG:bg-BG"
  "bo_CN:zh-BO"
  "ca_CA:ca-CA"
  "cs_CZ:cs-CZ"
  "da_DK:da-DK"
  "de_DE:de-DE"
  "el_GR:el-GR"
  "en_GB:en-GB"
  "en_US:en-US"
  "es_ES:es-ES"
  "eu_ES:eu-ES"
  "fa_IR:fa-IR"
  "fr_FR:fr-FR"
  "ga_IE:ga-IE"
  "hi_IN:hi-IN"
  "hr_HR:hr-HR"
  "hu_HU:hu-HU"
  "id_ID:id-ID"
  "it_IT:it-IT"
  "ja_JP:ja-JP"
  "ko_KR:ko-KR"
  "ml_IN:ml-ML"
  "nl_NL:nl-NL"
  "no_NB:no-NB"
  "pl_PL:pl-PL"
  "pt_BR:pt-BR"
  "pt_PT:pt-PT"
  "ro_RO:ro-RO"
  "ru_RU:ru-RU"
  "sk_SK:sk-SK"
  "sl_SI:sl-SI"
  "sr_LATN_RS:sr-LATN-RS"
  "sv_SE:sv-SE"
  "th_TH:th-TH"
  "tr_TR:tr-TR"
  "uk_UA:uk-UA"
  "vi_VN:vi-VN"
  "zh_CN:zh-CN"
  "zh_TW:zh-TW"
)

count=0
for pair in "${locales[@]}"; do
  old_locale="${pair%%:*}"
  new_locale="${pair##*:}"

  src="app/core/src/main/resources/messages_${old_locale}.properties"
  dst="frontend/public/locales/${new_locale}/translation.toml"

  if [ -f "$src" ]; then
    echo "Moving $old_locale -> $new_locale"
    mkdir -p "frontend/public/locales/${new_locale}"
    git mv "$src" "$dst"
    count=$((count + 1))
  else
    echo "Warning: $src not found"
  fi
done

echo "Done! Moved $count translation files"
