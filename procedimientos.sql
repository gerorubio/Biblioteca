CREATE OR REPLACE PROCEDURE spAltaTipoLector(
	vTipo			 TIPOLECTOR.tipo%TYPE,
	vDiasPer		 TIPOLECTOR.diasPermitidos%TYPE,
	vLimiteMat		 TIPOLECTOR.limiteMaterial%TYPE,	
	vRefrendo		 TIPOLECTOR.refrendo%TYPE)
AS
BEGIN
	INSERT INTO TIPOLECTOR VALUES(vTipo,vDiasPer,vLimiteMat,vRefrendo);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Tipo de lector dado de alta: '|| vTipo);
END spAltaTipoLector;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaLector(
	vIdLe			 LECTOR.idLector%TYPE,
	vAdeudoLec		 LECTOR.adeudoLec%TYPE,
	vNombLec		 LECTOR.nombLec%TYPE,	
	vApPatLec		 LECTOR.apPatLec%TYPE ,		
	vApMatLec		 LECTOR.apMatLec%TYPE,
	vDelegacionL	 LECTOR.delegacionL%TYPE,		
	vColoniaL		 LECTOR.coloniaL%TYPE,		
	vCalleL			 LECTOR.calleL%TYPE ,
	vNumeroL		 LECTOR.numeroL%TYPE ,
	vTelefonoLec	 LECTOR.telefonoLec%TYPE ,
	vFechaAlta		 LECTOR.fechaAlta%TYPE ,	
	vTipo			 LECTOR.tipo%TYPE )
AS
	vFechaVigencia	 LECTOR.fechaVigencia%TYPE;
BEGIN
	vFechaVigencia := vFechaAlta + 365;
	INSERT INTO LECTOR VALUES(vIdLe,vAdeudoLec,vNombLec,vApPatLec,vApMatLec,vDelegacionL,vColoniaL,vCalleL,vNumeroL,vTelefonoLec,vFechaAlta,vFechaVigencia,vTipo);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Lector dado de alta: '||vIdLe);
END spAltaLector;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaDirector(
	vIdDir		 DIRECTOR.identificadorD%TYPE,
	vNomDir		 DIRECTOR.nomDir%TYPE,
	vApPatDir	 DIRECTOR.apPatDir%TYPE,
	vApMatDir	 DIRECTOR.apMatDir%TYPE,
	vGrado		 DIRECTOR.grado%TYPE	)
AS
BEGIN
	INSERT INTO DIRECTOR VALUES(vIdDir,vNomDir,vApPatDir,vApMatDir,vGrado);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Director dado de alta: '||vIdDir);
END spAltaDirector;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaAutor(
	vClaveAutor		 AUTOR.claveAutor%TYPE,
	vNombreA		 AUTOR.nombreA%TYPE,		
	vApPatA			 AUTOR.apPatA%TYPE,		
	vApMatA			 AUTOR.apMatA%TYPE,
	vNacionalidad    AUTOR.nacionalidad%TYPE	)
AS
BEGIN
	INSERT INTO AUTOR VALUES(vClaveAutor,vNombreA,vApPatA,vApMatA,vNacionalidad);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Autor dado de alta: '||vClaveAutor);
END spAltaAutor;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE arreglo AS VARRAY(200) OF CHAR(4);

CREATE OR REPLACE PROCEDURE spAltaMaterial(
	vIdMaterial 	 MATERIAL.identificadorMaterial%TYPE,
	vTitulo			 MATERIAL.titulo%TYPE,
	vColocacion		 MATERIAL.colocacion%TYPE,
	vUbicacion		 MATERIAL.ubicacion%TYPE,
	vTipoMaterial	 MATERIAL.tipoMaterial%TYPE,
	vAutores 		 arreglo)
AS
BEGIN
	INSERT INTO MATERIAL VALUES(vIdMaterial,vTitulo,vColocacion,vUbicacion,vTipoMaterial);
	FOR i IN 1..vAutores.count LOOP
		INSERT INTO MATAUTOR VALUES(vIdMaterial, vAutores(i));
	END LOOP;

	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Material dado de alta: '||vIdMaterial);
END spAltaMaterial;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaLibro(
	vIdM 			 Libro.identificadorMaterial%TYPE,
	vNoAdquicion	 Libro.noAdquisicion%TYPE,
	vISBN			 Libro.ISBN%TYPE,
	vTema 			 Libro.tema%TYPE,
	vEdicion		 Libro.edicion%TYPE)
AS
	vTipo			 Material.tipoMaterial%TYPE;
