CREATE TABLE `bd_courriels`.`utilisateur` ( `loginUtilisateur` VARCHAR(10) NOT NULL , `mdpUtil` VARCHAR(20) NOT NULL , `prenomUtil` VARCHAR(40) NOT NULL , `nomUtil` VARCHAR(40) NOT NULL , `courrielUtil` VARCHAR(60) NOT NULL , `typeUtil` ENUM('Régulier','Administrateur') NOT NULL ) ENGINE = InnoDB;