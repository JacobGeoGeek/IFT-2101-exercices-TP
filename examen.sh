clear
echo -e "entrer Nom et prénom \c"
read nom prenom
clear
echo "Bonjour $prenom"
echo -e "On se porte bien en confinement (oui/non)? \c"
read reponse
if [ "$reponse" = "oui" ]; then
    echo "Content de lire ça"
    sleep 2
else
    echo "Sinon il affiche Désolé, si tu as besoin d'aide n'hésite pas à nous écrire pendant"
    sleep 4
fi
clear
echo -e "Quel bout de code cherches-tu aujourd'hui? \c"
read code
ls /programmation | grep $code
echo "Merci $prenom. Bon courage!"