BEGIN
	SELECT tipoMaterial INTO vTipo FROM material
	WHERE identificadorMaterial = vIdM;
	IF vTipo = 'Libro' THEN
		INSERT INTO LIBRO VALUES(vIdM,vNoAdquicion,vISBN,vTema,vEdicion);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Este material no es un libro');
		RETURN;
	END IF;
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Libro dado de alta: '||vIdM);
END spAltaLibro;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaTesis(
	vIdM 					 TESIS.identificadorMaterial%TYPE,
	vIdD					 TESIS.identificadorDir%TYPE,
	vCarreraTema			 TESIS.carreraTema%TYPE,
	vAnioPublicacion		 TESIS.anioPublicacion%TYPE)
AS
	vTipo			 Material.tipoMaterial%TYPE;
BEGIN
	SELECT tipoMaterial INTO vTipo FROM MATERIAL
	WHERE identificadorMaterial = vIdM;
	IF vTipo = 'Tesis' THEN
		INSERT INTO TESIS VALUES(vIdM,vCarreraTema,vAnioPublicacion,vIdD);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Este material no es una tesis');
		RETURN;
	END IF;
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Tesis dada de alta: '||vIdM);
END spAltaTesis;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaEjemplar(
	vIdMaterial 	 EJEMPLAR.identificadorMaterial%TYPE ,
	vNumEjem		 EJEMPLAR.numEjem%TYPE,
	vEstatus		 EJEMPLAR.estatus%TYPE	)
AS
BEGIN
	INSERT INTO EJEMPLAR VALUES(vIdMaterial,vNumEjem, vEstatus);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Ejemplar dado de alta: '||vIdMaterial);
END spAltaEjemplar;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spAltaPrestamo(
	vIdPrestamo				 PRESTAMO.idPrestamo%TYPE,
	vIdLector 				 PRESTAMO.idLector%TYPE,
    vIdentificadorMaterial 	 PRESTAMO.identificadorMaterial%TYPE,
	vNumEjem 				 PRESTAMO.numEjem%TYPE,
    vFechaRealiza 			 PRESTAMO.fechaRealiza%TYPE)
AS
	vFechaVencimiento 	 PRESTAMO.fechaVencimiento%TYPE;
	vMulta 				 PRESTAMO.multa%TYPE;
	vResello 			 PRESTAMO.resello%TYPE;
	vDiasPermitidos 	 TIPOLECTOR.diasPermitidos%TYPE;
	vTipoLec			 TIPOLECTOR.tipo%TYPE;
	vEstus 				 EJEMPLAR.estatus%TYPE;
	vLimiteMat 			 TIPOLECTOR.limiteMaterial%TYPE;
	vCant				 NUMBER(1);
BEGIN
	SELECT l.tipo
	INTO vTipoLec
	FROM LECTOR l
	WHERE l.idLector=vIdLector;

	SELECT tl.diasPermitidos,tl.limiteMaterial
	INTO vDiasPermitidos,vLimiteMat
	FROM TIPOLECTOR tl
	WHERE tl.tipo=vTipoLec;

	SELECT e.estatus
	INTO vEstus
	FROM EJEMPLAR e
	WHERE e.identificadorMaterial = vIdentificadorMaterial AND e.numEjem = vNumEjem;

	SELECT count(*)
	INTO vCant
	FROM PRESTAMO p
	WHERE p.idLector = vIdLector;

	IF vLimiteMat > vCant THEN
		IF vEstus = 'Disponible' THEN 
			vFechaVencimiento := vFechaRealiza + vDiasPermitidos;
			INSERT INTO PRESTAMO VALUES(vIdPrestamo,vIdLector, vIdentificadorMaterial, vNumEjem, vFechaRealiza, vFechaVencimiento, NULL, vMulta, vResello);
			DBMS_OUTPUT.PUT_LINE('Prestamo dado de alta: '||vIdLector || vIdentificadorMaterial || vNumEjem);
		ELSE
			DBMS_OUTPUT.PUT_LINE('El ejemplar no se puede prestar, el ejemplar esta: ' || vEstus);
		END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Agotó el número de prestamos permitidos.' || vLimiteMat);
	END IF;
COMMIT;
END spAltaPrestamo;
/

----Despues de añadir secuencias
CREATE OR REPLACE PROCEDURE spAltaPrestamo(
	vIdLector 				 PRESTAMO.idLector%TYPE,
    vIdentificadorMaterial 	 PRESTAMO.identificadorMaterial%TYPE,
	vNumEjem 				 PRESTAMO.numEjem%TYPE,
    vFechaRealiza 			 PRESTAMO.fechaRealiza%TYPE)
