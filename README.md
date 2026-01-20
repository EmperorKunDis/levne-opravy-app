# Levné Opravy - Flutter UI Prototyp

**Digitální stavbyvedoucí do kapsy**

Mobilní aplikace pro zákazníky firmy Levné Opravy, která umožňuje sledovat průběh rekonstrukcí a stavebních prací v reálném čase.

## Funkce

- **Dashboard** - Přehled aktuální zakázky s časovou osou
- **Katalog služeb** - Přehled všech nabízených služeb s cenami
- **Interaktivní kalkulátor** - Orientační kalkulace ceny prací
- **Schvalování víceprací** - Přehledné schválení změn a navýšení ceny
- **Fotodokumentace** - Galerie fotek z průběhu stavby
- **Dokumenty** - Přístup ke smlouvám, fakturám a protokolům

## Technologie

- **Framework:** Flutter 3.x
- **Jazyk:** Dart
- **Platforma:** Web (PWA ready)
- **IDE kompatibilita:** FlutLab.io

## Struktura projektu

```
lib/
├── main.dart                    # Vstupní bod aplikace
├── app.dart                     # Konfigurace aplikace a routing
├── theme/
│   └── app_theme.dart           # Barevné schéma a téma
├── models/
│   ├── service.dart             # Model služby
│   ├── order.dart               # Model zakázky
│   └── milestone.dart           # Model milníku
├── screens/
│   ├── home/                    # Dashboard
│   ├── catalog/                 # Katalog služeb
│   ├── calculator/              # Kalkulátor ceny
│   ├── order_detail/            # Detail zakázky
│   ├── extra_work/              # Schválení víceprací
│   ├── photos/                  # Fotodokumentace
│   └── documents/               # Dokumenty
├── widgets/
│   ├── bottom_nav.dart          # Spodní navigace
│   ├── timeline_widget.dart     # Timeline stavebního deníku
│   ├── service_card.dart        # Karta služby
│   └── notification_card.dart   # Notifikační karta
└── data/
    └── mock_data.dart           # Testovací data
```

## Barevné schéma

| Barva | Hex | Použití |
|-------|-----|---------|
| Primární | `#E30613` | Hlavní akcenty, tlačítka |
| Sekundární | `#FFFFFF` | Pozadí karet |
| Text | `#333333` | Hlavní text |
| Pozadí | `#F5F5F5` | Pozadí aplikace |
| Úspěch | `#4CAF50` | Potvrzení, dokončeno |
| Varování | `#FF9800` | Upozornění |

## Spuštění projektu

### Lokálně

```bash
# Instalace závislostí
flutter pub get

# Spuštění pro web
flutter run -d chrome

# Build pro web
flutter build web
```

### FlutLab.io

1. Importujte projekt do FlutLab.io
2. Projekt se automaticky nakonfiguruje
3. Klikněte na "Run" pro spuštění

## Obrazovky

### Home (Dashboard)
- Logo a branding Levné Opravy
- Notifikace vyžadující pozornost (vícepráce)
- Přehled aktuální zakázky
- Stavební deník s timeline milníků
- Rychlé akce (Katalog, Kalkulátor)

### Katalog služeb
- Grid kategorií služeb
- Seznam služeb v kategorii
- Detail služby s cenou a popisem
- Možnost kalkulace nebo poptávky

### Kalkulátor
- Výběr typu práce
- Zadání plochy (slider + input)
- Výběr kvality (Standard/Premium)
- Doplňkové služby (checkboxy)
- Zobrazení orientační ceny

### Detail víceprací
- Popis změny s fotografií
- Porovnání původní vs. nová cena
- Checkbox souhlasu
- Tlačítko schválení/odmítnutí

### Fotodokumentace
- Filtrování dle milníků
- Grid fotek dle data
- Detail fotky s možností stažení

### Dokumenty
- Filtrování dle typu (smlouvy, faktury, protokoly)
- Seznam dokumentů
- Náhled a stažení PDF

## PWA

Aplikace je připravena jako Progressive Web App:
- Manifest s ikonami a barvami
- Offline placeholder
- Instalovatelná na mobil

## Další vývoj

- [ ] Napojení na backend API
- [ ] Push notifikace
- [ ] Chat s řemeslníky
- [ ] Elektronický podpis
- [ ] Platební brána

## Licence

Proprietární software - Levné Opravy s.r.o.
