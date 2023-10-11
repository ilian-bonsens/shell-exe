#!/bin/bash

connexions=$(last | grep -r ilian | wc -l)

datef=$(date +"%d-%m-%Y-%H:%M")

nom_fichier="number_connection-$datef"

echo $connexions > $nom_fichier

mkdir -p Backup

tar -cf "/home/ilian/shell-exe/Job08/Backup/number_connection-$datef.tar" "$nom_fichier"

rm $nom_fichier

#j'ai eu pas mal de problèmes avec le crontab, pour réussir à le faire fonctionner jai créé un fichier cron.log qui me donnait
#les sorties et les erreurs pdt l'execution du cron. pour ce faire jai rajouté la commande suivante à la fin du cron
# >> /home/ilian/shell-exe/Job08/cron.log 2>&1 ; j'ai aussi enlevé le /var/log comme repertoire ou le grep doit chercher et je lai
#remplacé par last | pour avoir seulement les derniers logs de mon utilisateur et qu'ils aillent directement dans le grep
