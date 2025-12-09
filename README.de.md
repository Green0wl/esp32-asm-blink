## Beschreibung:
Ziel des Projekts ist es, eine rudimentäre Version der Funktionalität bereitzustellen, die das periodische Blinken der integrierten LED auf dem ESP32 (Chip: ESP32-WROOM-32; Board: ESP-32S) auslöst. Die Programmierung des 32-Bit-Xtensa-LX6-Prozessors erfolgt mittels Assembly-Sprache (RISC-V 32-Bit).

Der bereitgestellte Code besitzt theoretisch die Fähigkeit, auf jedem Mikrocontroller der ESP32-Familie zu funktionieren, der über eine LED verfügt, die mit GPIO2 verbunden ist. Für ESP32-Mikrocontroller ohne integrierte LED an GPIO2 wurde theoretisiert, dass die Verwendung einer normalen LED zusammen mit einem Widerstand geeigneter Größe analoge Ergebnisse liefern sollte.

Das Projekt ist in drei Bestandteile unterteilt, die in den Dateien `Makefile`, `so.ld` und `so.s` beschrieben sind. Der Zweck dieser Dateien besteht darin, den Build-Prozess zu automatisieren, das Format und Layout der finalen ausführbaren Binärdatei festzulegen und die Funktionalität in Assembly zu beschreiben.

Es wird angenommen, dass der angeschlossene ESP32 vom System als `/dev/ttyUSB0` erkannt wird. Diese Adresse wird in den folgenden Abschnitten und automatisierten Skripten verwendet.

Falls weitere Erläuterungen erforderlich sind, wird empfohlen, direkt auf den Code zu verweisen, da er umfassend dokumentiert ist.

## Installation der Abhängigkeiten über die Kommandozeile (Ubuntu):
```shell
~$ sudo apt-get install git wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 build-essential
~$ mkdir -p ~/esp
~$ cd ~/esp

# Zuerst herausfinden, welches das neueste Versionstag ist. Zum Zeitpunkt der Erstellung dieser Dokumentation war v5.5.1 die neueste Version.
~/esp$ git clone -b v5.5.1 -recursive https://github.com/espressif/esp-idf.git

~/esp$ cd ./esp-idf
~/esp/esp-idf$ ./install.sh esp32
~/esp/esp-idf$ . ./export.sh

# Optional: prüfen, ob die Werkzeuge installiert wurden.
~/esp/esp-idf$ idf.py --help
```

## Flashen:
Es wird davon ausgegangen, dass der Abschnitt zur Installation der Abhängigkeiten strikt gemäß den bereitgestellten Anweisungen durchgeführt wurde. Dieser Abschnitt liefert eine umfassende, schrittweise Anleitung zum erneuten Flashen des ESP32 mit den oben genannten Spezifikationen, um das Blinken der LED zu erreichen.
```shell
# Projekt klonen:
~$ cd ~/Downloads/
~/Downloads$ git clone https://github.com/Green0wl/esp32-asm-blink.git

# Umgebungsvariablen vorbereiten:
~/Downloads$ cd ~/esp/esp-idf/
~/esp/esp-idf$ . ./export.sh

# Kompilieren und flashen (ESP32 jetzt anschließen):
~/esp/esp-idf$ cd ~/Downloads/esp32-asm-blink/
~/Downloads/esp32-asm-blink$ make flash
# Ungefähr zwei Sekunden später sollte die ESP-32S zu blinken beginnen.
```

## Löschen:
Diese Befehle löschen den Flash-Speicher des ESP32 von den Anweisungen, die das Blinken der LED verursachen:
```shell
~$ cd ~/esp/esp-idf/
~/esp/esp-idf$ . ./export.sh
~/esp/esp-idf$ esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
```
