/*Al realizarse el préstamo de un ejemplar, se deberá de modificar el estatus
de éste automáticamente.*/

CREATE OR REPLACE TRIGGER tgCambioEstatus
AFTER INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
	UPDATE Ejemplar
	SET estatus = 'Prestamo'
	WHERE numEjem=:NEW.numEjem AND identificadorMaterial = :NEW.identificadorMaterial;

	
END tgCambioEstatus;
/


/*Si un lector tiene una multa, no se le podrán prestar materiales hasta que la
haya liquidado.*/

CREATE OR REPLACE TRIGGER tgDisponibilidadPrestamo
BEFORE INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
	IF :NEW.multa>0 THEN
		 RAISE_APPLICATION_ERROR(-20000, ‘No se puede realizar el prestamo, existe una multa asociada al lector’);
	END IF;

END tgDisponibilidadPrestamo;
/

--HAcer disparador para cambiar el estatus al devolver.
CREATE OR REPLACE TRIGGER tgEstatusDevolucion
AFTER DELETE ON PRESTAMO
FOR EACH ROW
BEGIN
	UPDATE Ejemplar
	SET estatus = 'Disponible'
	WHERE numEjem=:OLD.numEjem AND identificadorMaterial = :OLD.identificadorMaterial;
	

END tgEstatusDevolucion;
/


CREATE OR REPLACE TRIGGER tgActRefrendo
BEFORE UPDATE OF fechaVencimiento ON PRESTAMO 
FOR EACH ROW
BEGIN
	:NEW.resello := :OLD.resello+1;

END tgEstatusDevolucion;
/



