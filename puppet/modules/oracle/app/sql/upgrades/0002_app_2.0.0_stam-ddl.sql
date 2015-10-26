PROMPT ====================================================
PROMPT 
PROMPT Create table AANLEIDINGOORZAAK
PROMPT 
PROMPT ====================================================

CREATE TABLE aanleidingoorzaak 
(    aanleidingcode          		VARCHAR2(6)  							CONSTRAINT nn_aanleidingoorzaak_code NOT NULL
	,omschrijvinglang        		VARCHAR2(100 CHAR)
	,omschrijvingkort        		VARCHAR2(50 CHAR)
	,aanleiding              		VARCHAR2(100 CHAR)
	,begindatum              		DATE         							CONSTRAINT nn_aanleidingoorzaak_begindat NOT NULL
	,einddatum               		DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_AANLEIDINGOORZAAK primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE aanleidingoorzaak ADD (CONSTRAINT pk_aanleidingoorzaak PRIMARY KEY (aanleidingcode, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table AANLEIDINGOORZAAKINDEXWOORD
PROMPT 
PROMPT ====================================================

CREATE TABLE aanleidingoorzaakindexwoord 
(    aanleidingcode          		VARCHAR2(6)  							CONSTRAINT nn_aanloorzindexwoord_code NOT NULL
	,begindatum              		DATE         							CONSTRAINT nn_aanloorzindexwoord_begindat NOT NULL
	,volgorde                		NUMBER(20)   							CONSTRAINT nn_aanloorzindexwoord_volgorde NOT NULL
	,woord                   		VARCHAR2(30) 							CONSTRAINT nn_aanloorzindexwoord_woord NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_AANLEIDINGOORZAAKINDEXWOORD primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE aanleidingoorzaakindexwoord ADD (CONSTRAINT pk_aanleidingoorzaakindexwoord PRIMARY KEY (aanleidingcode, begindatum, volgorde) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_AANLOORZINDEXWOORD_AANLOORZ foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE aanleidingoorzaakindexwoord ADD CONSTRAINT fk_aanloorzindexwoord_aanloorz FOREIGN KEY (aanleidingcode, begindatum) REFERENCES aanleidingoorzaak (aanleidingcode, begindatum) ON DELETE CASCADE;


----------------------------------------------------------------------------------
        
		
PROMPT ====================================================
PROMPT 
PROMPT Create table VERKORTEROUTE
PROMPT 
PROMPT ====================================================

CREATE TABLE verkorteroute 
(    stationcode             		VARCHAR2(10)    						CONSTRAINT nn_verkorteroute_stationcode NOT NULL
	,vantreinnummer          		VARCHAR2(10)
	,tottreinnummer          		VARCHAR2(10)
	,evenindicator           		VARCHAR2(1)
	,geldigheidpersoortdag   		VARCHAR2(30)    						CONSTRAINT nn_verkorteroute_geldigheidper NOT NULL
	,station1                		VARCHAR2(6)
	,station2                		VARCHAR2(6)
	,station3                		VARCHAR2(6)
	,station4                		VARCHAR2(6)
	,eindbestemming          		VARCHAR2(6)
	,begindatum              		DATE            						CONSTRAINT nn_verkorteroute_begindatum NOT NULL
	,einddatum               		DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_VERKORTEROUTE primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE verkorteroute ADD (CONSTRAINT pk_verkorteroute PRIMARY KEY (stationcode, vantreinnummer, tottreinnummer, evenindicator, geldigheidpersoortdag, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table VERVOERDER
PROMPT 
PROMPT ====================================================

CREATE TABLE vervoerder 
(    code                    		VARCHAR2(10)    						CONSTRAINT nn_vervoerder_code NOT NULL
	,naam                    		VARCHAR2(50 CHAR)    					CONSTRAINT nn_vervoerder_naam NOT NULL
	,logo                    		CLOB
	,begindatum              		DATE            						CONSTRAINT nn_vervoerder_begindatum NOT NULL
	,einddatum               		DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_VERVOERDER primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE vervoerder ADD (CONSTRAINT pk_vervoerder PRIMARY KEY (code, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table SPOORCODE
PROMPT 
PROMPT ====================================================

CREATE TABLE spoorcode 
(    stationcode             		VARCHAR2(10)    						CONSTRAINT nn_spoorcode_stationcode NOT NULL
	,dienstregelpunt         		VARCHAR2(10)    						CONSTRAINT nn_spoorcode_dienstregelpunt NOT NULL
	,vptspoornummer          		VARCHAR2(10)    						CONSTRAINT nn_spoorcode_vptspoornummer NOT NULL
	,perronnummer            		NUMBER(5)
	,perronfasekort          		VARCHAR2(3)
	,perronfasemedium        		VARCHAR2(3)
	,perronfaselang          		VARCHAR2(3)
	,lengtemedium            		NUMBER(5)
	,lengtelang              		NUMBER(5)
	,begindatum              		DATE            						CONSTRAINT nn_spoorcode_begindatum NOT NULL
	,einddatum               		DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_SPOORCODE primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE spoorcode ADD (CONSTRAINT pk_spoorcode PRIMARY KEY (begindatum, stationcode, dienstregelpunt, vptspoornummer) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table DOORGAANDEVERBINDING
PROMPT 
PROMPT ====================================================

CREATE TABLE DOORGAANDEVERBINDING 
(    doorgndeverbdg    				VARCHAR(1000) 	CONSTRAINT nn_doorgndeverbdg NOT NULL
	,begindatum              		DATE         	CONSTRAINT nn_doorgndeverbdg_begindat NOT NULL
	,einddatum               		DATE
) 
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_DOORGAANDEVERBINDING primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE doorgaandeverbinding ADD (CONSTRAINT pk_doorgaandeverbinding PRIMARY KEY (begindatum, doorgndeverbdg) USING INDEX TABLESPACE &app_index_tablespace);
        
		
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TREINSOORT
PROMPT 
PROMPT ====================================================

CREATE TABLE treinsoort 
(    code            				VARCHAR2(10)    						CONSTRAINT nn_treinsoort_code NOT NULL
	,treinformule    				VARCHAR2(10)    						CONSTRAINT nn_treinsoort_treinformule NOT NULL
	,omschrijving    				VARCHAR2(30 CHAR)    
	,begindatum      				DATE            						CONSTRAINT nn_treinsoort_begindatum NOT NULL
	,einddatum       				DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_TREINSOORT primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE treinsoort ADD (CONSTRAINT pk_treinsoort PRIMARY KEY (code, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TREINSERIE
PROMPT 
PROMPT ====================================================
        
CREATE TABLE treinserie 
(    vantreinnummer          		NUMBER(12,0)    						CONSTRAINT nn_treinserie_vantreinnummer NOT NULL
	,tottreinnummer          		NUMBER(12,0)    						CONSTRAINT nn_treinserie_tottreinnummer NOT NULL
	,begindatum              		DATE            						CONSTRAINT nn_treinserie_begindatum NOT NULL
	,einddatum               		DATE
	,vervoerdercode          		VARCHAR2(10)    						CONSTRAINT nn_treinserie_vervoerdercode NOT NULL
	,lijnnummer              		VARCHAR2(10)
	,reserveren              		VARCHAR2(1)     						CONSTRAINT nn_treinserie_reserveren NOT NULL
	,toeslag                 		VARCHAR2(1)     						CONSTRAINT nn_treinserie_toeslag NOT NULL
	,speciaalkaartje         		VARCHAR2(1)     						CONSTRAINT nn_treinserie_speciaalkaartje NOT NULL
	,treinsoortcode          		VARCHAR2(20)    						CONSTRAINT nn_treinserie_treinsoortcode NOT NULL
	,treinnaam               		VARCHAR2(30 CHAR)    
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 
        
PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_TREINSERIE primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE treinserie ADD (CONSTRAINT pk_treinserie PRIMARY KEY (vantreinnummer, tottreinnummer, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table STOPMARKERING
PROMPT 
PROMPT ====================================================

CREATE TABLE stopmarkering 
(    station_code          			VARCHAR2(6)  							CONSTRAINT nn_smk_station_code NOT NULL
	,perronnummer            		NUMBER(5)								CONSTRAINT nn_smk_perron NOT NULL
	,begindatum              		DATE         							CONSTRAINT nn_smk_begindat NOT NULL
	,einddatum               		DATE
	,lichtseinazijde				NUMBER(5)
	,stootjukazijde					NUMBER(5)
	,lichtseinbfase					NUMBER(5)
	,lichtseinbzijde				NUMBER(5)
	,stootjukbzijde					NUMBER(5)
	,lichtseinafase					NUMBER(5)
	,perronlengte					NUMBER(5)  								CONSTRAINT nn_smk_lengte NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_STOPMARKERING primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE stopmarkering ADD (CONSTRAINT pk_stopmarkering PRIMARY KEY (station_code, perronnummer, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table STOPBORD
PROMPT 
PROMPT ====================================================

CREATE TABLE stopbord 
(    station_code          			VARCHAR2(6)  							CONSTRAINT nn_stb_station_code NOT NULL
	,perronnummer            		NUMBER(5)								CONSTRAINT nn_stb_perron NOT NULL
	,begindatum              		DATE         							CONSTRAINT nn_stb_begindat NOT NULL
	,richting						VARCHAR2(1)  							CONSTRAINT nn_stb_richting NOT NULL
	,cmTovAEinde               		NUMBER(5)  								CONSTRAINT nn_stb_cmtova NOT NULL
	,stoptype						VARCHAR2(1)  							CONSTRAINT nn_stb_stoptype NOT NULL
	,aantalBakken1					NUMBER(4)
	,aantalBakken2					NUMBER(4)
	,mLengte1						NUMBER(4)
	,mLengte2						NUMBER(4)
	,aantalBakken1On				NUMBER(4)
	,aantalBakken2On				NUMBER(4)
	,mLengte1Onder					NUMBER(4)
	,mLengte2Onder 					NUMBER(4)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_stopbord_AANLOORZ foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE stopbord ADD CONSTRAINT fk_stopbord_stopmarkering FOREIGN KEY (station_code, perronnummer, begindatum) REFERENCES stopmarkering (station_code, perronnummer, begindatum) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table STATION
PROMPT 
PROMPT ====================================================
        
CREATE TABLE station 
(    stationcode             		VARCHAR2(10)    						CONSTRAINT nn_station_stationcode NOT NULL
	,begindatum              		DATE            						CONSTRAINT nn_station_begindatum NOT NULL
	,einddatum               		DATE
	,typecode                		VARCHAR2(10)    						CONSTRAINT nn_station_typecode NOT NULL
	,kortenaam               		VARCHAR2(20 CHAR)    
	,middelnaam              		VARCHAR2(32 CHAR)    
	,langenaam               		VARCHAR2(50 CHAR)    
	,taalcodes               		VARCHAR2(100)   
	,uiccode                 		VARCHAR2(10)    
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_STATION primary key
PROMPT 
PROMPT ====================================================  

ALTER TABLE station ADD (CONSTRAINT pk_station PRIMARY KEY (stationcode, begindatum) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table INSTAPTIPBESTEMMING
PROMPT 
PROMPT ====================================================
        
CREATE TABLE instaptipbestemming 
(    stationcode             		VARCHAR2(10)    						CONSTRAINT nn_instaptipbestem_stationcode NOT NULL
	,begindatum              		DATE            						CONSTRAINT nn_instaptipbestem_begindatum NOT NULL
	,einddatum               		DATE
	,uitstapstation          		VARCHAR2(10)    						CONSTRAINT nn_instaptipbestem_uitstapstn NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_INSTAPTIPBESTEMMING primary key
PROMPT 
PROMPT ====================================================  

ALTER TABLE instaptipbestemming ADD (CONSTRAINT pk_instaptipbestemming PRIMARY KEY (stationcode, begindatum, uitstapstation) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_INSTAPTIPBESTEMMING foreign key
PROMPT 
PROMPT ====================================================  

ALTER TABLE instaptipbestemming ADD CONSTRAINT fk_instaptipbestemming FOREIGN KEY (stationcode, begindatum) REFERENCES station (stationcode, begindatum) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table OVERSTAPTIPBESTEMMING
PROMPT 
PROMPT ====================================================

CREATE TABLE overstaptipbestemming 
(    stationcode             		VARCHAR2(10)    						CONSTRAINT nn_overstaptipbest_stationcode NOT NULL
	,begindatum              		DATE            						CONSTRAINT nn_overstaptipbestem_begindat NOT NULL
	,einddatum               		DATE
	,bestemming              		VARCHAR2(10)    						CONSTRAINT nn_overstaptipbest_bestemming NOT NULL
	,overstapstation         		VARCHAR2(10)    						CONSTRAINT nn_overstaptipbest_overstapst NOT NULL
	,vantreinnummer          		VARCHAR2(10)    						CONSTRAINT nn_overstaptipbest_vantreinnum NOT NULL
	,tottreinnummer          		VARCHAR2(10)    						CONSTRAINT nn_overstaptipbest_tottreinnum NOT NULL
	,evenindicator           		VARCHAR2(1)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_OVERSTAPTIPBESTEMMING primary key
PROMPT 
PROMPT ====================================================          

ALTER TABLE overstaptipbestemming ADD (CONSTRAINT pk_overstaptipbestemming PRIMARY KEY (stationcode, begindatum, bestemming, overstapstation) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_OVERSTAPTIPBESTEMMING foreign key
PROMPT 
PROMPT ====================================================  

ALTER TABLE overstaptipbestemming ADD CONSTRAINT fk_overstaptipbestemming FOREIGN KEY (stationcode, begindatum) REFERENCES station (stationcode, begindatum) ON DELETE CASCADE;