AS
	vIdPrestamo			 PRESTAMO.idPrestamo%TYPE;
	vFechaVencimiento 	 PRESTAMO.fechaVencimiento%TYPE;
	vMulta 				 PRESTAMO.multa%TYPE;
	vResello 			 PRESTAMO.resello%TYPE;
	vDiasPermitidos 	 TIPOLECTOR.diasPermitidos%TYPE;
	vTipoLec			 TIPOLECTOR.tipo%TYPE;
	vEstus 				 EJEMPLAR.estatus%TYPE;
	vLimiteMat 			 TIPOLECTOR.limiteMaterial%TYPE;
	vCant				 NUMBER(1);
BEGIN

	SELECT l.tipo
	INTO vTipoLec
	FROM LECTOR l
	WHERE l.idLector=vIdLector;

	SELECT tl.diasPermitidos,tl.limiteMaterial
	INTO vDiasPermitidos,vLimiteMat
	FROM TIPOLECTOR tl
	WHERE tl.tipo=vTipoLec;

	SELECT e.estatus
	INTO vEstus
	FROM EJEMPLAR e
	WHERE e.identificadorMaterial = vIdentificadorMaterial AND e.numEjem = vNumEjem;

	SELECT count(*)
	INTO vCant
	FROM PRESTAMO p
	WHERE p.idLector = vIdLector;

	IF vLimiteMat > vCant THEN
		IF vEstus = 'Disponible' THEN 
			SELECT idPres INTO vIdPrestamo
			FROM dual;
			vFechaVencimiento := vFechaRealiza + vDiasPermitidos;
			INSERT INTO PRESTAMO VALUES(vIdPrestamo,vIdLector, vIdentificadorMaterial, vNumEjem, vFechaRealiza, vFechaVencimiento, NULL, vMulta, vResello);
			DBMS_OUTPUT.PUT_LINE('Prestamo dado de alta: '||vIdLector || vIdentificadorMaterial || vNumEjem);
		ELSE
			DBMS_OUTPUT.PUT_LINE('El ejemplar no se puede prestar, el ejemplar esta: ' || vEstus);
		END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Agotó el número de prestamos permitidos.' || vLimiteMat);
	END IF;

COMMIT;
END spAltaPrestamo;
/

---------------------------------------------------------------------------------------

/*-Al realizarse una devolución en tiempo, se eliminará el préstamo*/

CREATE OR REPLACE PROCEDURE spDevolucion(
	vIdPrestamo 		 PRESTAMO.idPrestamo%TYPE,
	vFechaDevolucion 	 PRESTAMO.fechaDevolucion%TYPE
    )
AS
	vFechaVencimiento 	 PRESTAMO.fechaVencimiento%TYPE;
	vMulta 				 PRESTAMO.multa%TYPE;
	vDiasAtrasados		 NUMBER(2);
	vRes 				 NUMBER(2);
	vAdeudoLec			 LECTOR.adeudoLec%TYPE;
	vIdLector			 LECTOR.idLector%TYPE;
BEGIN
	SELECT p.fechaVencimiento, p.multa
	INTO vFechaVencimiento,vMulta
	FROM PRESTAMO p
	WHERE p.idPrestamo= vIdPrestamo;

	vDiasAtrasados := vFechaDevolucion - vFechaVencimiento;
	IF vDiasAtrasados<=0 THEN
		DBMS_OUTPUT.PUT_LINE('Ejemplar devuelto: '||vIdPrestamo);
		--No hay multa y se elimina
	ELSE
		--multiplicar vDiasAtrasados por 10 y esto sería el valor de la multa.

		vRes := vDiasAtrasados*10;

		SELECT idLector INTO vIdLector FROM PRESTAMO
		WHERE idPrestamo = vIdPrestamo;

		SELECT adeudoLec INTO vAdeudoLec
		FROM LECTOR
		WHERE idLector = vIdLector;

		UPDATE LECTOR
		SET adeudoLec = vAdeudoLec + vRes
		WHERE idLector = vIdLector;
		DBMS_OUTPUT.PUT_LINE('Ejemplar devuelto: '||vIdPrestamo);
		DBMS_OUTPUT.PUT_LINE('Se le añadio un adeudo de: '|| vRes);
	END IF;
	DELETE FROM PRESTAMO 
	WHERE idPrestamo= vIdPrestamo;
	COMMIT;
	
END spDevolucion;
/

---------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE spPagarMulta(
	vIdLector LECTOR.idLector%TYPE,
	vMonto LECTOR.adeudoLec%TYPE)
AS
    vAdeudo LECToR.adeudoLec%TYPE;
