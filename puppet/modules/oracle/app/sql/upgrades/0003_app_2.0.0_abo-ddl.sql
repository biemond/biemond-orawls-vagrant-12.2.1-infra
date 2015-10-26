PROMPT ====================================================
PROMPT 
PROMPT Create table ABONNEMENT
PROMPT 
PROMPT ====================================================

CREATE TABLE abonnement 
(    abonnementid               	NUMBER(10)    							CONSTRAINT nn_abonnement_abonnementid NOT NULL
	,afnemer                    	VARCHAR2(40 CHAR)  						CONSTRAINT nn_abonnement_afnemer NOT NULL
	,reisinformatieproduct      	VARCHAR2(40)  							CONSTRAINT nn_abonnement_reisinfproduct NOT NULL
	,locatielandelijkindicator  	VARCHAR2(10)  							
	,locatienietinstappen       	VARCHAR2(1)   			DEFAULT '1' 
	,metreset			       		VARCHAR2(1)   			DEFAULT '1' 
	,status                     	NUMBER(2)     							CONSTRAINT nn_abonnement_status NOT NULL
	,tijdvenster                	NUMBER(10)    							CONSTRAINT nn_abonnement_tijdvenster NOT NULL
	,laatsteverwerkingstijdstip		TIMESTAMP     							CONSTRAINT nn_abonnement_laatsteverwts NOT NULL
	,aanmeldtijdstip            	TIMESTAMP     							CONSTRAINT nn_abonnement_aanmeldtijdstip NOT NULL
	,verstuurdeberichten        	NUMBER(10)    							CONSTRAINT nn_abonnement_verstberichten NOT NULL
	,keepalivetimestamp		   		NUMBER(20,0)	 		DEFAULT '0' 
	,keepalivetimeouts		   		NUMBER(10,0)	 		DEFAULT '0' 
	,keepalivefails		   	   		NUMBER(10,0)	 		DEFAULT '0' 
	,queuenaam				   		VARCHAR2(40 CHAR)
    ,xsdversie						VARCHAR2(40 CHAR)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_ABONNEMENT_ABONNEMENTID primary key
PROMPT
PROMPT ====================================================

ALTER TABLE abonnement ADD (CONSTRAINT pk_abonnement_abonnementid PRIMARY KEY (abonnementid) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_ABONNEMENT
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_abonnement
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table LOCATIESTATION
PROMPT 
PROMPT ====================================================

CREATE TABLE locatiestation 
(    abonnementid        			NUMBER(10)    							CONSTRAINT nn_locatiestation_abonnement NOT NULL
	,stationcode         			VARCHAR2(10)    						CONSTRAINT nn_locatiestation_stationcode NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_LOCATIESTATION primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatiestation ADD (CONSTRAINT pk_locatiestation PRIMARY KEY (abonnementid , stationcode ) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_ABONNEMENT_LOCATIESTATION primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatiestation ADD CONSTRAINT fk_abo_locatiestation FOREIGN KEY (abonnementid) REFERENCES abonnement (abonnementid) ON DELETE CASCADE; 


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table LOCATIEVERVOERDER
PROMPT 
PROMPT ====================================================

CREATE TABLE LOCATIEVERVOERDER 
(    abonnementid        			NUMBER(10)    							CONSTRAINT nn_locver_abonnement NOT NULL
	,vervoerdercode         		VARCHAR2(10)    						CONSTRAINT nn_locver_vervoerdercode NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_LOCATIEVERVOERDER primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatievervoerder ADD (CONSTRAINT pk_locatievervoerder PRIMARY KEY (abonnementid , vervoerdercode ) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_ABONNEMENT_LOCATIEVERVOERDER foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatievervoerder ADD (CONSTRAINT fk_abo_locatiever FOREIGN KEY (abonnementid) REFERENCES abonnement (abonnementid) ON DELETE CASCADE);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table LOCATIETREINNUMMER
PROMPT 
PROMPT ====================================================

CREATE TABLE locatietreinnummer 
(    abonnementid        			NUMBER(10)    							CONSTRAINT nn_loctrn_abonnement NOT NULL
	,treinnummer         			VARCHAR2(10)    						CONSTRAINT nn_loctrn_treinnummer NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_LOCATIETREINNUMMER primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatietreinnummer ADD (CONSTRAINT pk_locatietreinnummer PRIMARY KEY (abonnementid , treinnummer ) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_ABONNEMENT_LOCATIETREINNUMMER foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE locatietreinnummer ADD CONSTRAINT fk_abo_locatietrn FOREIGN KEY (abonnementid) REFERENCES abonnement (abonnementid) ON DELETE CASCADE;