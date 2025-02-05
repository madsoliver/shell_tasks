#!/bin/bash

# Sjekk størrelse, antall mapper og brukerkontoer før opprydding
BEFORE_SIZE=$(du -sh /home | awk '{print $1}')
BEFORE_DIRS=$(find /home -maxdepth 1 -type d | wc -l)
BEFORE_USERS=$(ls -1 /home | wc -l)

echo "Størrelse før opprydding: $BEFORE_SIZE"
echo "Antall mapper før opprydding: $BEFORE_DIRS"
echo "Antall brukerkontoer før opprydding: $BEFORE_USERS"
echo "Starter opprydding..."

# Fjern loggfiler i sc* katalogene
echo "Fjerner loggfiler..."
rm -f /home/sc*/logs/*

# Fjern error_log filer i www og kontrollpanel
echo "Fjerner error_log filer..."
rm -f /home/sc*/www/error_log
rm -f /home/sc*/www/kontrollpanel/error_log

# Fjern tar.gz arkiver i /home/sc*
echo "Fjerner .tar.gz filer..."
rm -f /home/sc*/*.tar.gz

# Fjern var/logs kataloger og innhold
echo "Fjerner var/logs kataloger..."
rm -rf /home/sc*/www/var/log
rm -rf /home/sc*/www/var/logs

# Fjern cache dev kataloger
echo "Fjerner cache..."
rm -rf /home/sc*/www/var/cache/dev

# Fjern modulfiler i zip-format
echo "Fjerner .zip modulfiler..."
rm -f /home/sc*/www/modules/*.zip

# Fjern alt i trash-mapper
echo "Tømmer trash-mapper..."
rm -rf /home/sc*/.trash/*

# Sjekk størrelse, antall mapper og brukerkontoer etter opprydding
AFTER_SIZE=$(du -sh /home | awk '{print $1}')
AFTER_DIRS=$(find /home -maxdepth 1 -type d | wc -l)
AFTER_USERS=$(ls -1 /home | wc -l)

# Beregn forskjell
FREED_SPACE=$(numfmt --to=iec $(( $(du -sb /home | awk '{print $1}') - $(du -sb /home | awk '{print $1}') )))
DELETED_DIRS=$((BEFORE_DIRS - AFTER_DIRS))
DELETED_USERS=$((BEFORE_USERS - AFTER_USERS))

echo "Størrelse etter opprydding: $AFTER_SIZE"
echo "Antall mapper etter opprydding: $AFTER_DIRS"
echo "Antall brukerkontoer etter opprydding: $AFTER_USERS"
echo "Frigjort plass: $FREED_SPACE"
echo "Slettede mapper: $DELETED_DIRS"
echo "Endring i brukerkontoer: $DELETED_USERS"

echo "Opprydding fullført!"
exit 0
