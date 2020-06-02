#!/bin/bash


#************************************************************* 
# Fonction : verifierChoixUsager
#  Objectif : verifie l'option que l'usager a choisie dans un sous-menu
# Notes  :  cette fonction s'applique seulement pour les sous-menus: Disque, Système 
#*************************************************************
function verifierChoixUsager {
        local choixEstValide=false
        while !($choixEstValide)
        do
            echo -e "Veuillez choisir l'un des 3 options: \c"
            read option specification
            if [[ $option -eq 1 || $option -eq 2 || $option = M ]];
            then
                choixEstValide=true;
            else echo "votre choix ne fais pas partie de la liste. Veuillez recommencez";
           fi  
        done 
}

#************************************************************* 
# Fonction : disquePartion
#  Objectif : permet d'afficher les partition de disques
# Notes  :  
#*************************************************************
function disquePartion {
    if [ -z "$1" ];
    then
        fdisk -l;
        sleep 5
        sousMenuDisque;
    else
       local pathPartition=/dev/$1
       echo $pathPartition
        if [ -e $pathPartition ];
        then
            fdisk -l $pathPartition;
            sleep 5;
            sousMenuDisque;
        else 
            echo "La partion n'existe pas.";
            sousMenuDisque;
        fi
    fi
}

#************************************************************* 
# Fonction : disqueRecherche
#  Objectif : permet recherche un fichier contenant un mot mentionné par l'usager
# Notes  :  
#*************************************************************
function disqueRecherche {
    if [ -z "$1" ]; then
        echo "pour la recherche veuillez entrer un mot";
        sleep 5;
        sousMenuDisque;
    else
        find ~/ -name *$1*;
        sleep 5;
        sousMenuDisque;
    fi

}

#************************************************************* 
# Fonction : sousMenuDisque
#  Objectif : permet d'afficher le sous menu du disque
# Notes  :  
#*************************************************************
function sousMenuDisque {
    clear
    if [ -n "$1" ]; 
    then
         case $1 in 
            1) disquePartion $2;;
            2) disqueRecherche $2;;
            M) afficherMenuPrincipale;;
            *) echo "l'option entrer, en seconde paramètre n'existe pas"
               afficherMenuPrincipale;;
        esac  
    else
        echo "Menu Disque";
        echo "1-Partition";
        echo "2-Recherce";
        echo "M-Revenir";
        
        verifierChoixUsager
        case $option in 
            1) disquePartion $specification;;
            2) disqueRecherche $specification;;
            M) afficherMenuPrincipale;;
        esac  
    
    fi
}

#************************************************************* 
# Fonction : systemeMoniteur
#  Objectif : affiche les processus en execution ainsi que le detail des threads
# Notes  :  
#*************************************************************
function systemeMoniteur {
    top -H;
    clear;
    sousMenuSysteme;
}

#************************************************************* 
# Fonction : systemTacgeRecyrrente
#  Objectif : Affiche la liste des fichiers ouverts.
# Notes  :  si peux egalenment specifier un nom service qu'on souhaite d'afficher les fichier 
#            ouvert de celui-ci 
#*************************************************************

function systemTacgeRecyrrente {
    if [ -z "$1" ];
    then
        lsof;
        sleep 5;
        sousMenuSysteme;     
    else
        lsof | grep $1; 
        sleep 5;
        sousMenuSysteme;
    fi
    
}
#************************************************************* 
# Fonction : sousMenuSysteme
#  Objectif : permet d'afficher le sous menu du Systeme
# Notes  :  
#*************************************************************
function sousMenuSysteme {
    clear
    if [ -n "$1" ]; 
    then
         case $1 in 
            1) systemeMoniteur;;
            2) systemTacgeRecyrrente $2;;
            M) afficherMenuPrincipale;;
            *) echo "l'option entrer, en seconde paramètre n'existe pas"
               afficherMenuPrincipale;;
        esac  
    else
        echo "Menu Système";
        echo "1-Moniteur";
        echo "2-Tâches récurrentes";
        echo "M-Revenir";
        
        verifierChoixUsager
        case $option in 
            1) systemeMoniteur;;
            2) systemTacgeRecyrrente $specification;;
            M) afficherMenuPrincipale;;
        esac  
    
    fi
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
    echo "\$-Système"
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