BEGIN
	SELECT adeudoLec INTO vAdeudo
	FROM LECTOR
	WHERE idLector = vIdLector;

	IF vAdeudo > 0 THEN
		UPDATE LECTOR
		SET adeudoLec = vAdeudo - vMonto
		WHERE idLector = vIdLector;
	ELSE
		DBMS_OUTPUT.PUT_LINE('No tiene ningun adeudo este lector');
	END IF;
END spPagarMulta;
/

---------------------------------------------------------------------------------------

/*
-El resello de un material se realiza únicamente en la fecha de vencimiento
del préstamo en función del tipo de lector.
/*- Al resellar el préstamo de un material, la fecha del préstamo cambiará a la
fecha en la que se resella, la fecha de vencimiento se volverá a calcular
dependiendo del tipo de lector y se actualizará el número de refrendo
automáticamente.
*/

--Fecha venc que calcula*/

CREATE OR REPLACE PROCEDURE pResello (vIdPre PRESTAMO.idPrestamo%TYPE)
AS
	vNumResello  PRESTAMO.resello%TYPE;
	vFechSys DATE := SYSDATE;
	vtipLec LECTOR.tipo%TYPE;
	vDiasPerm   TIPOLECTOR.diasPermitidos%TYPE;
	vFechVen PRESTAMO.fechaVencimiento%TYPE;
	vRef TIPOLECTOR.refrendo%TYPE;
	vidLec LECTOR.idLector%TYPE;
	vDif NUMBER(1);
BEGIN
	--Obtiene el tipo de lector y los dias que le son permitidos
	SELECT p.idLector
	INTO vIdLec
	FROM PRESTAMO p
	WHERE p.idPrestamo= vIdPre;


	SELECT l.tipo, t.diasPermitidos, t.refrendo
	INTO vtipLec, vDiasPerm, vRef
	FROM PRESTAMO p
	JOIN LECTOR l
	ON vIdLec=l.idLector
	JOIN TIPOLECTOR t
	ON l.tipo=t.tipo
	WHERE p.idLector = vIdLec;

	--Obtiene fecha de vencimiento
	SELECT p.fechaVencimiento, p.resello
	INTO vFechVen, vNumResello
	FROM PRESTAMO p
	WHERE idPrestamo=vIdPre;

	vDif := vFechVen - SYSDATE;
	IF vDif = 0 AND vNumResello<=vRef THEN
		--Actualiza la fecha en la que se realiza el prestamo
		UPDATE PRESTAMO
		SET fechaRealiza = vFechVen
		WHERE idPrestamo=vIdPre;

		--Modificamos la fecha de vencimiento
		UPDATE PRESTAMO
		SET fechaVencimiento = vFechVen + vDiasPerm
		WHERE idPrestamo=vIdPre;

		ELSE
		DBMS_OUTPUT.PUT_LINE('No se puede realizar otro resello porque no cumple con la fecha de vencimiento o agotó resellos');
	END IF;

END pResello;
/

---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

DROP TABLE PRESTAMO CASCADE CONSTRAINTS PURGE;
DROP TABLE EJEMPLAR CASCADE CONSTRAINTS PURGE;
DROP TABLE TESIS CASCADE CONSTRAINTS PURGE;
DROP TABLE LIBRO CASCADE CONSTRAINTS PURGE;
DROP TABLE MATAUTOR CASCADE CONSTRAINTS PURGE;
DROP TABLE LECTOR CASCADE CONSTRAINTS PURGE;
DROP TABLE TIPOLECTOR CASCADE CONSTRAINTS PURGE;
DROP TABLE DIRECTOR CASCADE CONSTRAINTS PURGE;
DROP TABLE AUTOR CASCADE CONSTRAINTS PURGE;
DROP TABLE MATERIAL CASCADE CONSTRAINTS PURGE;

DROP PROCEDURE spAltaTipoLector;
DROP PROCEDURE spAltaLector;
DROP PROCEDURE spAltaDirector;
DROP PROCEDURE spAltaAutor;
DROP PROCEDURE spAltaMaterial;
DROP PROCEDURE spAltaLibro;
DROP PROCEDURE spAltaTesis;

SELECT * FROM MATERIAL;
SELECT * FROM AUTOR;
SELECT * FROM DIRECTOR;
SELECT * FROM TIPOLECTOR;
SELECT * FROM LECTOR;
SELECT * FROM MATAUTOR;
SELECT * FROM LIBRO;
SELECT * FROM TESIS;
SELECT * FROM EJEMPLAR;
SELECT * FROM PRESTAMO;

DELETE PRESTAMO;
DELETE LECTOR;
DELETE TIPOLECTOR;
DELETE EJEMPLAR;
DELETE MATERIAL;
DELETE AUTOR;
DELETE DIRECTOR;