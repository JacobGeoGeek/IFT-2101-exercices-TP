<?php
session_start();
error_reporting(-1);
ini_get('display_errors','On');
include 'logique/Init.php';

if(isset($_GET["deconnecter"])){
    session_destroy();
    header("Location:connexion.php");
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demande de courriel</title>
</head>
<body>
<h1>Bienvenue <?php echo $_SESSION["prenomUser"]. " " . $_SESSION["nomUser"]?></h1>
<a href="?deconnecter"></a>

<h3>Demande de courriel</h3>
<form action="inscriptionCourriel.php" method="post">
    <input type="text" name="email" required placeholder="courriel">
    <input type="text" name="userName" value="<?php echo $_SESSION["userName"] ?>" readonly >
    <input type="submit" name="soumettre" value="Envoyer la demande">
</form>
<h3>Liste des demande envouyés</h3>
<ul>
    <?php
    try {
        $db = new Init();
        $lsit = $db->listeDemande($_SESSION["userName"]);
    }catch (Exception $ex){
        echo $ex->getMessage();
    }
    ?>
</ul>

</body>
</html>