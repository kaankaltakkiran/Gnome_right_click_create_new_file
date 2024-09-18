#!/bin/bash

# Gerekli dosya isimleri ve içerikleri
declare -A templates
templates=(
  ["New Shell Script.sh"]="#!/bin/bash"
  ["New Markdown File.md"]="#"
  ["New Txt File.txt"]=""
  ["New ODS Spreadsheet.ods"]=""
  ["New ODP Presentation.odp"]=""
  ["New ODT Document.odt"]=""
)

# Kullanıcı dizinlerindeki yapılandırma dosyasını kontrol et
if [ -f ~/.config/user-dirs.dirs ]; then
    # Yapılandırma dosyasını oku
    source ~/.config/user-dirs.dirs
    TEMPLATES_DIR=$XDG_TEMPLATES_DIR
else
    # Yapılandırma dosyası yoksa oluştur ve güncelle
    echo "Yapılandırma dosyası bulunamadı. Oluşturuluyor..."
    xdg-user-dirs-update
    source ~/.config/user-dirs.dirs
    TEMPLATES_DIR=$XDG_TEMPLATES_DIR
fi

# Templates klasörünü kontrol et, yoksa oluştur
if [ ! -d "$TEMPLATES_DIR" ]; then
    echo "Templates klasörü bulunamadı, oluşturuluyor..."
    mkdir -p "$TEMPLATES_DIR"
else
    echo "Templates klasörü bulundu: $TEMPLATES_DIR"
fi

# Dosyaları Templates klasörüne ekle
echo "Dosyalar ekleniyor..."
for file in "${!templates[@]}"; do
    filePath="$TEMPLATES_DIR/$file"
    echo "${templates[$file]}" > "$filePath"
    echo "$file oluşturuldu."
done

# .sh dosyalarını çalıştırılabilir yap
chmod +x "$TEMPLATES_DIR/New Shell Script.sh"

# Nautilus'u yeniden başlat
echo "Nautilus yeniden başlatılıyor..."
nautilus -q && nautilus &

echo "İşlem tamamlandı! Sağ tıklama menüsünde yeni şablonlar görünmeli."
