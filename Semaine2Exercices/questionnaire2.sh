#************************************************************* 
# Fichier  : questionnaire 
#  Projet : Exercices supplémentaires
# Auteur(s) : Carl Simard 
# Groupe :  
# Cours  : Systèmes d'exploitation  
# École  : 
# Session :  
# Notes  : Permet de vous pratiquer un peu :-) 
#************************************************************* 

#************************************************************* 
# Fonction : diredate 
#  Objectif : Affiche la date de naissance de l'usager 
# Notes  :  
#************************************************************* 
function diredate {

    echo -e "Fonction naissance"
    echo -e "Vous êtes né le $1 $2 $3 \n" 
}

#************************************************************* 
# Fonction : direage
#  Objectif : Affiche l'âge de l'usager 
# Notes  : 
#*************************************************************

function direage {
    echo -e "Fonction âge"
    echo -e "Vous avez $1 ans \n"
}

#************************************************************* 
# Fonction : prenom 
#  Objectif : Affiche le prénom de l'usager 
# Notes  :  
#************************************************************* 
function prenom {
    echo -e "Fonction prénom"
    echo "Votre Prénom est $1"
}


#************************************************************* 
# Fonction : nom 
#  Objectif : Affiche le nom de l'usager 
# Notes  :  
#************************************************************* 
function nom {
    echo -e "Fonction nom"
    echo "Votre nom est $1"
}

#************************************************************* 
# Fonction : 
#  Objectif : Script principal du questionnaire 
# Notes  :  
#************************************************************* 

clear
echo -e "Donnez votre âge : \c"
read age
echo -e "Donnez votre date de naissance : \c" 
read naissance
echo -e "Donnez votre date de naissance : \c" 
echo -e "\n" 
direage $age
diredate $naissance
prenom $1 
nom $2 
echo -e "$1 $2 ne le $naissance \n" 
echo "Fin du questionnaire" 
