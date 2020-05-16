EXEC spAltaTipoLector('Alumno', 8, 3, 1);
EXEC spAltaTipoLector('Profesor', 15, 5, 2);
EXEC spAltaTipoLector('Investigador', 30, 10, 3);

---------------------------------------------------------------------------------------

EXEC spAltaLector('A0',0,'Juan','Perez','Ramirez','Coyoacan','StoDom','Cerrodelagua',500,'554323232',SYSDATE,'Alumno');
EXEC spAltaLector('P1',0,'Marcos','Hernando','Larrosa','Iztapalapa','Lopez Portillo','Calle 12',20,'5544323232',SYSDATE,'Alumno');
EXEC spAltaLector('C2',0,'Lucia','Mesas','Cerda','Tlahuac','La Mesa','Calle 13',500,'554323232',SYSDATE,'Alumno');
EXEC spAltaLector('A1',0,'Karla','Barba','Gerdo','Iztacalco','Zapotla','Calle 121',500,'554323232',SYSDATE,'Profesor');
EXEC spAltaLector('P2',0,'Julia','Ceballos','Chinea','Xochimilco','San Diego','Calle 11',500,'554323232',SYSDATE,'Investigador');
EXEC spAltaLector('P3',12.00,'Julia','Ceballos','Chinea','Xochimilco','San Diego','Calle 11',500,'554323232',SYSDATE,'Investigador');

---------------------------------------------------------------------------------------

EXEC spAltaDirector('D1', 'Luis', 'Martinez', 'Aguirre', 'Alto');
EXEC spAltaDirector('D2', 'Hugo', 'Mendoza', 'Perez', 'Medio');
EXEC spAltaDirector('D3', 'Lucia', 'Ruiz', 'Cabrera', 'Bajo');

---------------------------------------------------------------------------------------

EXEC spAltaAutor('A1', 'Raul', 'Garcia', 'Moreno', 'Mexico');
EXEC spAltaAutor('A2', 'John', 'William', '', 'Canada');
EXEC spAltaAutor('A3', 'Alex', 'Hernandez', 'Serrano', 'España');

---------------------------------------------------------------------------------------

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(2);
	v_t(1) := 'A1';
	v_t(2) := 'A2';
	spAltaMaterial('LD12', 'Bases de datos', 'RT3421', '12A', 'Libro', v_t);
END;
/

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(1);
	v_t(1) := 'A1';
	spAltaMaterial('LD13', 'Inteligencia Artificial', 'RT3443', '12B', 'Libro', v_t);
END;
/

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(1);
	v_t(1) := 'A2';
	spAltaMaterial('LD14', 'Robots', 'R2D2', '12C', 'Libro', v_t);
END;
/

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(3);
	v_t(1) := 'A1';
	v_t(2) := 'A2';
	v_t(3) := 'A3';
	spAltaMaterial('TD12', 'SQL/PL', 'RT3742', '12C', 'Tesis', v_t);
END;
/

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(1);
	v_t(1) := 'A3';
	spAltaMaterial('TD13', 'Redes', 'RT3496', '11A', 'Tesis', v_t);
END;
/

DECLARE
	v_t arreglo;
BEGIN
	v_t := arreglo();
	v_t.EXTEND(1);
	v_t(1) := 'A2';
	spAltaMaterial('TD14', 'Sistemas operativos', 'RT3786', '10A', 'Tesis', v_t);
END;
/

---------------------------------------------------------------------------------------

EXEC spAltaLibro('LD12', 12, 'QWER1234', 'Bases de datos', 'Primera');
EXEC spAltaLibro('LD13', 13, 'QWER1235', 'IA', 'Segunda');
EXEC spAltaLibro('LD14', 11, 'C3PO', 'Robots', 'Sexta');
EXEC spAltaLibro('TD13', 11, 'C3PO', 'Robots', 'Sexta'); --No es libro


---------------------------------------------------------------------------------------

EXEC spAltaTesis('TD12', 'D1', 'Bases de datos', TO_DATE('05/05/2015', 'dd/mm/yyyy'));
EXEC spAltaTesis('TD13', 'D3', 'Redes', TO_DATE('30/04/2009', 'dd/mm/yyyy'));

---------------------------------------------------------------------------------------

EXEC spAltaEjemplar('LD12', 2, 'Disponible');
EXEC spAltaEjemplar('LD12', 3, 'No sale de biblioteca');
EXEC spAltaEjemplar('LD13', 1, 'Disponible');
EXEC spAltaEjemplar('LD14', 1, 'Disponible');
EXEC spAltaEjemplar('LD14', 2, 'Disponible');
EXEC spAltaEjemplar('LD14', 3, 'Disponible');
EXEC spAltaEjemplar('TD13', 1, 'Disponible');
EXEC spAltaEjemplar('TD12', 1, 'En Mantenimiento');

---------------------------------------------------------------------------------------

EXEC spAltaPrestamo('P1', 'A0', 'LD14', 1, SYSDATE);
EXEC spAltaPrestamo('P2', 'C2', 'TD12', 1, SYSDATE); -- No se presta
EXEC spAltaPrestamo('P2', 'C2', 'LD14', 3, SYSDATE);
--
EXEC spAltaPrestamo('C2', 'LD14', 2, SYSDATE);
EXEC spAltaPrestamo('A1', 'TD13', 1, SYSDATE);
EXEC spAltaPrestamo('C2', 'TD13', 1, SYSDATE);
EXEC spAltaPrestamo('A0', 'LD14', 1, SYSDATE);
EXEC spAltaPrestamo('A0', 'TD13', 1, SYSDATE);


---------------------------------------------------------------------------------------

EXEC spDevolucion('PR40', SYSDATE);
EXEC spDevolucion('P1', TO_DATE('19-05-2020'));
EXEC spDevolucion('PR7', TO_DATE('27-05-2020'));
EXEC spDevolucion('PR20', TO_DATE('20-05-2020'));

EXEC spDevolucion('PR13', TO_DATE('17-05-2020'));



---------------------------------------------------------------------------------------

EXEC spPagarMulta('P3', 10);

---------------------------------------------------------------------------------------

INSERT INTO PRESTAMO VALUES('PR89', 'A1', 'LD12', 3, SYSDATE, SYSDATE, '', 0, 0);

EXEC pResello('PR89');