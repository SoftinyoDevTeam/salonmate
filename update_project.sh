#!/bin/bash

# Kullanım kılavuzu
usage() {
  echo "Kullanım: $0 --source-dir <source-dir> --output-dir <output-dir> --app-name <app-name> --package-name <package-name>"
  exit 1
}

# Varsayılan değerler
source_dir=""
output_dir=""
app_name=""
package_name=""

# Parametreleri işle
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --source-dir) source_dir="$2"; shift ;;
    --output-dir) output_dir="$2"; shift ;;
    --app-name) app_name="$2"; shift ;;
    --package-name) package_name="$2"; shift ;;
    -h|--help) usage ;;
    *) echo "Bilinmeyen parametre: $1"; usage ;;
  esac
  shift
done

# Gerekli parametreleri kontrol et
if [[ -z "$source_dir" || -z "$output_dir" || -z "$app_name" || -z "$package_name" ]]; then
  echo "HATA: --source-dir, --output-dir, --app-name ve --package-name parametreleri zorunludur."
  usage
fi

# Flutter komutlarını çalıştır
echo "1. Easy Localization dosyalarını oluşturuluyor..."
flutter pub run easy_localization:generate --source-dir "$source_dir" --output-dir "$output_dir"

echo "2. İkonlar güncelleniyor..."
dart run icons_launcher:create

echo "3. Uygulama adı değiştiriliyor..."
dart run rename_app:main android="$app_name" ios="$app_name" others="$app_name"

echo "4. Paket ismi değiştiriliyor..."
dart run change_app_package_name:main "$package_name"

echo "İşlemler tamamlandı!"
