<?php
include "Usager.php";
include "demandeCourrielUsager.php";
class Init
{
    private $sql;
    private $attente = "En attente";
    private $approuve = "Approuvé";
    private $refuse = "Refusé";


    public function __construct()
    {
        $this->sql = new mysqli("localhost","root","ift-210x", "bd_courriels");
        $this->sql->set_charset("utf8");
        $this->verifieConnection();
    }


    public function connexion($userName,$password){
        $passwordHash = md5($password);

        $query = "select * from utilisateur where loginUtilisateur = '$userName' and mdpUtil = '$passwordHash'";


        $result = $this->sql->query($query);
        if ($result->num_rows == 0){
            return false;
        }

        $row = $result->fetch_assoc();
        $user = new Usager($row["typeUtil"], $row["loginUtilisateur"],$row["prenomUtil"], $row["nomUtil"]);
        return $user;
    }

    public function courrielEnAttente() {
        $query = "SELECT adresseCourriel FROM courriel INNER JOIN statutApprobation on courriel.noStatutApprobationCourriel = statutApprobation.noStatutApprobationCourriel WHERE statutApprobation.descStatut = '$this->attente'";

        $result = $this->sql->query($query);
        if($result->num_rows == 0){
            return array();
        }

        $emails = array();
        while ($row = $result->fetch_assoc()){
            array_push($emails, $row["adresseCourriel"]);
        }
        $result->close();

        return $emails;
    }

    public function courrielApprouver(){
        $query = "SELECT adresseCourriel FROM courriel INNER JOIN statutApprobation on courriel.noStatutApprobationCourriel = statutApprobation.noStatutApprobationCourriel WHERE statutApprobation.descStatut = 'Approuvé'";
        $result = $this->sql->query($query);

        if($result->num_rows == 0){
            return array();
        }

        $emails = array();
        while ($row = $result->fetch_assoc()){
            array_push($emails, $row["adresseCourriel"]);
        }
        $result->close();

        return $emails;

    }


    public function approuveCourriel($email){
        $query = "UPDATE statutApprobation SET descStatut = '$this->approuve' WHERE noStatutApprobationCourriel = (SELECT courriel.noStatutApprobationCourriel FROM courriel WHERE courriel.adresseCourriel = '$email')";
        $isUpdate = $this->sql->query($query);
        return $isUpdate;
    }

    public function refuseCourriel($email){
        $query = "UPDATE statutApprobation SET descStatut = '$this->refuse' WHERE noStatutApprobationCourriel = (SELECT courriel.noStatutApprobationCourriel FROM courriel WHERE courriel.adresseCourriel = '$email')";
        $isUpdate = $this->sql->query($query);
        return $isUpdate;
    }

    public function fermeConnection(){
        $this->sql->close();
    }

    private function verifieConnection() {
        if($this->sql->connect_errno){
            throw new Exception("Connextion Failed %s \n", $this->sql->connect_error);
            exit();
        }
    }

    public function listeDemande($userName)
    {
        $query = "SELECT courriel.adresseCourriel, statutApprobation.descStatut FROM courriel INNER JOIN statutApprobation on courriel.noStatutApprobationCourriel = statutApprobation.noStatutApprobationCourriel WHERE courriel.loginUtilisateur = '$userName'";
        $result = $this->sql->query($query);

        if($result->num_rows == 0){
            $result->close();
            return array();
        }
        $liste = array();

        while ($row = $result->fetch_assoc()){
            array_push($liste,new demandeCourrielUsager($row['adresseCourriel'],$row['descStatut']));
        }
        $result->close();
        return $liste;
    }

    public function ajoutStatusCourriel(){
        $query = "INSERT INTO statutApprobation (descStatut) VALUES ('$this->attente')";
        $result = $this->sql->query($query);

        if($result === true){
            return $this->sql->insert_id;
        }

        return -1;
    }

    public function ajoutCourriel($userName, $fullEmail, $StatusId)
    {
        $query = "SELECT * FROM courriel WHERE adresseCourriel = '$fullEmail'";
        $nbRow = $this->sql->query($query)->num_rows;

        if ($nbRow == 1){
            return false;
        }

        $query = "INSERT INTO courriel (loginUtilisateur,adresseCourriel,noStatutApprobationCourriel) VALUES ('$userName', '$fullEmail', '$StatusId')";
        $result = $this->sql->query($query);

        if($result === true){
            return true;
        }
        return false;
    }

}
?>