CREATE TABLE material(
	identificadorMaterial 	 CHAR(4) NOT NULL,
	titulo					 VARCHAR2 (30) NOT NULL,
	colocacion				 VARCHAR2 (15) NOT NULL,
	ubicacion				 VARCHAR2(15) NOT NULL,
	tipoMaterial			 CHAR(5) NOT NULL,
	CONSTRAINT pk_matertial PRIMARY KEY(identificadorMaterial),
	CONSTRAINT ck_tipoMat CHECK (tipoMaterial IN ('Tesis','Libro'))
);

CREATE TABLE autor(
	claveAutor		 CHAR (4) NOT NULL,
	nombreA			 VARCHAR2 (20) NOT NULL,		
	apPatA			 VARCHAR2 (20) NOT NULL,		
	apMatA			 VARCHAR2 (20),
	nacionalidad	 VARCHAR2 (20) NOT NULL,
	CONSTRAINT pk_claveAutor PRIMARY KEY (claveAutor)
);

CREATE TABLE director(
	identificadorD	 CHAR (4) NOT NULL,
	nomDir			 VARCHAR2 (20) NOT NULL,
	apPatDir		 VARCHAR2 (20) NOT NULL,
	apMatDir		 VARCHAR2 (20),
	grado			 VARCHAR2 (10) NOT NULL,
	CONSTRAINT pk_idDirector PRIMARY KEY (identificadorD)
);

CREATE TABLE tipoLector(
	tipo			 VARCHAR2 (12) NOT NULL,
	diasPermitidos	 NUMBER (2) NOT NULL,		
	limiteMaterial	 NUMBER (2) NOT NULL,		
	refrendo		 NUMBER (1) NOT NULL,
	CONSTRAINT pk_tipoLector PRIMARY KEY (tipo),
	CONSTRAINT ck_tipo CHECK (tipo IN ('Alumno','Profesor','Investigador'))
);

CREATE TABLE lector(
	idLector		 CHAR (4) NOT NULL,
	adeudoLec		 NUMBER(3,2),
	nombLec			 VARCHAR2 (20) NOT NULL,	
	apPatLec		 VARCHAR2 (20) NOT NULL,		
	apMatLec		 VARCHAR2 (20),
	delegacionL		 VARCHAR2 (15) NOT NULL,		
	coloniaL		 VARCHAR2 (20) NOT NULL,		
	calleL			 VARCHAR2 (15) NOT NULL,
	numeroL			 NUMBER(3) NOT NULL,
	telefonoLec		 VARCHAR2(10) NOT NULL,
	fechaAlta		 DATE NOT NULL,	
	fechaVigencia	 DATE NOT NULL,
	tipo			 VARCHAR2 (12) NOT NULL,
	CONSTRAINT pk_idLector PRIMARY KEY (idLector),
	CONSTRAINT fk_lec_tipoLec FOREIGN KEY (tipo)
	REFERENCES TIPOLECTOR (tipo)
	ON DELETE SET NULL
);
ALTER TABLE LECTOR MODIFY adeudoLec NUMBER(5, 2);


CREATE TABLE matAutor(
	identificadorMaterial		 CHAR(4) NOT NULL,
	claveAutor				   	 CHAR (4) NOT NULL,
	CONSTRAINT pk_matAutor PRIMARY KEY(identificadorMaterial,claveAutor),
	CONSTRAINT fk_matAut_mat FOREIGN KEY(identificadorMaterial)
	REFERENCES material (identificadorMaterial)
	ON DELETE CASCADE,
	CONSTRAINT fk_matAut_aut FOREIGN KEY(claveAutor)
	REFERENCES autor (claveAutor)
	ON DELETE SET NULL
);

CREATE TABLE libro(
	identificadorMaterial	 CHAR(4) NOT NULL,
	noAdquisicion			 NUMBER(5) NOT NULL,
	ISBN					 VARCHAR2 (18) NOT NULL,
	tema					 VARCHAR2 (30) NOT NULL,		
	edicion					 VARCHAR2 (20) NOT NULL,
	CONSTRAINT pk_libro PRIMARY Key (identificadorMaterial),
	CONSTRAINT fk_libro_mat FOREIGN KEY (identificadorMaterial)
	REFERENCES MATERIAL(identificadorMaterial)
	ON DELETE CASCADE,
	CONSTRAINT un_noAdq UNIQUE (noAdquisicion),
	CONSTRAINT un_isbn UNIQUE (ISBN)
);

CREATE TABLE tesis(
	identificadorMaterial	 CHAR(4) NOT NULL,
	--identificadorTesis		CHAR(4) NOT NULL,
	carreraTema				 VARCHAR2 (30) NOT NULL,
	anioPublicacion			 DATE NOT NULL,
	identificadorDir		 CHAR(4) NOT NULL,
	CONSTRAINT pk_tesis PRIMARY KEY(identificadorMaterial),
    --CONSTRAINT u_identificadorTesis UNIQUE (identificadorTesis),
	CONSTRAINT fk_tesis_mat FOREIGN KEY(identificadorMaterial)
	REFERENCES material
	ON DELETE CASCADE,
	CONSTRAINT fk_tesis_dir FOREIGN KEY(identificadorDir)
	REFERENCES director
	ON DELETE SET NULL
);

CREATE TABLE ejemplar(
	identificadorMaterial	 CHAR(4) NOT NULL,
	numEjem					 NUMBER(5) NOT NULL ,
	estatus					 VARCHAR2 (23) NOT NULL,
	CONSTRAINT pk_ejemplar PRIMARY KEY (identificadorMaterial, numEjem),
	CONSTRAINT fk_ejem_mat FOREIGN KEY (identificadorMaterial)
	REFERENCES MATERIAL(identificadorMaterial)
	ON DELETE CASCADE,
	CONSTRAINT ck_estatus CHECK (estatus IN ('Disponible', 'Prestamo', 'No sale de biblioteca', 'En Mantenimiento'))
);

CREATE TABLE prestamo(
	idPrestamo 				 CHAR(4) NOT NULL,
	idLector				 CHAR (4) NOT NULL,
    identificadorMaterial	 CHAR(4) NOT NULL,
	numEjem					 NUMBER(5) NOT NULL,
    fechaRealiza			 DATE NOT NULL,
	fechaVencimiento		 DATE NOT NULL,
	fechaDevolucion			 DATE,
	multa					 NUMBER(3,2),
	resello					 NUMBER(1), --num de veces prestado ese libro
	CONSTRAINT pk_prestamo PRIMARY KEY (idPrestamo),
	CONSTRAINT u_prestamo UNIQUE (idLector, identificadorMaterial, numEjem, fechaRealiza),
	CONSTRAINT fk_pres_lect FOREIGN KEY (idLector) REFERENCES LECTOR(idLector),
	CONSTRAINT fk_pres_mat FOREIGN KEY (identificadorMaterial, numEjem)
	REFERENCES EJEMPLAR(identificadorMaterial, numEjem)
);

DESCRIBE MATERIAL;
DESCRIBE AUTOR;
DESCRIBE DIRECTOR;
DESCRIBE TIPOLECTOR;
DESCRIBE LECTOR;
DESCRIBE MATAUTOR;
DESCRIBE LIBRO;
DESCRIBE TESIS;
DESCRIBE EJEMPLAR;
DESCRIBE PRESTAMO;