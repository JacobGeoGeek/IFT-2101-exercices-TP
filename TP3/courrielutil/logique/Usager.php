<?php


class Usager
{
    public $typeUtil;
    public $loginUtilisateur;
    public $prenomUtil;
    public $nomUtil;

    public function __construct($typeUtil, $loginUtilisateur, $prenomUtil, $nomUtil)
    {
        $this->typeUtil = $typeUtil;
        $this->loginUtilisateur = $loginUtilisateur;
        $this->prenomUtil = $prenomUtil;
        $this->nomUtil = $nomUtil;
    }

    public function __toString()
    {
        // TODO: Implement __toString() method.
        if (isset($this->typeUtil)){
            return $this->typeUtil . "," . $this->loginUtilisateur . "," . $this->prenomUtil . "," . $this->nomUtil;
        }
        return "is empty";
    }


}