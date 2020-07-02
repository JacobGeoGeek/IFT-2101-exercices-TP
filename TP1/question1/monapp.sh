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
# Fonction : verifierChoixUsagerTransfert
#  Objectif : verifie l'option que l'usager a choisie dans un sous-menu
# Notes  :  cette fonction s'applique seulement pour le sous-menu  fichier transfert
#*************************************************************
function verifierChoixUsagerTransfert {
        local choixEstValide=false
        while !($choixEstValide)
        do
            echo -e "Veuillez choisir l'une des 5 options: \c"
            read option
            if [[ $option -eq 1 || $option -eq 2 || $option -eq 3  || $option -eq 4 || $option = M ]];
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
    else
       local pathPartition=/dev/$1
        if [ -e $pathPartition ];
        then
            fdisk -l $pathPartition;
        else 
            echo "La partion n'existe pas.";
        fi
    fi
    sleep 5;
    sousMenuDisque;
}

#************************************************************* 
# Fonction : disqueRecherche
#  Objectif : permet recherche un fichier contenant un mot mentionné par l'usager
# Notes  :  
#*************************************************************
function disqueRecherche {
    if [ -z "$1" ]; then
        echo "pour la recherche, vous devez entrer un mot entrer un mot";
    else
        find ~/ -name *$1*;
    fi
    sleep 5;
    sousMenuDisque;
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
# Fonction : systemeTacheRecurrente
#  Objectif : Affiche la liste des fichiers ouverts.
# Notes  :  si peux egalenment specifier un nom service qu'on souhaite d'afficher les fichier 
#            ouvert de celui-ci 
#*************************************************************

function systemeTacheRecurrente {
    if [ -z "$1" ];
    then
        lsof;  
    else
        lsof | grep $1; 
    fi
    sleep 5;
    sousMenuSysteme;   
    
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
            2) systemeTacheRecurrente $2;;
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
            2) systemeTacheRecurrente $specification;;
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
    netstat;
    sleep 5;
    sousMenuReseau;  
}

#************************************************************* 
# Fonction : pageDistance
#  Objectif : Affiche une question qui demande une adresse IP ou un domaine.
#             Une fois que l'utilisateur l'a fourni, le script va y quérir 
#               une page web et affiche son contenu HTML. 
# Notes  :  
#*************************************************************
function pageDistance {
    echo -e "Veuillez entrer une adresse IP ou un nom de domaine: \c";
    read url;
    echo -e "GET /" | nc $url 80;
    sleep 5;
    sousMenuReseau; 

}

#************************************************************* 
# Fonction : connectionReseau
#  Objectif :  Affiche les 10 dernières connexions réseau
# Notes  :  Le tout se fait à l'aide d'une boucle et 
#           de netstat et se rafraichit à chaque 5 secondes.
#*************************************************************
function connectionReseau {
    local usagerVeuxQuitter=false;
    while true;
    do
    clear;
    
    netstat -an | tail -10;
    echo "pour quitter, veuillez entrer le 0"
    read sortie    
    sleep 5;
    #TO CHECK
    if [ $sortie -eq 0]; 
    then
        $usagerVeuxQuitter=true;
    fi     
    done
    sousMenuReseau;
}

#************************************************************* 
# Fonction : reponseReseau
#  Objectif :Affiche une question qui demande un nom de domaine 
#            ou une adresse. Demande ensuite le nombre de vérifications à faire. 
#            Puis fait un ping sur cette adresse pour le nombre de vérifications donné. 
# Notes  : 
#*************************************************************
function reponseReseau {
    echo -e "Veuillez entrer une adresse IP ou un nom de domaine: \c";
    read url;
    echo -e "Veuillez entrer le nombre de verification a faire: \c";
    read nbVerication;
    ping -c$nbVerication $url;
    sleep 5;
    sousMenuReseau;
}

#************************************************************* 
# Fonction : cleSPF
#  Objectif  Affiche une question qui demande un nom de domaine et 
#           une fois que l'utilisateur l'a fourni, le script affiche 
#           la clé spf des RR de type txt pour ce domaine.  
# Notes  : 
#*************************************************************
function cleSPF {
    echo -e "Veuillez entrer un nom de domaine: \c";
    read domaine;
    dig -t TXT $domaine;
    sleep 5;
    sousMenuReseau;
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
        echo "2-Page distante"
        echo "3-Connexions réseau";
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

#************************************************************* 
# Fonction : transfertFile
#  Objectif : permet d'envoyer un fichier
# Notes  :  
#*************************************************************
function transfertFile {
   echo -e "Veuillez entrer l'addresse IP de la machine a connecter: \c";
   read adresseIp;
   echo -e "Veuillez entrer le nom usager: \c";
   read user;
   echo -e "Veuillez entrer le path du fhicher: \c";
   read pathFile
   echo -e "Veuillez entrer le path de destination: \c";
   read pathDestination

   scp ~/$pathFile $user@adresseIp:$pathDestination;

   sousMenuTransfert

}

#************************************************************* 
# Fonction : receviceFile
#  Objectif : permet de recevoir un fichier
# Notes  :  
#*************************************************************
function receviceFile {
   echo -e "Veuillez entrer l'addresse IP de la machine a connecter: \c";
   read adresseIp;
   echo -e "Veuillez entrer le nom usager: \c";
   read user;
   echo -e "Veuillez entrer le path du fhicher: \c";
   read pathFile
   echo -e "Veuillez entrer le path de destination: \c";
   read pathDestination

   scp $user@adresseIp:$pathDestination ~/$pathFile;

   sousMenuTransfert

}


#************************************************************* 
# Fonction : sousMenuTransfert
#  Objectif : permet d'afficher le sous menu Transfert de fichier
# Notes  :  
#*************************************************************
function sousMenuTransfert {
    clear
    if [ -n "$1" ]; 
    then
         case $1 in 
            1) receviceFile;;
            2) transfertFile;;
            M) afficherMenuPrincipale;;
            *) echo "l'option entrer, en seconde paramètre n'existe pas"
               afficherMenuPrincipale;;
        esac  
    else
        echo "Menu Transfert fichier";
        echo "1-Revevoir un fichier (remote to local)";
        echo "2-Envoyer un fichier (local to remote)";
        echo "M-Revenir";
        
        verifierChoixUsager;
        case $option in 
            1) receviceFile;;
            2) transfertFile;;
            M) afficherMenuPrincipale;;
        esac  

    fi
    
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
    echo ":-Transfert Fichiers"
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
    ":") sousMenuTransfert $programmeExecute;;
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

