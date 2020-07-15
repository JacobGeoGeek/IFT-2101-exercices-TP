<?php
session_start();
error_reporting(-1);
ini_get('display_errors','On');
include 'logique/Init.php';

if(!isset($_SESSION['logIn']) || $_SESSION['logIn'] !== "logAsAdmin"){
    session_destroy();
    header("Location:connexion.php");
}

if(isset($_GET["deconnecter"])){
    session_destroy();
    header("Location:connexion.php");
}

elseif (isset($_GET["approuve"])){
    updateEtatCourriel("Approuvé",$_GET["approuve"]);
}
elseif (isset($_GET["refuser"])){
    updateEtatCourriel("Refusé",$_GET["refuser"]);
}

function updateEtatCourriel($status,$courriel){

   try {
        $db = new Init();
        $isUpdate = false;
        if($status === "Approuvé"){
            $isUpdate = $db->approuveCourriel($courriel);
        } elseif($status === "Refusé"){
            $isUpdate = $db->refuseCourriel($courriel);
        }else{
            echo "<h1>Problème lors de la mise a jour du status du courriel";
            $db->fermeConnection();
            exit();
        }

        $db->fermeConnection();

        if($isUpdate){
            header("Refresh:0; listeCourriel.php");
        } else{
            echo "<h1>Problè MAH status du courriel";
        }
    }
    catch (Exception $ex){
        printf($ex->getMessage());
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Liste de courriel</title>
</head>
<body>
<h1>Bienvenue <?php echo $_SESSION["prenomUser"]. " " . $_SESSION["nomUser"]?></h1>
<a href="?deconnecter">Déconnecté</a>

<h3> Liste des adresses à approuver</h3>
<table style="width:100%">
    <tr>
        <th>adresse courriel</th>
        <th>Approuver</th>
        <th>Refuser</th>
    </tr>
    <?php
    try {
        $db = new Init();
        $emails = $db->courrielEnAttente();
        $db->fermeConnection();

        foreach ($emails as $email) {
           echo "<tr><td>$email</td> <td><a href='?approuve=$email'>Approuver</a></td> <td><a href='?refuser=$email'>Refuser</a></td></tr>";
       }

    }
    catch (Exception $ex){
        printf($ex->getMessage());
    }
    ?>

</table>
<h3>Liste des courriels existants</h3>
<ul>
<?php
try {
    $db = new Init();
    $emails = $db->courrielApprouver();
    $db->fermeConnection();

    foreach ($emails as $email) {
        echo "<li>$email</li>";
    }
}
catch (Exception $ex) {
    printf($ex->getMessage());
}



?>
</ul>
</body>
</html>