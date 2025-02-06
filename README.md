# Fallstudie: Analyse von Airbnb-Angeboten in Berlin mit SQL und Tableau
## Einführung
In dieser Fallstudie werde ich die Airbnb-Angebote in Berlin im Juli 2021 mit SQL untersuchen, um verschiedene Aspekte des kurzfristigen Mietmarkts und dessen Muster zu verstehen. Der Dataset enthält detaillierte Informationen zu Airbnb-Angeboten in der gesamten Stadt. Anschließend werde ich die Daten visualisieren, indem ich ein Dashboard mit Tableau erstelle.

Die Analyse zielt darauf ab, Muster und Erkenntnisse zu folgenden Schlüsselfragen zu gewinnen:

- Wie viele komplette Wohnungen sind das ganze Jahr über oder für mehr als sechs Monate verfügbar?
- Wie viele Zimmer werden von Gastgebern vermietet, die eine oder mehrere Unterkünfte besitzen?
- Wie beeinflusst der Besitz mehrerer Zimmer oder Wohnungen den Mietpreis?
- In welchen Bezirken Berlins ist der Preisunterschied zwischen Eigentümern mit einer und mehreren Wohnungen am größten?
- Wie unterscheiden sich Ost- und West-Berlin in Bezug auf Preise, Zimmertypen und Gastgeber?

Die Analyse wird mit MySQL durchgeführt, wobei ich Daten abfrage und verarbeite, um Trends und Erkenntnisse aufzudecken. Zusätzlich erstelle ich Visualisierungen mit Tableau, um die Analyse zu ergänzen und die Ergebnisse besser zu interpretieren.

## Übersicht über den Datensatz
Der in dieser Fallstudie verwendete Datensatz stammt aus [diesem Kaggle-Dataset](https://www.kaggle.com/datasets/lennarthaupts/airbnb-berlin-july-2021/data). Er enthält eine Vielzahl von Details zu Airbnb-Angeboten in Berlin, darunter:

- Angebots-IDs
- Informationen über Gastgeber
- Zimmertypen (komplette Wohnung, privates Zimmer, gemeinsames Zimmer)
- Preis pro Nacht
- Standort
- Verfügbarkeit im Laufe des Jahres

Sie können den Datensatz und das für die Analyse verwendete SQL-Skript über die folgenden Links herunterladen:

Dataset herunterladen
[Dataset herunterladen](https://github.com/andrealionzo/case-study/blob/main/listings_berlin1.csv)

[SQL-Skript ansehen](https://github.com/andrealionzo/case-study/blob/main/case-study-berlin-airbnb.sql)

## Vorgehensweise
Um die Daten zu erkunden und zu analysieren, habe ich mehrere SQL-Queries geschrieben, um die Daten zu bereinigen und die notwendigen Informationen zu extrahieren, um die oben genannten Fragen zu beantworten.

## Wichtige Erkenntnisse & Ergebnisse
Einige der wichtigsten Erkenntnisse aus der Analyse sind:

- Wohnungsverfügbarkeit: Die Anzahl der vollständigen Wohnungen, die länger als sechs Monate verfügbar sind, war geringer (etwa ein Drittel) als die Gesamtzahl der vollständigen Wohnungen. Dies deutet darauf hin, dass es einen starken Markt für ganze Wohnungen auf Airbnb gibt. Dasselbe gilt für private Zimmer.
- Gastgeber mit mehreren Inseraten: Gastgeber, die mehrere Inserate besitzen, verlangen tendenziell niedrigere Preise für ihre Unterkünfte. Dies könnte auf Skaleneffekte zurückzuführen sein (der Besitz mehrerer Wohnungen/Zimmer senkt die Kosten pro Einheit) sowie auf wettbewerbsfähige Preisstrategien, um eine höhere Auslastung ihrer Unterkünfte zu gewährleisten.
- Geografische Unterschiede: Es gab deutliche Preisunterschiede zwischen Ost- und West-Berlin. In Ost-Berlin waren die Preise höher (74 Euro vs. 61 Euro in West-Berlin). Zudem war die Anzahl der auf Airbnb gelisteten Unterkünfte in Ost-Berlin höher als in West-Berlin (1480 vs. 744). Dies ist eine interessante und möglicherweise unerwartete Erkenntnis, die einer weiteren Analyse wert sein könnte.

## Visualisierungen
Um das Verständnis der Daten und Erkenntnisse zu verbessern, habe ich eine Reihe interaktiver Visualisierungen in Tableau Public erstellt. Diese Visualisierungen zeigen:

- Die Verteilung der Inserate und die durchschnittlichen Preise in verschiedenen Bezirken.
- Preistrends bei Gastgebern mit einer vs. mehreren Unterkünften.
- Die Verfügbarkeit von Inseraten für mehr oder weniger als sechs Monate im Jahr.

Sie können diese Visualisierungen hier erkunden:

[Visualisierungen auf Tableau Public ansehen](https://public.tableau.com/views/BerlinAirbnbCaseStudy_17365354378540/BerlinAirBnbListingsbyDistrict?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Fazit
Diese Fallstudie zeigt, wie Airbnb-Angebote in Berlin über die Stadt verteilt sind und welche Muster sich in Bezug auf Preise, Immobilienverteilung nach Bezirken, Zimmertypen und Gastgeber ergeben. Die gewonnenen Erkenntnisse bieten ein besseres Verständnis des kurzfristigen Mietmarkts in Berlin, insbesondere im Kontext steigender Mietpreise und der Verfügbarkeit von Unterkünften.
