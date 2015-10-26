PROMPT ====================================================
PROMPT 
PROMPT Create table  RIT
PROMPT 
PROMPT ====================================================

CREATE TABLE rit 
(    id                     		NUMBER (20)   							CONSTRAINT nn_rit_id NOT NULL
	,geplandetreinnummer            NUMBER(12,0)    						CONSTRAINT nn_rit_geplandetreinnummer NOT NULL
	,treindatum                     DATE            						CONSTRAINT nn_rit_treindatum NOT NULL
	,ritbeeld                       VARCHAR2(35)
	,actueletreinnummer             NUMBER(12,0)    						CONSTRAINT nn_rit_actueletreinnummer NOT NULL
	,doorgaandeverbinding           VARCHAR2(38)
	,extratrein                     VARCHAR2(1)
	,routegewijzigd                 VARCHAR2(1)
	,treinvervallen                 VARCHAR2(1)
	,isverwerkt          			VARCHAR2(1) 			DEFAULT '0'
	,materieeltijd					TIMESTAMP 
	,routegewijzigdtijd				TIMESTAMP 								CONSTRAINT nn_rit_routegewijzigdtijd NOT NULL
	,laatstewijzigingstijd			TIMESTAMP
	,laatsteaanleidingcode       	VARCHAR2(6)
	,ingangsmoment					TIMESTAMP								CONSTRAINT nn_rit_ingangsmoment NOT NULL
	,transactieid                   NUMBER (20)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_RIT primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE rit ADD (CONSTRAINT pk_rit PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create unique index UK_RIT_NUMMER_DATUM on RIT(TREINDATUM,ACTUELETREINNUMMER)
PROMPT 
PROMPT ====================================================

CREATE UNIQUE INDEX uk_rit_nummer_datum ON rit (treindatum, actueletreinnummer) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RIT_ISVERWERKT on RIT(ISVERWERKT)
PROMPT 
PROMPT ====================================================

CREATE INDEX i_rit_isverwerkt ON rit (isverwerkt) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RIT_EXTRATREIN on RIT(EXTRATREIN)
PROMPT
PROMPT ====================================================

CREATE INDEX i_rit_extratrein ON rit (extratrein) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RIT_TREINNUMMER on RIT(ACTUELETREINNUMMER)
PROMPT
PROMPT ====================================================

CREATE INDEX i_rit_treinnummer ON rit (actueletreinnummer ASC) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RIT_TD_DVB on RIT(TREINDATUM, DOORGAANDEVERBINDING)
PROMPT
PROMPT ====================================================

CREATE INDEX i_rit_td_dvb ON rit (treindatum, doorgaandeverbinding) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_RIT
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_rit
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table RITSTATION
PROMPT
PROMPT ====================================================

CREATE TABLE ritstation 
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_ritstation_id NOT NULL
	,ritid		                	NUMBER (20)     						CONSTRAINT nn_ritstation_ritid NOT NULL
	,stationcode                    VARCHAR2(10)    						CONSTRAINT nn_ritstation_stationcode NOT NULL
	,geplandestationnementtype      VARCHAR2(1)								CONSTRAINT nn_ritstation_gepstationtype NOT NULL     
	,ingeplanderoute                VARCHAR2(1)								CONSTRAINT nn_ritstation_ingeplanderoute  NOT NULL
	,geplandevertrektijd            DATE
	,geplandevertrekrichting     	VARCHAR2(1)
	,geplandevertrekvptspoor        VARCHAR2(5)
	,geplandevertrekaltspoor        VARCHAR2(5)
	,geplandevertreklengte          NUMBER(6)				DEFAULT 0
	,geplandeaankomsttijd           DATE
	,geplandeaankomstrichting     	VARCHAR2(1)
	,geplandeaankomstvptspoor       VARCHAR2(5)
	,geplandeaankomstaltspoor       VARCHAR2(5)
	,geplandeaankomstlengte         NUMBER(6)				DEFAULT 0
	,geplandevolgorde               NUMBER (4)      						CONSTRAINT nn_ritstation_geplandevolgorde NOT NULL
	,actuelestationnementtype       VARCHAR2(1)     						CONSTRAINT nn_ritstation_actstationtype NOT NULL
	,inactueleroute                 VARCHAR2(1)								CONSTRAINT nn_ritstation_inactueleroute  NOT NULL
	,actuelevertrektijd             DATE
	,actuelevertrekrichting     	VARCHAR2(1)
	,actuelevertrekvptspoor         VARCHAR2(5)
	,actuelevertrekaltspoor         VARCHAR2(5)
	,actuelevertreklengte           NUMBER(6)				DEFAULT 0
	,actueleaankomsttijd            DATE
	,actueleaankomstrichting     	VARCHAR2(1)
	,actueleaankomstvptspoor        VARCHAR2(5)
	,actueleaankomstaltspoor        VARCHAR2(5)
	,actueleaankomstlengte          NUMBER(6)				DEFAULT 0
	,actuelevertreksporentijd		TIMESTAMP 								CONSTRAINT nn_ritstation_act_vsporentijd NOT NULL
	,actueleaankomstsporentijd		TIMESTAMP 								CONSTRAINT nn_ritstation_act_asporentijd NOT NULL
	,actuelevertrektijdtijd			TIMESTAMP 								CONSTRAINT nn_ritstation_act_vtijdtijd NOT NULL
	,actueleaankomsttijdtijd		TIMESTAMP 								CONSTRAINT nn_ritstation_act_atijdtijd NOT NULL
	,actuelevolgorde                NUMBER (4)      						CONSTRAINT nn_ritstation_actuelevolgorde NOT NULL
	,treinstatus                    NUMBER(1)
	,treinstatustijd                DATE
	,vertragingsbron        		VARCHAR2(10)
	,vertragingsmoment     			VARCHAR2(1)
	,vertragingssoort     			VARCHAR2(1)
	,laatstewijzigingstijd			TIMESTAMP
	,laatsteinputtype				NUMBER(2)
	,modificatietype				NUMBER(2)
	,aanleidingscode      			VARCHAR2(10) 	
	,isgeplandeeindbestemming		VARCHAR2(1) 			DEFAULT '0'	
	,isgeplandeherkomst				VARCHAR2(1) 			DEFAULT '0'
	,isactueleeindbestemming		VARCHAR2(1) 			DEFAULT '0'
	,isactueleherkomst				VARCHAR2(1) 			DEFAULT '0'
	,ritbeeldtype					VARCHAR2(1) 			DEFAULT '1'
	,vertrekvertraging				NUMBER(10) 				DEFAULT '0'
	,aankomstvertraging				NUMBER(10) 				DEFAULT '0'
	,gelijkritbeeld         		VARCHAR2(1) 			DEFAULT '1'
	,aankomstgefixeerd         		VARCHAR2(1)
	,vertrekgefixeerd         		VARCHAR2(1)
	,geplandeknooppunttype			VARCHAR2(1)
	,actueleknooppunttype			VARCHAR2(1)
	,geplanderitbeeldstation		VARCHAR2(10)
	,actueleritbeeldstation			VARCHAR2(10)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 


PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_RITSTATION primary key
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation ADD (CONSTRAINT pk_ritstation PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_RIT_RITSTATION foreign key
PROMPT
PROMPT ====================================================
        
ALTER TABLE ritstation ADD CONSTRAINT fk_rit_ritstation FOREIGN KEY (ritid) REFERENCES rit (id) ON DELETE CASCADE;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_STATIONCODE on RITSTATION(STATIONCODE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_stationcode ON ritstation (stationcode) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_ACTVERTREKTIJD on RITSTATION(ACTUELEVERTREKTIJD)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_actvertrektijd ON ritstation (actuelevertrektijd) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_RITID on RITSTATION(RITID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_ritid ON ritstation (ritid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_PLANVERTREKTIJD on RITSTATION(GEPLANDEVERTREKTIJD)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_planvertrektijd ON ritstation (geplandevertrektijd ASC) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_PLANAANKOMSTTIJD on RITSTATION(GEPLANDEAANKOMSTTIJD)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_planaankomsttijd ON ritstation (geplandeaankomsttijd ASC) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_ACTROUTE on RITSTATION(INACTUELEROUTE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_actroute ON ritstation (inactueleroute ASC) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_PLANROUTE on RITSTATION(INGEPLANDEROUTE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_planroute ON ritstation (ingeplanderoute asc) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_ACTSTATTYPE on RITSTATION(ACTUELESTATIONNEMENTTYPE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_actstattype ON ritstation (actuelestationnementtype ASC) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RITSTATION_ACTUEEL on RITSTATION(ACTUEEL)
PROMPT
PROMPT ====================================================

CREATE INDEX i_ritstation_actueel ON ritstation (ritbeeldtype ASC) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_RITSTATION
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_ritstation
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TRAJECTDEEL
PROMPT
PROMPT ====================================================

CREATE TABLE trajectdeel
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_trajectdeel_id NOT NULL
	,ritid							NUMBER(20)								CONSTRAINT nn_trajectdeel_rit_id NOT NULL																			
	,trajectcode					VARCHAR2(38)							CONSTRAINT nn_trajectdeel_trajectcode NOT NULL
	,trajecttype  					VARCHAR2(10)	    						
	,hkebisknoop					VARCHAR2(1)								
	,geplandevolgendetrajectdeelid  NUMBER(20)	    						
	,actuelevolgendetrajectdeelid	NUMBER(20)								
	,geplandeeersteritstationid		NUMBER(20)								
	,actueleeersteritstationid		NUMBER(20)								
	,geplandelaatsteritstationid	NUMBER(20)								
	,actuelelaatsteritstationid		NUMBER(20)								
	,geplandevolgenderitid			NUMBER(20)								
	,actuelevolgenderitid			NUMBER(20)								
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_TRAJECTDEEL primary key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD (CONSTRAINT pk_trajectdeel PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_RIT_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_rit_id FOREIGN KEY (ritid) REFERENCES rit (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_GEP_VOLGENDE_TD_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_gep_volgende_td_id FOREIGN KEY (geplandevolgendetrajectdeelid) REFERENCES trajectdeel (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_ACT_VOLGENDE_TD_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_act_volgende_td_id FOREIGN KEY (actuelevolgendetrajectdeelid) REFERENCES trajectdeel (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_GEP_EERSTE_RS_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_gep_eerste_rs_id FOREIGN KEY (geplandeeersteritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_GEP_LAATSTE_RS_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_gep_laatste_rs_id FOREIGN KEY (geplandelaatsteritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_ACT_EERSTE_RS_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_act_eerste_rs_id FOREIGN KEY (actueleeersteritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_ACT_LAATSTE_RS_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_act_laatste_rs_id FOREIGN KEY (actuelelaatsteritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_GEP_VOLGENDE_RIT_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_gep_volgend_rit_id FOREIGN KEY (geplandevolgenderitid) REFERENCES rit (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TD_ACT_VOLGEND_RIT_ID foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT fk_td_act_volgend_rit_id FOREIGN KEY (actuelevolgenderitid) REFERENCES rit (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint UN_TD_RITID_TRAJECTCODE foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE trajectdeel ADD CONSTRAINT un_td_ritid_trajectcode UNIQUE (ritid, trajectcode);

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECT_RITID on TRAJECTDEEL(RITID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_traject_ritid ON trajectdeel(ritid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_GEPVTDID on TRAJECTDEEL(GEPLANDEVOLGENDETRAJECTDEELID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_gepvtdid ON trajectdeel(geplandevolgendetrajectdeelid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_ACTVTDID on TRAJECTDEEL(ACTUELEVOLGENDETRAJECTDEELID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_actvtdid ON trajectdeel(actuelevolgendetrajectdeelid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_GEPERSID on TRAJECTDEEL(GEPLANDEEERSTERITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_gepersid ON trajectdeel(geplandeeersteritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_ACTERSID on TRAJECTDEEL(ACTUELEEERSTERITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_actersid ON trajectdeel(actueleeersteritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_GEPLRSID on TRAJECTDEEL(GEPLANDELAATSTERITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_geplrsid ON trajectdeel(geplandelaatsteritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_ACTLRSID on TRAJECTDEEL(ACTUELELAATSTERITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_actlrsid ON trajectdeel(actuelelaatsteritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_GEPVRID on TRAJECTDEEL(GEPLANDEVOLGENDERITID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_gepvrid ON trajectdeel(geplandevolgenderitid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_TRAJECTDEEL_ACTVRID on TRAJECTDEEL(ACTUELEVOLGENDERITID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_trajectdeel_actvrid ON trajectdeel(actuelevolgenderitid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_TRAJECTDEEL
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_trajectdeel
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table REISTIP
PROMPT
PROMPT ====================================================

CREATE TABLE reistip	
(	 id								NUMBER(20)								CONSTRAINT nn_reistip_id NOT NULL	 
	,ritstationid   				NUMBER(20)     							CONSTRAINT nn_reistip_ritstationid NOT NULL
	,volgorde	     				NUMBER(20)  			DEFAULT 0		CONSTRAINT nn_reistip_volgorde NOT NULL
	,trajectcode					VARCHAR2(38)							CONSTRAINT nn_reistip_trajectcode NOT NULL
	,reistipcode					VARCHAR2(6)								CONSTRAINT nn_reistip_reistipcode NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_REISTIP primary key
PROMPT
PROMPT ====================================================

ALTER TABLE reistip ADD (CONSTRAINT pk_reistip PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_REISTIP_RS foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE reistip ADD CONSTRAINT fk_reistip_rs FOREIGN KEY (ritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_REISTIP_RSID on REISTIP(RITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_reistip_rsid ON reistip(ritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_REISTIP
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_reistip
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table REISTIPSTATION
PROMPT
PROMPT ====================================================

CREATE TABLE reistipstation
(	 reistipid 	            		NUMBER(20)   							CONSTRAINT nn_rts_rt_id NOT NULL
	,stationcode			        VARCHAR2(10)	    					CONSTRAINT nn_rts_stationcode NOT NULL
	,volgorde						NUMBER(4)				DEFAULT 0  		CONSTRAINT nn_rts_volgorde NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_REISTIPSSTATION_RT foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE reistipstation ADD CONSTRAINT fk_reistipstation_rt FOREIGN KEY (reistipid) REFERENCES reistip (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_REISTIPSTATION_RTID on REISTIPSTATION(REISTIPID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_reistipstation_rtid ON reistipstation(reistipid) TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table RITBERICHTCORRELATIE
PROMPT
PROMPT ====================================================

CREATE TABLE ritberichtcorrelatie 
(	 treindatum                  	DATE            						CONSTRAINT nn_rbc_treindatum NOT NULL
	,geplandetreinnummer         	NUMBER(12)	    						CONSTRAINT nn_rbc_geplandetreinnummer NOT NULL
	,stationcode                 	VARCHAR2(10)
	,laatstewijzigingstijd			TIMESTAMP								CONSTRAINT nn_rbc_laatstewijzigingstijd NOT NULL
	,berichtcorrelatie           	VARCHAR2(25)    						CONSTRAINT nn_rbc_berichtcorrelatie NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RBC_RITBEELD on RITBERICHTCORRELATIE(TREINDATUM,GEPLANDETREINNUMMER)
PROMPT
PROMPT ====================================================

CREATE INDEX i_rbc_ritbeeld ON ritberichtcorrelatie(treindatum, geplandetreinnummer) TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table VJPTRANSACTIE
PROMPT
PROMPT ====================================================

CREATE TABLE vjptransactie 
(    transactieid        			NUMBER(20) 								CONSTRAINT nn_vjpt_transactieid NOT NULL
	,treindatum          			DATE 									CONSTRAINT nn_vjpt_treindatum NOT NULL
	,verwerkingstarttijd 			TIMESTAMP 								CONSTRAINT nn_vjpt_verwerkingstarttijd NOT NULL
	,verwerkingeindtijd  			TIMESTAMP
	,aantalritten        			NUMBER(20)
	,transactiesoort     			VARCHAR2(20)
	,verwerkingstatus    			VARCHAR2(20)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_VJPTRANSACTIE primary key
PROMPT
PROMPT ====================================================

ALTER TABLE vjptransactie ADD (CONSTRAINT pk_vjptransactie PRIMARY KEY (transactieid) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_VJPTRANSACTIE
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_vjptransactie
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table RANGEERACTIVITEIT
PROMPT
PROMPT ====================================================

CREATE TABLE rangeeractiviteit 
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_rangeeract_id NOT NULL
	,treinnummer             		NUMBER(12,0)    						CONSTRAINT nn_rangeeract_treinnr NOT NULL
	,treindatum              		DATE            						CONSTRAINT nn_rangreeact_treindatum NOT NULL
	,dienstregelpunt         		VARCHAR2(10)    						CONSTRAINT nn_rangeeract_dienstregelpunt NOT NULL
	,vervoerdercode          		VARCHAR2(10)
	,geplandeaankomsttijd           DATE
	,geplandeaankomstvptspoor       VARCHAR2(5)
	,geplandeaankomstvptspooralT    VARCHAR2(5)
	,geplandevertrektijd            DATE
	,geplandevertrekvptspoor        VARCHAR2(5)
	,geplandevertrekvptspooralt     VARCHAR2(5)
	,geplandeinroute                VARCHAR2(1)      		DEFAULT '0'
	,actueleaankomsttijd            DATE
	,actueleaankomstvptspoor        VARCHAR2(5)
	,actueleaankomstvptspooralt     VARCHAR2(5)
	,actuelevertrektijd             DATE
	,actuelevertrekvptspoor         VARCHAR2(5)
	,actuelevertrekvptspooralt      VARCHAR2(5)
	,actueleinroute                 VARCHAR2(1)      		DEFAULT '0'
	,aankomstvertraging				NUMBER(10) 		 		DEFAULT 0
	,aankomstvptspoorgefixeerd      VARCHAR2(1)      		DEFAULT '0'
	,vertrekvertraging				NUMBER(10) 		 		DEFAULT 0
	,vertrekvptspoorgefixeerd       VARCHAR2(1)      		DEFAULT '0'
	,status                     	NUMBER(1)
	,statustijd                 	DATE
	,wijzigingaanleiding			VARCHAR2(10)  
	,actueletijdentijd				DATE
	,actuelesporentijd				DATE
	,laatsteinputtype				NUMBER(2) 								CONSTRAINT nn_rangeeract_linputtype NOT NULL
	,laatstewijzigingstijd			DATE
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_RANGEERACTIVITEIT primary key
PROMPT
PROMPT ====================================================

ALTER TABLE rangeeractiviteit ADD (CONSTRAINT pk_rangeeractiviteit PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create unique index I_RANGEERACTIVITEIT_TD_TNR_DRP on RANGEERACTIVITEIT (TREINNUMMER, TREINDATUM, DIENSTREGELPUNT)
PROMPT
PROMPT ====================================================

CREATE UNIQUE INDEX i_rangeeractiviteit_td_tnr_drp ON rangeeractiviteit (treinnummer, treindatum, dienstregelpunt) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RANGEERACTIVITEIT_PLANVT on RANGEERACTIVITEIT(GEPLANDEVERTREKTIJD) 
PROMPT
PROMPT ====================================================

CREATE INDEX i_rangeeractiviteit_planvt ON rangeeractiviteit (geplandevertrektijd ASC) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_RANGEERACTIVITEIT
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_rangeeractiviteit
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table MATERIEELRELATIEKOP
PROMPT
PROMPT ====================================================

CREATE TABLE materieelrelatiekop 
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_materieelrelatiekop_id NOT NULL
	,nummer             			NUMBER(12,0)    						CONSTRAINT nn_materieelrelatiekop_nr NOT NULL
	,materieelrelatiedatuM   		DATE            						CONSTRAINT nn_materieelrelatiekop_mrd NOT NULL
	,dienstregelpunt         		VARCHAR2(10)    						CONSTRAINT nn_materieelrelatiekop_drp NOT NULL
	,wijzigingaanleiding			VARCHAR2(10)  
	,laatsteinputtype				NUMBER(2)
	,laatstewijzigingstijD			DATE	
	,isactueel						VARCHAR2(1)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_MATERIEELRELATIEKOP primary key
PROMPT
PROMPT ====================================================

ALTER TABLE materieelrelatiekop ADD (CONSTRAINT pk_materieelrelatiekop PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create unique index I_MAT_REL_KOP_NR_DT_DRP on MATERIEELRELATIEKOP(NUMMER,MATERIEELRELATIEDATUM,DIENSTREGELPUNT)
PROMPT
PROMPT ====================================================

CREATE UNIQUE INDEX i_mat_rel_kop_nr_dt_drp ON materieelrelatiekop (nummer, materieelrelatiedatum, dienstregelpunt) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_MATERIEELRELATIEKOP
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_materieelrelatiekop
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table MATERIEELRELATIEREGEL
PROMPT
PROMPT ====================================================

CREATE TABLE materieelrelatieregel
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_materieelrelatieregel_id NOT NULL
	,kopid							NUMBER(20)								CONSTRAINT nn_materieelrelatieregel_kopid NOT NULL
	,treinnummer             		NUMBER(12,0)    						CONSTRAINT nn_materieelrelatieregel_trnr NOT NULL
	,treindatum              		DATE            						CONSTRAINT nn_materieelrelatieregel_trdt NOT NULL
	,relatietype					VARCHAR2(1)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;
 
PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_MATERIEELRELATIEREGEL primary key
PROMPT
PROMPT ====================================================

ALTER TABLE materieelrelatieregel ADD (CONSTRAINT pk_materieelrelatieregel PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_MATERIEELRELATIEKOP foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE materieelrelatieregel ADD CONSTRAINT fk_materieelrelatiekop FOREIGN KEY (kopid) REFERENCES materieelrelatiekop (id) ON DELETE CASCADE;

PROMPT ====================================================
PROMPT 
PROMPT Create unique index I_MATERIEELRELATIEREGEL_UN1 on MATERIEELRELATIEREGEL(TREINNUMMER,TREINDATUM,RELATIETYPE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_materieelrelatieregel_un1 ON materieelrelatieregel (treinnummer, treindatum, relatietype) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_MATERIEELRELATIEREGEL_KOPID on MATERIEELRELATIEREGEL(KOPID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_materieelrelatieregel_kopid ON materieelrelatieregel (kopid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_MATERIEELRELATIEREGEL
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_materieelrelatieregel
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

----------------------------------------------------------------------------------

PROMPT ====================================================
PROMPT 
PROMPT Create table MATERIEELDEELROUTE
PROMPT
PROMPT ====================================================

CREATE TABLE materieeldeelroute 
(	 id                      		NUMBER(20)      						CONSTRAINT nn_mdroute_id NOT NULL
	,eersteritstationid      		NUMBER(20)      						CONSTRAINT nn_mdroute_eerstestationid NOT NULL
	,dienstgroep             		VARCHAR2(10)    
	,dienstgroepvolgnr       		NUMBER(4)       
	,aktiviteitvolgnr        		NUMBER(4)       
	,dienstgroeppositie      		NUMBER(4)       						CONSTRAINT nn_mdroute_dienstgrppositie NOT NULL
	,materieeldeellengte   			NUMBER(6)       						CONSTRAINT nn_mdroute_materieeldeellengte NOT NULL
	,materieeldeelpositie   		NUMBER(7)       
	,materieelsoort          		VARCHAR2(10)    						CONSTRAINT nn_mdroute_materieelsoort NOT NULL
	,materieelaanduiding     		VARCHAR2(10)    						CONSTRAINT nn_mdroute_materieelaand NOT NULL
	,materieelnummer    			VARCHAR2(17)			
	,laatsteritstationid     		NUMBER(20)      
	,inroute                 		VARCHAR2(1)
	,isgepland               		VARCHAR2(1)
	,capaciteitzitplaats			NUMBER(4)				DEFAULT 0    
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_MATERIEELDEELROUTE_ID primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE materieeldeelroute ADD (CONSTRAINT pk_materieeldeelroute_id PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_RITSTATION_MDROUTE foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE materieeldeelroute ADD CONSTRAINT fk_eerste_mdroute FOREIGN KEY (eersteritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_LAATSTE_MDROUTE foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE materieeldeelroute ADD CONSTRAINT fk_laatste_mdroute FOREIGN KEY (laatsteritstationid) REFERENCES ritstation (id);

PROMPT ====================================================
PROMPT 
PROMPT Create index I_MDROUTE_MATERIEEL on MATERIEELDEELROUTE(MATERIEELNUMMER, AKTIVITEITVOLGNR) 
PROMPT 
PROMPT ====================================================

CREATE INDEX i_mdroute_materieel ON materieeldeelroute (materieelnummer, aktiviteitvolgnr) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index I_MDROUTE_DIENSTGROEP on MATERIEELDEELROUTE(DIENSTGROEP, DIENSTGROEPVOLGNR) 
PROMPT 
PROMPT ====================================================

CREATE INDEX i_mdroute_dienstgroep ON materieeldeelroute (dienstgroep, dienstgroepvolgnr) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_MDROUTE_STOP_POS on MATERIEELDEELROUTE(EERSTERITSTATIONID, DIENSTGROEPPOSITIE) 
PROMPT 
PROMPT ====================================================

CREATE INDEX i_mdroute_stop_pos ON materieeldeelroute (eersteritstationid, dienstgroeppositie) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_MDROUTE_LTSTERTSTID on MATERIEELDEELROUTE(LAATSTERITSTATIONID) 
PROMPT 
PROMPT ====================================================

CREATE INDEX i_mdroute_ltstertstid ON materieeldeelroute (laatsteritstationid) TABLESPACE &app_index_tablespace; 

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_MATERIEELDEELROUTE
PROMPT 
PROMPT ====================================================

CREATE SEQUENCE seq_materieeldeelroute
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
    CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table RITSTATION_VERKORTEROUTE
PROMPT
PROMPT ====================================================

CREATE TABLE ritstation_verkorteroute
(	 id 	                     	NUMBER(20)   							CONSTRAINT nn_vk_id NOT NULL
	,ritstationid	        		NUMBER(20)	    						CONSTRAINT nn_vk_rs_id NOT NULL
	,isgepland						NUMBER(1)				DEFAULT 0		CONSTRAINT nn_vk_isgepland NOT NULL
																			CONSTRAINT ck_vk_isgepland CHECK (isgepland IN (0,1))	
	,type							VARCHAR2(3)								CONSTRAINT nn_vk_type NOT NULL
																			CONSTRAINT ck_vk_type CHECK (type IN ('EB', 'HK'))
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_RITSTATION_VERKORTEROUTE primary key
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation_verkorteroute ADD (CONSTRAINT pk_ritstation_verkorteroute PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_RS_VERKORTEROUTE_RS foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation_verkorteroute ADD CONSTRAINT fk_rs_verkorteroute_rs FOREIGN KEY (ritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_RS_VERKORTEROUTE_RSID on RITSTATION_VERKORTEROUTE(RITSTATIONID);
PROMPT
PROMPT ====================================================

CREATE INDEX i_rs_verkorteroute_rsid ON ritstation_verkorteroute(ritstationid) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_VERKORTEROUTE
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_verkorteroute
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

----------------------------------------------------------------------------------

PROMPT ====================================================
PROMPT 
PROMPT Create table VERKORTEROUTESTATION
PROMPT
PROMPT ====================================================

CREATE TABLE verkorteroutestation
(	 ritstation_vrid 	            	NUMBER(20)   							CONSTRAINT nn_vks_lvk_id NOT NULL
	,stationcode			        VARCHAR2(10)	    					CONSTRAINT nn_vks_stationcode NOT NULL
	,volgorde						NUMBER(4)				DEFAULT 0  		CONSTRAINT nn_vks_volgorde NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_VERKORTEROUTESTATION_VR foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE verkorteroutestation ADD CONSTRAINT fk_verkorteroutestation_vr FOREIGN KEY (ritstation_vrid) REFERENCES ritstation_verkorteroute (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_VERKORTEROUTESTATION_LVR_ID on VERKORTEROUTESTATION(ritstation_vrid)
PROMPT
PROMPT ====================================================

CREATE INDEX i_verkorteroutestation_rsvr_id ON verkorteroutestation(ritstation_vrid) TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table OVERSTAPTIP
PROMPT 
PROMPT ====================================================

CREATE TABLE overstaptip 
(	 id                      		NUMBER(20)      						CONSTRAINT nn_overstaptip_int NOT NULL
	,overstapbestemming      		VARCHAR2(10)    						CONSTRAINT nn_overstaptip_overstapbestem NOT NULL
	,actief                  		VARCHAR2(1)     		DEFAULT 'N' 	CONSTRAINT ck_overstaptip_actieve CHECK (actief IN ('J','N'))
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_OVERSTAPTIP primary key
PROMPT
PROMPT ====================================================

ALTER TABLE overstaptip ADD (CONSTRAINT pk_overstaptip PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_OVERSTAPTIP
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_overstaptip
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table OVERSTAPTIPTORIT
PROMPT
PROMPT ====================================================

CREATE TABLE overstaptiptorit 
(	 overstaptipid           		NUMBER(20)      						CONSTRAINT nn_overstaptiptorit_id NOT NULL
	,ritstationrol					VARCHAR2(1)     						CONSTRAINT nn_overstaptiptorit_rol NOT NULL
	,ritstationid   				NUMBER(20)    							CONSTRAINT nn_overstaptiptorit_rsid NOT NULL	    		
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_OVERSTAPTIPTORIT primary key
PROMPT
PROMPT ====================================================

ALTER TABLE overstaptiptorit ADD (CONSTRAINT pk_overstaptiptorit PRIMARY KEY (overstaptipid , ritstationrol) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_OVERSTAPTIPTORIT_RS foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE overstaptiptorit ADD CONSTRAINT fk_overstaptiptorit_rs FOREIGN KEY (ritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TIP_OVERSTAPTIPTORIT foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE overstaptiptorit ADD CONSTRAINT fk_tip_overstaptiptorit FOREIGN KEY (overstaptipid) REFERENCES overstaptip (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_OVERSTAPTIPTORIT on OVERSTAPTIPTORIT(RITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_overstaptiptorit ON overstaptiptorit (ritstationid) TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------

        
PROMPT ====================================================
PROMPT 
PROMPT Create table INSTAPTIP
PROMPT
PROMPT ====================================================

CREATE TABLE INSTAPTIP 
(	 id                      		NUMBER(20)      						CONSTRAINT nn_instaptip_int NOT NULL
	,tipbestemming           		VARCHAR2(10)    						CONSTRAINT nn_instaptip_tipbestemming NOT NULL
	,actief                  		VARCHAR2(1)     DEFAULT 'N' 			CONSTRAINT ck_instaptip_actieve CHECK (actief IN ('J','N'))
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT Add constraint PK_INSTAPTIP primary key
PROMPT

ALTER TABLE instaptip ADD (CONSTRAINT pk_instaptip PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_INSTAPTIP
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_instaptip
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT Create table INSTAPTIPTORIT
PROMPT 

CREATE TABLE INSTAPTIPTORIT 
(	 instaptipid           			NUMBER(20)      						CONSTRAINT nn_instaptiptorit_id NOT NULL
	,ritstationrol					VARCHAR2(1)     						CONSTRAINT nn_instaptiptorit_rol NOT NULL
	,ritstationid   				NUMBER(20)    							CONSTRAINT nn_instaptiptorit_rsid NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_INSTAPTIPTORIT primary key
PROMPT
PROMPT ====================================================

ALTER TABLE instaptiptorit ADD (CONSTRAINT pk_instaptiptorit PRIMARY KEY (instaptipid, ritstationrol) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_INSTAPTIPTORIT_RS foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE instaptiptorit ADD CONSTRAINT fk_instaptiptorit_rs FOREIGN KEY (ritstationid) REFERENCES ritstation (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TIP_INSTAPTIPTORIT foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE instaptiptorit ADD CONSTRAINT fk_tip_instaptiptorit FOREIGN KEY (instaptipid) REFERENCES instaptip (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_INSTAPTIPTORIT on INSTAPTIPTORIT(RITSTATIONID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_instaptiptorit ON instaptiptorit (ritstationid) TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TVVTRANSACTIE
PROMPT
PROMPT ====================================================

CREATE TABLE tvvtransactie (
	 transactieid        			NUMBER(20) 
	,treindatum          			DATE 									CONSTRAINT nn_tvvt_treindatum NOT NULL
	,verwerkingstarttijd 			TIMESTAMP 								CONSTRAINT nn_tvvt_verwerkingstarttijd NOT NULL
	,verwerkingeindtijd  			TIMESTAMP
	,aantalritten        			NUMBER(20)
	,transactiesoort     			VARCHAR2(20)
	,verwerkingstatus    			VARCHAR2(20)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_TVVTRANSACTIE primary key
PROMPT
PROMPT ====================================================

ALTER TABLE tvvtransactie ADD CONSTRAINT pk_tvvtransactie PRIMARY KEY (transactieid) USING INDEX TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_TVVTRANSACTIE
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_tvvtransactie
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TVVRIT
PROMPT
PROMPT ====================================================

CREATE TABLE tvvrit 
(  	 id							NUMBER(20) 
	,tvvdatum					DATE 										CONSTRAINT nn_tvvrit_tvvdatum NOT NULL
	,tvvsoort					VARCHAR2(3)
	,transactieid				NUMBER(20) 									CONSTRAINT nn_tvvrit_transid NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_TVVRIT primary key
PROMPT
PROMPT ====================================================

ALTER TABLE tvvrit ADD CONSTRAINT pk_tvvrit PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_TVVTRANSACTIE_TVVRIT foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE tvvrit ADD CONSTRAINT fk_tvvtransactie_tvvrit FOREIGN KEY (transactieid) REFERENCES tvvtransactie(transactieid) ON DELETE CASCADE;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_TVVRIT
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_tvvrit
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TVVSTOP
PROMPT
PROMPT ====================================================

CREATE TABLE tvvstop 
(
	 tvvritid						NUMBER(20) 								CONSTRAINT nn_tvvstop_tvvritid NOT NULL
	,dienstregelpunt				VARCHAR2(6) 							CONSTRAINT nn_tvvstop_drp NOT NULL
	,aankomsttijd					TIMESTAMP
	,vertrektijd					TIMESTAMP
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint fk_tvvrit_tvvstop foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE tvvstop ADD CONSTRAINT fk_tvvrit_tvvstop FOREIGN KEY (tvvritid) REFERENCES tvvrit(id) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table PATROONINFO
PROMPT
PROMPT ====================================================

CREATE TABLE patrooninfo
(  	 id                             NUMBER(20)      						CONSTRAINT nn_patrooninfo_id NOT NULL
	,begintijd                    	TIMESTAMP
	,eindtijd                    	TIMESTAMP
	,stationcode                    VARCHAR2(10)    						CONSTRAINT nn_patrooninfo_stationcode NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint PK_PATROONINFO primary key
PROMPT
PROMPT ====================================================

ALTER TABLE patrooninfo ADD (CONSTRAINT pk_patrooninfo PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create index I_PATROONINFO on PATROONINFO(BEGINTIJD,EINDTIJD,STATIONCODE)
PROMPT
PROMPT ====================================================

CREATE INDEX i_patrooninfo ON patrooninfo (begintijd, eindtijd, stationcode) TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_PATROONINFO
PROMPT
PROMPT ====================================================

CREATE SEQUENCE seq_patrooninfo
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	CYCLE;

	
----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table PATROONINFOREGEL
PROMPT
PROMPT ====================================================

CREATE TABLE patrooninforegel
(  	 patrooninfoid                  NUMBER(20)      						CONSTRAINT nn_patrooninforegel_int NOT NULL
	,regelnummer                    NUMBER(2)
	,tekst                    		VARCHAR2(120)
) 
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraint FK_RITSTATION_OVERSTAPTIP foreign key
PROMPT
PROMPT ====================================================

ALTER TABLE patrooninforegel ADD CONSTRAINT fk_patrooninfo_regel FOREIGN KEY (patrooninfoid) REFERENCES patrooninfo (id) ON DELETE CASCADE; 

PROMPT ====================================================
PROMPT 
PROMPT Create index I_PATROONINFOREGEL on PATROONINFOREGEL(PATROONINFOID)
PROMPT
PROMPT ====================================================

CREATE INDEX i_patrooninforegel ON patrooninforegel (patrooninfoid) TABLESPACE &app_index_tablespace;