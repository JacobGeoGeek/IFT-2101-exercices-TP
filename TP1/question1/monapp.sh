#!/bin/bash

#************************************************************* 
# Fonction : sousMenuDisque
#  Objectif : permet de quitter le programme monapp et revenir au prompt 
# Notes  :  
#*************************************************************
function sousMenuDisque {
    if [ -n "$1"]; 
    then
        #TODO
    else
        echo "Menu Disque";
        echo "1-Partition";
        echo "2-Recherce";
        echo "M-Revenir";
        
        local choixEstValide=false
        while !($choixEstValide)
        do
            echo -e "Veuillez choisir l'un des 5 options: \c"
            read option demande
            if [[ $option -eq 1 || $option -eq 2 || "$option" = "M" ]];
            then
                choixEstValide=true;
            else echo "votre choix ne fais pas partie de la liste. Veuillez recommencez";
           fi  
        done 

        case $choixSousMenu in 
            1) disquePartion $demande;;
            2) disqueRecherche $demande;;
            M) afficherMenuPrincipale;;
        esac  
    
    fi
} 

function sousMenuSysteme {
    echo "Menu System"
    echo -e "$1"
    echo -e "$2"
}

function sousMenuReseau {
    echo "Menu Reseau"
    echo -e "$1"
    echo -e "$2"
}

function sousMenuStocks {
    
    echo -e "$1"
    echo -e "$2"
}

#************************************************************* 
# Fonction : quitterProgramme
#  Objectif : permet de quitter le programme monapp et revenir au prompt 
# Notes  :  
#************************************************************* 
function quitterProgramme {
    clear
    echo "Merci d'avoir utilisé le programme Mon App. Au plaisir de vous revoir."
    sleep 2
    clear
    exit
}

#************************************************************* 
# Fonction : affcherMenuPrincipale
#  Objectif : affiche le menu principale 
# Notes  :  
#************************************************************* 
function afficherMenuPrincipale {
    echo -e "Menu Principale: \n"
    echo "#-Disque"
    echo "$-Système"
    echo "&-Reseau"
    echo ":-Stocks"
    echo -e "Z-Quitter \n"
    

    local choixEstValide=false
    while !($choixEstValide)
    do
        echo -e "Veuillez choisir l'un des 5 options ainsi que le option de son programme a executé par rapport (celui est optionnelle): \c"
        read choixSousMenu programmeExecute
        if [[ "$choixSousMenu" = "#" || "$choixSousMenu" = "$" || "$choixSousMenu" = "&" || "$choixSousMenu" = ":" || "$choixSousMenu" = "Z" ]];
        then
            choixEstValide=true;
        else echo "votre choix ne fais pas partie de la liste. Veuillez recommencez";
       fi  
    done    

    case "$choixSousMenu" in 
    "#") sousMenuDisque $programmeExecute;;
    "$") sousMenuSysteme $programmeExecute;;
    "&") sousMenuReseau $programmeExecute;;
    ":") sousMenuStocks $programmeExecute;;
    "Z") quitterProgramme;;
    esac
    
}



#************************************************************* 
# Fonction : 
#  Objectif : Script principal du questionnaire 
# Notes  :  
#************************************************************* 
clear
afficherMenuPrincipale

