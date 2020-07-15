<?php


class demandeCourrielUsager
{
    public $adresseCourriel;
    public $status;

    public function __construct($adresseCourriel, $status)
    {
        $this->adresseCourriel = $adresseCourriel;
        $this->status = $status;
    }

}