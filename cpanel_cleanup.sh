#!/bin/bash

# Sjekk størrelse før opprydding
BEFORE=$(du -sh /home | awk '{print $1}')
echo "Størrelse før opprydding: $BEFORE"

# Fjern loggfiler i sc* katalogene
rm -f /home/sc*/logs/*

# Fjern error_log filer i www og kontrollpanel
rm -f /home/sc*/www/error_log
rm -f /home/sc*/www/kontrollpanel/error_log

# Fjern tar.gz arkiver i /home/sc*
rm -f /home/sc*/*.tar.gz

# Fjern var/logs kataloger og innhold
rm -rf /home/sc*/www/var/log
rm -rf /home/sc*/www/var/logs

# Fjern cache dev kataloger
rm -rf /home/sc*/www/var/cache/dev

# Fjern modulfiler i zip-format
rm -f /home/sc*/www/modules/*.zip

# Fjern alt i trash-mapper
rm -rf /home/sc*/.trash/*

# Sjekk størrelse etter opprydding
AFTER=$(du -sh /home | awk '{print $1}')
echo "Størrelse etter opprydding: $AFTER"

# Beregn frigjort plass
echo "Frigjort plass: $(numfmt --to=iec $(( $(du -sb /home | awk '{print $1}') - $(du -sb /home | awk '{print $1}') )))"

echo "Opprydding fullført!"
