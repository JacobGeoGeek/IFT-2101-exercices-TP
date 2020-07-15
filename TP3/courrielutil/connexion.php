<?php
error_reporting(-1);
ini_get('display_errors','On');
include 'logique/Init.php';
session_start();
try {
    $db = new Init();
    if (isset($_POST["Connecter"])){
        $result = $db->connexion($_POST["userName"],$_POST["password"]);
        $db->fermeConnection();

        if ($result === false){
           echo "impossible de ce connecter. vérifier que le nom d'usager ou le mot de passe sont correct";
        }
        else if ($result->typeUtil === "Régulier"){
            $_SESSION["nomUser"] = $result->nomUtil;
            $_SESSION["prenomUser"] = $result->prenomUtil;
            $_SESSION['loginUtilisateur'] = $result->loginUtilisateur;
            $_SESSION['logIn'] = "logAsReg";
            header("Location:inscriptionCourriel.php");
        }
        else if ($result->typeUtil ==="Administrateur") {
            $_SESSION["nomUser"] = $result->nomUtil;
            $_SESSION["prenomUser"] = $result->prenomUtil;
            $_SESSION['loginUtilisateur'] = $result->loginUtilisateur;
            $_SESSION['logIn'] = "logAsAdmin";
            header("Location:listeCourriel.php");
        }
    }
}
catch (Exception $ex) {
   printf("connection Failed: %s\n",$ex->getMessage());
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
</head>
<body>
<h1>connexion</h1>
<form action="connexion.php" method="post">
    <input type="text" name="userName" id="userName" required placeholder="Nom d'usager">
    <input type="password" name="password" id="password" required placeholder="Mot de passe">
    <input type="submit" name="Connecter" value="Connecter">
</form>
</body>
</html>