<?php


class Erreurs
{

    public function afficherErreurTechnique($message) {
        echo "<script>console.error($message)</script>";
        echo "<script>alert('Erreur: veuillez voir la console (F12)')</script>";
    }

    public function doesNotExist(){
        echo "<script>alert('le nom d\'usager ou le mote de passe n\'existe pas')</script>";
    }
}

