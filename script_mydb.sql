-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Utenti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Utenti` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Utenti` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` CHAR(32) NOT NULL,
  `Ruolo` ENUM('Conducente', 'Gestore', 'Viaggiatore') NOT NULL,
  PRIMARY KEY (`Username`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Conducente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Conducente` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Conducente` (
  `CF` VARCHAR(20) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `NumeroPatente` VARCHAR(12) NOT NULL,
  `ScadenzaPatente` DATE NOT NULL,
  `LuogoNascita` VARCHAR(45) NOT NULL,
  `DataNascita` DATE NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CF`),
  UNIQUE INDEX `NumeroPatente_UNIQUE` (`NumeroPatente` ASC) VISIBLE,
  INDEX `Username_idx` (`Username` ASC) VISIBLE,
  CONSTRAINT `Username`
    FOREIGN KEY (`Username`)
    REFERENCES `mydb`.`Utenti` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Veicolo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Veicolo` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Veicolo` (
  `Matricola` SMALLINT(4) NOT NULL,
  `DataAcquisto` DATE NOT NULL,
  PRIMARY KEY (`Matricola`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Fermata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Fermata` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Fermata` (
  `Codice` INT(5) NOT NULL,
  `Longitudine` DECIMAL NOT NULL,
  `Latitudine` DECIMAL NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE INDEX `Longitudine_UNIQUE` (`Longitudine` ASC, `Latitudine` ASC) INVISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Tratta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tratta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Tratta` (
  `ID` TINYINT(3) NOT NULL,
  `Numero` SMALLINT(3) NOT NULL,
  `Capolinea_Da` INT(5) NOT NULL,
  `Capolinea_A` INT(5) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `CapolineaPartenza_idx` (`Capolinea_Da` ASC) VISIBLE,
  INDEX `CapolineaArrivo_idx` (`Capolinea_A` ASC) VISIBLE,
  CONSTRAINT `CapolineaPartenza`
    FOREIGN KEY (`Capolinea_Da`)
    REFERENCES `mydb`.`Fermata` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CapolineaArrivo`
    FOREIGN KEY (`Capolinea_A`)
    REFERENCES `mydb`.`Fermata` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Biglietto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Biglietto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Biglietto` (
  `Numero` INT NOT NULL,
  `Valido` TINYINT NOT NULL,
  `Tipo` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`Numero`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`VeicoloinCorsa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`VeicoloinCorsa` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`VeicoloinCorsa` (
  `Giorno` VARCHAR(45) NOT NULL,
  `Ora` TIME NOT NULL,
  `Veicolo` SMALLINT(4) NOT NULL,
  `Tratta` TINYINT(2) NOT NULL,
  `Partito` TINYINT NOT NULL,
  `UltimaFermata` TINYINT(2) NOT NULL,
  `Conducente` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Giorno`, `Ora`, `Veicolo`),
  INDEX `Veicolo_idx` (`Veicolo` ASC) VISIBLE,
  INDEX `Tratta_idx` (`Tratta` ASC) VISIBLE,
  INDEX `Conducente_idx` (`Conducente` ASC) INVISIBLE,
  UNIQUE INDEX `Ora_UNIQUE` (`Veicolo` ASC, `Giorno` ASC, `Ora` ASC) VISIBLE,
  INDEX `Orario-veicolo` (`Conducente` ASC, `Giorno` ASC, `Ora` ASC) VISIBLE,
  CONSTRAINT `Veicolo`
    FOREIGN KEY (`Veicolo`)
    REFERENCES `mydb`.`Veicolo` (`Matricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tratta`
    FOREIGN KEY (`Tratta`)
    REFERENCES `mydb`.`Tratta` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Conducente`
    FOREIGN KEY (`Conducente`)
    REFERENCES `mydb`.`Conducente` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Effettua`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Effettua` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Effettua` (
  `Indice` TINYINT(2) NOT NULL,
  `Fermata_Codice` INT(5) NOT NULL,
  `Tratta_ID` TINYINT(2) NOT NULL,
  PRIMARY KEY (`Fermata_Codice`, `Tratta_ID`),
  INDEX `Fermata_idx` (`Fermata_Codice` ASC) VISIBLE,
  INDEX `Tratta_ID_idx` (`Tratta_ID` ASC) VISIBLE,
  CONSTRAINT `Fermata`
    FOREIGN KEY (`Fermata_Codice`)
    REFERENCES `mydb`.`Fermata` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tratta_ID`
    FOREIGN KEY (`Tratta_ID`)
    REFERENCES `mydb`.`Tratta` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Abbonato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Abbonato` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Abbonato` (
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `DataScadenza` VARCHAR(45) NOT NULL,
  `UltimoUtilizzo` DATE NULL,
  `Biglietto_Numero` INT NOT NULL,
  `CodiceFiscale` VARCHAR(20) NOT NULL,
  INDEX `Abbonamento_idx` (`Biglietto_Numero` ASC) INVISIBLE,
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC, `Cognome` ASC, `Biglietto_Numero` ASC) VISIBLE,
  PRIMARY KEY (`CodiceFiscale`),
  CONSTRAINT `Abbonamento`
    FOREIGN KEY (`Biglietto_Numero`)
    REFERENCES `mydb`.`Biglietto` (`Numero`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- procedure login
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`login`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `login` (in var_username varchar(45), in var_pass varchar(45), out var_role INT, out var_CF varchar(20))
BEGIN

	declare var_user_role ENUM('Conducente','Gestore','Viaggiatore');
    
    select Ruolo 
    from Utenti
	where Username = var_username and Password = md5(var_pass)
    into var_user_role;
    
    if var_user_role = 'Conducente' then
		set var_role = 1;
		select CF 
        from Conducente
        where Username = var_username
        into var_CF;
	
    elseif var_user_role = 'Gestore' then
		set var_role = 2;
        
	elseif var_user_role = 'Viaggiatore' then
		set var_role = 3;
	
    else
		set var_role = 0;
	end if;
		
    
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure lista_veicoli
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`lista_veicoli`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `lista_veicoli` (in var_fermata int(5))
BEGIN
	
	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level repeatable read;
	set transaction read only;
	start transaction;
	
    select Tratta, Veicolo, (Indice-UltimaFermata) as Distanza
    from VeicoloinCorsa as V join Effettua as E on Tratta = Tratta_ID
    where E.Fermata_Codice = var_fermata and V.Giorno = dayname(now()) and Partito = 1
		and V.UltimaFermata < E.Indice and E.Indice != (select count(*) 
														from Tratta as T join Effettua as Ef on T.ID = Ef.Tratta_ID 
                                                        where T.ID = V.Tratta);


commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure distanza_veicolo
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`distanza_veicolo`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `distanza_veicolo` (in var_fermata int(5), in var_idTratta tinyint(3))
BEGIN
	
    declare var_index int;
    
	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read committed;
	set transaction read only;
	start transaction;
	
	select count(*)
    into var_index
    from Effettua
    where Tratta_ID = var_idTratta;
    
	select Veicolo, (Indice - UltimaFermata) as Distanza
    from VeicoloinCorsa join Effettua on Tratta = Tratta_ID
    where Fermata_Codice = var_fermata and Giorno = dayname(now()) 
    and Tratta = var_idTratta and Indice != (var_index);

commit;


END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure convalida_biglietto
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`convalida_biglietto`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `convalida_biglietto` (in var_numero int)
BEGIN

	declare var_tipo varchar(12);
    declare var_count INT;

    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

	set transaction isolation level serializable;
    start transaction;
    
    select Tipo, count(*)
    into var_tipo, var_count
    FROM Biglietto
    WHERE Numero = var_numero AND Valido = 1
    group by Tipo;

    if var_tipo = 'Standard' then
        update Biglietto
        set Valido = 0
        where Numero = var_numero;
    
    elseif var_tipo = 'Abbonamento' then
        update Abbonato
        join Biglietto on Numero = Biglietto_Numero
        set UltimoUtilizzo = current_date()
        where Biglietto_Numero = var_numero;
	else
        signal sqlstate '45000'
        set message_text = 'Biglietto non valido o inesistente.';
        
    end if;

    COMMIT;

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure prossima_partenza
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`prossima_partenza`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `prossima_partenza` (in var_conducente varchar(16))
BEGIN

	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;
	
    set transaction isolation level read uncommitted;
	set transaction read only;
	start transaction;
 
	select Giorno, Ora
	from VeicoloinCorsa
	where Conducente = var_conducente and Giorno = dayname(now()) and Ora >= current_time();


commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure aggiorna_patente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiorna_patente`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `aggiorna_patente` (in var_conducente varchar(20), in var_numero varchar(12), in var_scadenza date)
BEGIN

	declare exit handler for sqlexception

    begin
	rollback;
	resignal;
     end;

	set transaction isolation level read uncommitted;
	start transaction;
    
	update Conducente
	set NumeroPatente = var_numero, ScadenzaPatente = var_scadenza
	where CF = var_conducente;

	commit;


END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure elenco_orari
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`elenco_orari`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `elenco_orari` (in var_conducente varchar(20))
BEGIN
    
	declare exit handler for sqlexception
    begin
		rollback;
		resignal;
	end;
    
    set transaction isolation level read committed;
    set transaction read only;
    start transaction;

	select Veicolo, Giorno, Ora
	from VeicoloinCorsa
	where Conducente = var_conducente and Partito = 0
	order by Giorno, Ora;
    
commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure nuova_partenza
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`nuova_partenza`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `nuova_partenza` (in var_veicolo smallint(4), in var_tratta tinyint(2), in var_giorno varchar(45), in var_orario time, in var_CF varchar(20))
BEGIN
	
    declare var_count int;
    
	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level serializable;
	start transaction;
	
    select count(*)
    into var_count
    from VeicoloinCorsa as V
    where V.Veicolo = var_veicolo and V.Giorno = var_giorno and V.Partito = 1 
		and V.Ora = (var_orario - interval 30 minute)
        and V.UltimaFermata != (select count(*)
								from Effettua
								where V.Tratta = Tratta_ID);
    
    if var_count > 0 then
		signal sqlstate '45000'
        set message_text = 'Il veicolo è in corsa su una tratta. Non è possibile inserire orario';
	else
		DELETE FROM VeicoloinCorsa
		WHERE Veicolo = var_veicolo and Giorno = var_giorno and Ora between var_orario - interval 30 minute and var_orario + interval 30 minute;
        
        insert into VeicoloinCorsa(Giorno, Ora, Veicolo, Tratta, Partito, UltimaFermata, Conducente) values (var_giorno, var_orario, var_veicolo, var_tratta, 0, 0, var_CF); 
	end if;
    

commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure assegna_conducente_corsa
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`assegna_conducente_corsa`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `assegna_conducente_corsa` (in var_CF varchar(20), in var_veicolo smallint(4), in var_giorno varchar(45), in var_ora time)
BEGIN

	declare exit handler for sqlexception
	
    begin
		rollback;
		resignal;
	end;

	set transaction isolation level repeatable read;
	start transaction;
    
	update VeicoloinCorsa
	set  Conducente = var_CF
	where Veicolo = var_veicolo and Giorno = var_giorno and Ora = var_ora;

commit;


END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure aggiungi_fermata_tratta
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiungi_fermata_tratta`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `aggiungi_fermata_tratta` (in var_fermata int(5), in var_indice int, in var_tratta tinyint(2))
BEGIN

	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level repeatable read;
	start transaction;
	
	update Effettua
	set indice = indice +1
	where Tratta_ID = var_tratta and indice >= var_indice;
 
	insert into Effettua(Indice, Fermata_Codice, Tratta_ID) values (var_indice, var_fermata, var_tratta); 
  


commit;

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure aggiungi_tratta
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiungi_tratta`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `aggiungi_tratta` (in var_ID tinyint(2), in var_num smallint(3), in var_partenza int(5), in var_destinazione int(5))
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read uncommitted;
	start transaction;
    
	insert into Tratta(ID, Numero, Capolinea_Da, Capolinea_A) values (var_ID, var_num, var_partenza, var_destinazione); 

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure registra_conducente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`registra_conducente`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `registra_conducente` (in var_CF varchar(20), in var_nome varchar(45), in var_cognome varchar(45), in var_patente varchar(10), in var_scadenza DATE, in var_luogo varchar(45), in var_data DATE, in var_username varchar(45), in var_pass char(32))
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read uncommitted;
	start transaction;
    
    if (var_username not in (select Username from Utenti)) then
		insert into Utenti(Username, Password, Ruolo) values (var_username, md5(var_pass), 'Conducente');
		insert into Conducente(CF, Nome, Cognome, NumeroPatente, ScadenzaPatente, LuogoNascita, DataNascita, Username) values (var_CF, var_nome, var_cognome, var_patente, var_scadenza, var_luogo, var_data, var_username);
    else
		signal sqlstate '45000'
        set message_text = 'Username già esistente.';
end if;
commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure elenco_scadenze_patente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`elenco_scadenze_patente`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `elenco_scadenze_patente` ()
BEGIN

	declare exit handler for sqlexception
    begin
		rollback;
		resignal;
	end;
    
    set transaction isolation level read uncommitted;
    set transaction read only;
    start transaction;
    
    select CF, NumeroPatente, ScadenzaPatente
    from Conducente;
    
commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure lista_tratte
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`lista_tratte`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `lista_tratte` (in var_fermata int(5))
BEGIN
	
    declare exit handler for sqlexception

	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read committed;
	set transaction read only;
	start transaction;
	
	select Numero, Capolinea_Da, Capolinea_A, Ora
	from VeicoloinCorsa join Effettua on Tratta = Tratta_ID join Tratta on Tratta_ID = ID
	where Fermata_Codice = var_fermata and Giorno = dayname(now()) and Partito = 0 and Ora >= current_time()
    order by Numero;

commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure lista_tratte_totali
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`lista_tratte_totali`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `lista_tratte_totali` ()
BEGIN
	
    declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read uncommitted;
	set transaction read only;
	start transaction;
    
    select *
    from Tratta;
commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure attiva_gps
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`attiva_gps`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `attiva_gps` ()
BEGIN

	declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read committed;
	set transaction read only;
	start transaction;
    
    select Giorno, Ora, Veicolo, Tratta, Conducente
    from VeicoloinCorsa
    where Giorno = dayname(now());

commit;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure preleva_capolinea
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`preleva_capolinea`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `preleva_capolinea` (in var_idtratta tinyint(3))
BEGIN

declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level read uncommitted;
	set transaction read only;
	start transaction;
    
    select Codice, Longitudine, Latitudine
    from Tratta join Fermata on Capolinea_Da = Codice
    where ID = var_idtratta;
    
commit;

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure preleva_fermata
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`preleva_fermata`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `preleva_fermata` (in var_idtratta tinyint(3))
BEGIN
declare exit handler for sqlexception
	begin
		rollback;
		resignal;
	end;

	set transaction isolation level serializable;
	set transaction read only;
	start transaction;
    
    select Codice, Longitudine, Latitudine
    from Effettua join Fermata on Fermata_Codice = Codice
    where Tratta_ID = var_idtratta
    order by Indice;

commit;
    
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure aggiorna_indice
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiorna_indice`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `aggiorna_indice` (in var_giorno varchar(45), in var_ora time, in var_veicolo int, in var_index int)
BEGIN
declare exit handler for sqlexception
    begin
		rollback;
		resignal;
	end;
    
    set transaction isolation level read uncommitted;
    start transaction;
	
    update VeicoloinCorsa
    set UltimeFermata = var_index
    where Giorno = var_giorno and Ora = var_ora and Veicolo = var_veicolo and Partito = 1;
    
commit;
    
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure aggiorna_partito
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiorna_partito`;
SHOW WARNINGS;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `aggiorna_partito` (in var_giorno varchar(45), in var_ora time, in var_veicolo int)
BEGIN
declare exit handler for sqlexception
    begin
		rollback;
		resignal;
	end;
    
    set transaction isolation level read uncommitted;
    start transaction;
    
    update VeicoloinCorsa
    set Partito = 1
    where Giorno = var_giorno and Ora = var_ora and Veicolo = var_veicolo;
 
 commit;
 
END$$

DELIMITER ;
SHOW WARNINGS;
USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Conducente_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Conducente_BEFORE_INSERT` BEFORE INSERT ON `Conducente` FOR EACH ROW
BEGIN

IF NOT NEW.CF REGEXP '^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$' THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Codice Fiscale non valido.';
	END IF;
    
END$$

SHOW WARNINGS$$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Conducente_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Conducente_BEFORE_UPDATE` BEFORE UPDATE ON `Conducente` FOR EACH ROW
BEGIN

	IF NOT NEW.NumeroPatente REGEXP '^[A-Za-z0-9]{5,10}$' THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Formato del numero di patente non valido.';
	END IF;
    

END$$

SHOW WARNINGS$$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Fermata_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Fermata_BEFORE_INSERT` BEFORE INSERT ON `Fermata` FOR EACH ROW
BEGIN

	IF NOT (char_length(new.codice) = 5 and new.codice REGEXP '^[0-9]+$') THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Formato codice fermata non valido.';
	END IF;
    

END$$

SHOW WARNINGS$$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Tratta_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Tratta_BEFORE_INSERT` BEFORE INSERT ON `Tratta` FOR EACH ROW
BEGIN
	
    declare numero_tratte int;
    declare capolinea_da1 int(5);
    declare capolinea_a1 int(5);
    
	select count(*)
    into numero_tratte
    from Tratta
    where Numero = New.Numero;
    
    
    if numero_tratte >= 2 then
		signal sqlstate '45000'
        set message_text = 'Non è possibile inserire la tratta. Numero tratta già utilizzato.';
	END IF;
END$$

SHOW WARNINGS$$

DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS conducente;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW WARNINGS;
CREATE USER 'conducente' IDENTIFIED BY 'conducente';

GRANT EXECUTE ON procedure `mydb`.`aggiorna_patente` TO 'conducente';
GRANT EXECUTE ON procedure `mydb`.`prossima_partenza` TO 'conducente';
GRANT EXECUTE ON procedure `mydb`.`elenco_orari` TO 'conducente';
SHOW WARNINGS;
SET SQL_MODE = '';
DROP USER IF EXISTS gestore;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW WARNINGS;
CREATE USER 'gestore' IDENTIFIED BY 'gestore';

GRANT EXECUTE ON procedure `mydb`.`aggiungi_fermata_tratta` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`elenco_scadenze_patente` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`assegna_conducente_corsa` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`registra_conducente` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`nuova_partenza` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`aggiungi_tratta` TO 'gestore';
GRANT EXECUTE ON procedure `mydb`.`lista_tratte_totali` TO 'gestore';
SHOW WARNINGS;
SET SQL_MODE = '';
DROP USER IF EXISTS login;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW WARNINGS;
CREATE USER 'login' IDENTIFIED BY 'login';

GRANT EXECUTE ON procedure `mydb`.`login` TO 'login';
GRANT EXECUTE ON procedure `mydb`.`attiva_gps` TO 'login';
GRANT EXECUTE ON procedure `mydb`.`preleva_capolinea` TO 'login';
GRANT EXECUTE ON procedure `mydb`.`preleva_fermata` TO 'login';
SHOW WARNINGS;
SET SQL_MODE = '';
DROP USER IF EXISTS viaggiatore;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW WARNINGS;
CREATE USER 'viaggiatore' IDENTIFIED BY 'viaggiatore';

GRANT EXECUTE ON procedure `mydb`.`lista_veicoli` TO 'viaggiatore';
GRANT EXECUTE ON procedure `mydb`.`distanza_veicolo` TO 'viaggiatore';
GRANT EXECUTE ON procedure `mydb`.`convalida_biglietto` TO 'viaggiatore';
GRANT EXECUTE ON procedure `mydb`.`lista_tratte` TO 'viaggiatore';
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Utenti`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Utenti` (`Username`, `Password`, `Ruolo`) VALUES ('gio', '2bb55d712c4dcbda95497e811b696352', 'Conducente');
INSERT INTO `mydb`.`Utenti` (`Username`, `Password`, `Ruolo`) VALUES ('jake', '1200cf8ad328a60559cf5e7c5f46ee6d', 'Conducente');
INSERT INTO `mydb`.`Utenti` (`Username`, `Password`, `Ruolo`) VALUES ('mike', '18126e7bd3f84b3f3e4df094def5b7de', 'Conducente');
INSERT INTO `mydb`.`Utenti` (`Username`, `Password`, `Ruolo`) VALUES ('andrea', '1c42f9c1ca2f65441465b43cd9339d6c', 'Gestore');
INSERT INTO `mydb`.`Utenti` (`Username`, `Password`, `Ruolo`) VALUES ('steve', 'd69403e2673e611d4cbd3fad6fd1788e', 'Viaggiatore');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Conducente`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Conducente` (`CF`, `Nome`, `Cognome`, `NumeroPatente`, `ScadenzaPatente`, `LuogoNascita`, `DataNascita`, `Username`) VALUES ('SNTNDR76A01H501Q', 'Gio', 'Ponte', 'abcd123456', '2026-09-10', 'Roma', '1967-01-01', 'gio');
INSERT INTO `mydb`.`Conducente` (`CF`, `Nome`, `Cognome`, `NumeroPatente`, `ScadenzaPatente`, `LuogoNascita`, `DataNascita`, `Username`) VALUES ('CIAMCL80A02H501J', 'Michele', 'Treno', 'hhhh123456', '2028-01-01', 'Roma', '2000-07-07', 'mike');
INSERT INTO `mydb`.`Conducente` (`CF`, `Nome`, `Cognome`, `NumeroPatente`, `ScadenzaPatente`, `LuogoNascita`, `DataNascita`, `Username`) VALUES ('CIACIA90A01H501X', 'Jake', 'Bus', 'mmmm123456', '2020-03-09', 'Roma', '1998-05-01', 'jake');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Veicolo`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (1111, '2000-01-01');
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (2222, '2001-01-01');
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (3333, '2002-01-01');
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (4444, '2002-08-08');
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (5555, '2010-09-10');
INSERT INTO `mydb`.`Veicolo` (`Matricola`, `DataAcquisto`) VALUES (6666, '2010-10-25');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Fermata`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (12345, 40.7600000, 73.98400000);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (67891, 73.98400000, 40.7600000);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (45678, 12.12312312, 12.12312312);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (87654, 67.00000000, 23.00012345);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (21987, 34.00011111, 56.11155665);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (65489, 42.09876543, 91.75675665);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (98256, 10.26988833, 20.98754678);
INSERT INTO `mydb`.`Fermata` (`Codice`, `Longitudine`, `Latitudine`) VALUES (78564, 22.00088883, 57.10001999);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Tratta`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (1, 20, 65489, 98256);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (2, 20, 98256, 65489);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (3, 500, 12345, 67891);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (4, 500, 12345, 12345);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (5, 552, 65489, 98256);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (6, 552, 98256, 65489);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (7, 34, 45678, 21987);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (8, 34, 21987, 45678);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (9, 110, 98256, 12345);
INSERT INTO `mydb`.`Tratta` (`ID`, `Numero`, `Capolinea_Da`, `Capolinea_A`) VALUES (10, 44, 65489, 12345);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Biglietto`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (1234, 1, 'Standard');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (5678, 1, 'Abbonamento');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (9123, 0, 'Standard');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (9108, 0, 'Standard');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (8888, 1, 'Abbonamento');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (9999, 0, 'Abbonamento');
INSERT INTO `mydb`.`Biglietto` (`Numero`, `Valido`, `Tipo`) VALUES (2323, 1, 'Standard');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`VeicoloinCorsa`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Monday', '09:00', 1111, 1, 0, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Monday', '14:00', 1111, 2, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Tuesday', '10:00', 2222, 3, 1, 0, 'CIACIA90A01H501X');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Tuesday', '18:00', 2222, 4, 0, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Wednesday', '11:00', 3333, 5, 1, 0, 'CIACIA90A01H501X');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Wednesday', '17:00', 3333, 6, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Thursday', '12:00', 3333, 1, 1, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Thursday', '19:00', 2222, 3, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Friday', '13:00', 2222, 2, 1, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Friday', '12:45', 1111, 3, 0, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Saturday', '07:00', 3333, 2, 1, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Saturday', '06:30', 2222, 1, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Sunday', '20:00', 1111, 4, 1, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Sunday', '12:00', 3333, 5, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Friday', '06:30', 2222, 1, 0, 0, 'CIAMCL80A02H501J');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Monday', '14:00', 4444, 5, 1, 0, 'CIACIA90A01H501X');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Monday', '19:00', 3333, 4, 1, 0, 'SNTNDR76A01H501Q');
INSERT INTO `mydb`.`VeicoloinCorsa` (`Giorno`, `Ora`, `Veicolo`, `Tratta`, `Partito`, `UltimaFermata`, `Conducente`) VALUES ('Tuesday', '05:30', 1111, 2, 1, 0, 'CIAMCL80A02H501J');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Effettua`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 12345, 1);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 65489, 1);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 87654, 1);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 98256, 1);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 87654, 2);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 67891, 2);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 12345, 2);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 65489, 2);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 65489, 3);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 87654, 3);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 21987, 3);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 67891, 3);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 98256, 4);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 45678, 4);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 78564, 4);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 12345, 4);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 67891, 5);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 45678, 5);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 12345, 5);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 98256, 5);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (1, 12345, 6);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (2, 45678, 6);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (3, 78564, 6);
INSERT INTO `mydb`.`Effettua` (`Indice`, `Fermata_Codice`, `Tratta_ID`) VALUES (4, 98256, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Abbonato`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Abbonato` (`Nome`, `Cognome`, `DataScadenza`, `UltimoUtilizzo`, `Biglietto_Numero`, `CodiceFiscale`) VALUES ('Andrea', 'Andrea', '2024-10-10', NULL, 5678, 'STNDR145678925');
INSERT INTO `mydb`.`Abbonato` (`Nome`, `Cognome`, `DataScadenza`, `UltimoUtilizzo`, `Biglietto_Numero`, `CodiceFiscale`) VALUES ('Jake', 'Jaky', '2026-09-10', NULL, 8888, 'ABHFS896742234');
INSERT INTO `mydb`.`Abbonato` (`Nome`, `Cognome`, `DataScadenza`, `UltimoUtilizzo`, `Biglietto_Numero`, `CodiceFiscale`) VALUES ('Miky', 'Miky', '2024-05-23', NULL, 9999, 'XJNHD907654278');

COMMIT;

set global event_scheduler = on;

DELIMITER //

create event if not exists biglietti_non_validi
on schedule every 30 day
starts current_timestamp + interval 30 day
on completion preserve
do 
begin
	delete from Biglietto where Valido = 0;
end

//

create event if not exists controllo_abbonamento
on schedule every 1 day
starts '2025-06-12 00:01:00'
on completion preserve
do
begin
	update Biglietto
    join Abbonato on Numero = Biglietto_Numero
    set Valido = 0
    where DataScadenza < curdate() ;
    
end
//

