#!/bin/bash

#Création des variables fichier, path, modif et lastmodif
fichier="Shell_Userlist.csv"

#path=$ variable path, dirname est une commande qui extrait le répertoire parent du fichier dans lequel elle se trouve (ici /home/ilian/shell-exe/Job09/), "$0" variable spéciale qui renvoie le nom du scrpit dans lequel elle est exécutée (ici acessrights.sh) 
path=$(dirname "$0")

#variable modif qui lit le fichier modif presént dans le dossier du script (contient les dates exactes de modification du csv)
modif=$(cat "$path/modif")

#variable lastmodif qui va récupérer la dernière date de modification de la variable $fichier qui contient le csv et la mettre au format AAAA-mm-jj H:M:S
lastmodif=$(date -r "$path/$fichier" '+%Y-%m-%d %H:%M:%S')

if [[ "$modif" != "$lastmodif" ]]; then

    while IFS="," read -r id prenom nom mdp role; do

#créé variable user au format prenom.nom le tout en minuscule grace à tr upper lower qui change les maj en min
        user=$(echo "$prenom.$nom" | tr '[:upper:]' '[:lower:]')

        nrole=$(echo "$role")
        sudo useradd "$user"

#affiche les var username et mdp au format username:mdp et créé le passwd de l'user en question en lisant son mdp dans le csv
        echo "$user:$mdp" | sudo chpasswd

#si var nrole=Admin alors ajouter user aux groupe sudo sinon ajouter user au grouper utilisateurs
        [ "$nrole" = "Admin" ] && sudo usermod -aG sudo "$user" || sudo usermod -aG users "$user"
        echo "did $user"

#< < prend le contenue des () et l'utilise comme données en entrée de la boucle while
    done < <(tail -n +2 "$path/$fichier"| tr -d " ")

    date -r "$path/$fichier" '+%Y-%m-%d %H:%M:%S' > "$path/modif"
fi
