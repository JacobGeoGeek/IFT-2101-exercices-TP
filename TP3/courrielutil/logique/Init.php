<?php

class Init
{
    private $sql;


    public function __construct()
    {
        $this->sql = new mysqli("localhost","root","ift-210x", "bd_courriels");
        $this->verifieConnection();
    }


    public function connexion($userName,$password){
        $query = "select * from utilisateur where loginUtilisateur = $userName and mdpUtil = {md5($password)}";

        $result = $this->sql->query($query);
        if ($result->num_rows == 0){
            $_SESSION["userExist"] = false;
            return;
        }

        while ($row = $result->fetch_assoc()){
            $_SESSION["typeUtil"] = $row["typeUtil"];
            $_SESSION["loginUtilisateur"] = $row["loginUtilisateur"];
            $_SESSION["prenomUtil"] = $row["prenomUtil"];
            $_SESSION["nomUtil"] = $row["nomUtil"];
        }
    }

    private function verifieConnection() {
        if($this->sql->connect_errno){
            throw new Exception("Connextion Failed %s \n", $this->sql->connect_error);
            exit();
        }
    }

}
?>