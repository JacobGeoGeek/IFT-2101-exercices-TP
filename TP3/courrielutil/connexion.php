<?php
error_reporting(-1);
ini_get('display_errors','On');
include 'logique/Init.php';
include 'logique/Erreurs.php';
session_start();
$db;
$erreurs = new Erreurs();
try {
    $db = new Init();

    if (isset($_POST["Connecter"])){
        $db->connexion($_POST["userName"],$_POST["password"]);

        if (!$_SESSION["userExist"]){
            $erreurs->doesNotExist();
        }
        if (strcmp($_SESSION["typeUtil"],"Régulier")){
            header("Location:listeCourriel.php");
        }
        if (strcmp($_SESSION["typeUtil"],"Administrateur")) {
            header("Location:inscriptionCourriel.php");
        }
    }
}
catch (Exception $ex) {
    $erreurs->afficherErreurTechniq($ex->getMessage());
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
    <input type="password" name="password" id="userName" required placeholder="Mot de passe">
    <input type="submit" name="Connecter" value="Connecter">
</form>
</body>
</html>