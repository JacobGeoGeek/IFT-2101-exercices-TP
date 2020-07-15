<?php
session_start();
error_reporting(-1);
ini_get('display_errors','On');
include 'logique/Init.php';

if(!isset($_SESSION['logIn']) || $_SESSION['logIn'] !== "logAsReg"){
    session_destroy();
    header("Location:connexion.php");
}
if(isset($_GET["deconnecter"])){
    session_destroy();
    header("Location:connexion.php");
}

elseif (isset($_POST["soumettre"])){
    $fullEmail = $_POST['email'] . $_POST['domain'];
    try {
        $db = new Init();
        $StatusId = $db->ajoutStatusCourriel();

        if($StatusId == -1){
            echo "<h6> impossible de traiter votre demande </h6>";
            $db->fermeConnection();
            exit();
        }

        $isInserted = $db->ajoutCourriel($_POST['userName'],$fullEmail,$StatusId);

        if(!$isInserted){
            echo  "<h6> impossible de traiter votre demande. Il faut que le courriel soit unique dans votre liste </h6>";
            $db->fermeConnection();
            exit();
        }
        $db->fermeConnection();
        header("Refresh:0; inscriptionCourriel.php");

    }catch (Exception $ex){
        echo $ex->getMessage();
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demande de courriel</title>
</head>
<body>
<h1>Bienvenue <?php echo $_SESSION["prenomUser"]. " " . $_SESSION["nomUser"]. " " ?></h1>
<a href="?deconnecter">Déconnecté</a>

<h3>Demande de courriel</h3>
<form action="inscriptionCourriel.php" method="post">
    <input type="text" name="email" required placeholder="courriel">
    <select name="domain" id="domaine">
        <option value="@fauxgoogle.com">@fauxgoogle.com</option>
        <option value="@mon1erclient.com">@mon1erclient.com</option>
    </select>
    <br>
    <input type="text" name="userName" value="<?php echo $_SESSION["loginUtilisateur"] ?>" readonly ><br>
    <input type="submit" name="soumettre" value="Envoyer la demande">
</form>
<h3>Liste des demandes envouyés</h3>
<ul>
    <?php
    try {
        $db = new Init();
        $lsit = $db->listeDemande($_SESSION["loginUtilisateur"]);
        $db->fermeConnection();
        foreach($lsit as $item){
           echo "<li> $item->adresseCourriel : $item->status </li>";
        }

    }catch (Exception $ex){
        echo $ex->getMessage();
    }
    ?>
</ul>

</body>
</html>