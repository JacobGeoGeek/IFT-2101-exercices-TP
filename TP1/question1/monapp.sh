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
            echo -e "Veuillez choisir l'une des 3 option: \c"
            read option specification
            if [[ $option -eq 1 || $option -eq 2 || $option = M ]];
            then
                choixEstValide=true;
            else echo "votre choix ne fais pas partie de la liste. Veuillez recommencez";
           fi  
        done 
}
#************************************************************* 
# Fonction : verifierChoixUsagerReseau
#  Objectif : verifie l'option que l'usager a choisie dans un sous-menu
# Notes  :  cette fonction s'applique seulement pour le sous-menu reseau
#*************************************************************
function verifierChoixUsagerReseau {
        local choixEstValide=false
        while !($choixEstValide)
        do
            echo -e "Veuillez choisir l'une des 5 options: \c"
            read option
            if [[ $option -eq 1 || $option -eq 2 || $option -eq 3  || $option -eq 4 || $option -eq 5  || $option = M ]];
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

#************************************************************* 
# Fonction : socketEcoute
#  Objectif : lister tous les ports ouverts en écoute sur le serveur
# Notes  :  
#*************************************************************
function socketEcoute {
    
}

#************************************************************* 
# Fonction : pageDistance
#  Objectif : Affiche une question qui demande une adresse IP ou un domaine.
#             Une fois que l'utilisateur l'a fourni, le script va y quérir 
#               une page web et affiche son contenu HTML. 
# Notes  :  
#*************************************************************
function pageDistance {
    echo "page distance"
}

#************************************************************* 
# Fonction : connectionReseau
#  Objectif :  Affiche les 10 dernières connexions réseau
# Notes  :  Le tout se fait à l'aide d'une boucle et 
#           de netstat et se rafraichit à chaque 5 secondes.
#*************************************************************
function connectionReseau {
    echo "Connection Reseau"
}

#************************************************************* 
# Fonction : reponseReseau
#  Objectif :Affiche une question qui demande un nom de domaine 
#            ou une adresse. Demande ensuite le nombre de vérifications à faire. 
#            Puis fait un ping sur cette adresse pour le nombre de vérifications donné. 
# Notes  : 
#*************************************************************
function reponseReseau {
    echo "Reponse Reseau"
}

#************************************************************* 
# Fonction : cleSPF
#  Objectif  Affiche une question qui demande un nom de domaine et 
#           une fois que l'utilisateur l'a fourni, le script affiche 
#           la clé spf des RR de type txt pour ce domaine.  
# Notes  : 
#*************************************************************
function cleSPF {
    echo "Cle SPF"
}


#************************************************************* 
# Fonction : sousMenuReseau
#  Objectif : permet d'afficher le sous menu de reseau
# Notes  :  
#*************************************************************
function sousMenuReseau {
    clear
    if [ -n "$1" ]; 
    then
         case $1 in 
            1) socketEcoute;;
            2) pageDistance;;
            3) connectionReseau;;
            4) reponseReseau;;
            5) cleSPF;;
            M) afficherMenuPrincipale;;
            *) echo "l'option entrer, en seconde paramètre n'existe pas"
               afficherMenuPrincipale;;
        esac  
    else
        echo "Menu Système";
        echo "1-Socket en écoute (LISTENING) localement ";
        echo "2-Connexions réseau";
        echo "4-Réponse réseau";
        echo "5-Clé SPF";
        echo "M-Revenir";
        
        verifierChoixUsagerReseau;
        case $option in 
            1) socketEcoute;;
            2) pageDistance;;
            3) connectionReseau;;
            4) reponseReseau;;
            5) cleSPF;;
            M) afficherMenuPrincipale;;
        esac  

    fi
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

