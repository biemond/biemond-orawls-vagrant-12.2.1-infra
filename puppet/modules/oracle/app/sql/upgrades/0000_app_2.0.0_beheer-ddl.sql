PROMPT ====================================================
PROMPT 
PROMPT Create table CONFIG
PROMPT 
PROMPT ====================================================

CREATE TABLE config 
(    paramname       				VARCHAR2(60) 							CONSTRAINT paramname_nn NOT NULL
	,paramvalue						VARCHAR2(500) 							CONSTRAINT paramvalue_nn NOT NULL
	,module  						VARCHAR(10) 							CONSTRAINT module_nn NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraing PK_CONFIG primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE config ADD (CONSTRAINT pk_config PRIMARY KEY (paramname, module) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table PASSWORDPOLICY
PROMPT 
PROMPT ====================================================

CREATE TABLE passwordpolicy 
(    policyid      					VARCHAR2(20) 							CONSTRAINT nn_policy_id NOT NULL
	,policy   						VARCHAR2(40)							CONSTRAINT nn_policy NOT NULL
	,description   					VARCHAR2(100)							CONSTRAINT nn_policy_description NOT NULL
	,histsize						NUMBER									CONSTRAINT nn_policy_histsize NOT NULL
	,nrattempts						NUMBER									CONSTRAINT nn_policy_nrattempts NOT NULL
	,disabledtime					NUMBER									CONSTRAINT nn_policy_disabledtime NOT NULL			
	,active							NUMBER(1)								CONSTRAINT nn_policy_active NOT NULL			
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraing PK_POLICY_ID primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE passwordpolicy ADD (CONSTRAINT pk_policy_id PRIMARY KEY (policyid) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table USERS
PROMPT 
PROMPT ====================================================

CREATE TABLE users 
(    username      					VARCHAR2(20 CHAR) 						CONSTRAINT usr_usrnm_nn NOT NULL
	,password   					VARCHAR2(250 CHAR)						CONSTRAINT usr_psswrd_nn NOT NULL
	,inlogpoging					NUMBER									CONSTRAINT usr_nlgpgng_nn NOT NULL
	,blokkering						NUMBER									CONSTRAINT usr_blkkrng_check CHECK(blokkering IN(0,1,2)) 
																			CONSTRAINT usr_blkkrng_nn NOT NULL
	,bloktijdstip					TIMESTAMP
	,password_change				TIMESTAMP 								CONSTRAINT usr_psswrdchng_nn NOT NULL
	,voornaam						VARCHAR2(20 CHAR)						CONSTRAINT usr_rnm_nn NOT NULL
	,tussenvoegsel					VARCHAR2(15 CHAR)
	,achternaam						VARCHAR2(30 CHAR)						CONSTRAINT usr_achtrnm_nn NOT NULL
	,rollen     					NUMBER 									CONSTRAINT usr_rlln_nn NOT NULL
	,eenheid_code					VARCHAR2(6)
	,contactinfo					VARCHAR2(50)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraing USR_PK primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE users ADD (CONSTRAINT usr_pk PRIMARY KEY (username) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table USER_LOGGEDIN
PROMPT 
PROMPT ====================================================

CREATE TABLE user_loggedin 
(	 username 						VARCHAR2(20) 							CONSTRAINT usrli_uname_nn NOT NULL
	,sessionid 						VARCHAR2(60) 							CONSTRAINT usrli_ssid_nn NOT NULL
	,last_contact_TIME 				TIMESTAMP
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraing USR_LI_FK foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE user_loggedin ADD CONSTRAINT usr_li_fk FOREIGN KEY (username) REFERENCES users (username) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table USER_SESSIONS
PROMPT 
PROMPT ====================================================

CREATE TABLE user_sessions 
(	 username 						VARCHAR2(20) 							CONSTRAINT usrus_uname_nn NOT NULL
	,tijdstip 						TIMESTAMP 								CONSTRAINT usrus_tdstp_nn NOT NULL
	,result 						NUMBER 									CONSTRAINT usrus_rslt_check CHECK(result IN(0,1)) 
																			CONSTRAINT usrus_rslt_nn NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;

PROMPT ====================================================
PROMPT 
PROMPT Add constraing USR_US_FK foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE user_sessions ADD CONSTRAINT usr_us_fk FOREIGN KEY (username) REFERENCES users (username) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table USER_PWHISTORY
PROMPT 
PROMPT ====================================================

CREATE TABLE user_pwhistory 
(	 username 						VARCHAR2(20) 							CONSTRAINT usrpwh_uname_nn NOT NULL
	,password 						VARCHAR2(250) 							CONSTRAINT usrpwh_pw_nn NOT NULL
	,tijdstip 						TIMESTAMP 								CONSTRAINT usrpwh_tdstp_nn NOT NULL
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraing USER_PWH_PK primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE user_pwhistory ADD (CONSTRAINT usr_pwh_pk PRIMARY KEY (username,password) USING INDEX TABLESPACE &app_index_tablespace);


PROMPT ====================================================
PROMPT 
PROMPT Add constraing USR_PWH_FK foreign key
PROMPT 
PROMPT ====================================================

ALTER TABLE user_pwhistory ADD CONSTRAINT usr_pwh_fk FOREIGN KEY (username) REFERENCES users (username) ON DELETE CASCADE;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table HARM_STATUS
PROMPT 
PROMPT ====================================================

CREATE TABLE harm_status 
(	 last_heartbeat_timestamp		TIMESTAMP
	,harm_status     				NUMBER(1,0) 			DEFAULT 0
	,harm_status_timestamp 			TIMESTAMP
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table TIMERTRIGGER
PROMPT 
PROMPT ====================================================

CREATE TABLE timertrigger 
(    triggername     				VARCHAR2(20) 							CONSTRAINT nn_timertrigger_triggername NOT NULL
	,runat           				VARCHAR2(20) 							CONSTRAINT nn_timertrigger_runat NOT NULL
	,runatdate       				DATE
	,runby           				VARCHAR2(20)
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

PROMPT ====================================================
PROMPT 
PROMPT Add constraing PK_TIMERTRIGGER_KEY primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE timertrigger ADD (CONSTRAINT pk_timertrigger PRIMARY KEY (triggername,runat) USING INDEX TABLESPACE &app_index_tablespace);


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create table EVENTS
PROMPT 
PROMPT ====================================================

CREATE TABLE events 
(    id              				NUMBER(20)      						CONSTRAINT nn_events_int NOT NULL
	,naam 							VARCHAR2(20) 							CONSTRAINT nn_events_naam NOT NULL
	,starttijd						TIMESTAMP
	,classnaam						VARCHAR2(256) 							CONSTRAINT nn_events_classnaam NOT NULL
	,data 							VARCHAR2(256) 	
	,maxretries 					NUMBER(10)
	,retries						NUMBER(10)
	,status 						VARCHAR2(20) 							CONSTRAINT nn_events_status NOT NULL
	,modified						TIMESTAMP
)
TABLESPACE &app_data_tablespace
ENABLE ROW MOVEMENT; 

----------------------------------------------------------------------------------

PROMPT ====================================================
PROMPT 
PROMPT Add constraing PK_EVENTS_KEY primary key
PROMPT 
PROMPT ====================================================

ALTER TABLE events ADD (CONSTRAINT pk_events PRIMARY KEY (id) USING INDEX TABLESPACE &app_index_tablespace);

PROMPT ====================================================
PROMPT 
PROMPT Create unique index NAAM, STARTTIJD on EVENTS
PROMPT 
PROMPT ====================================================

CREATE UNIQUE INDEX uk_events_naam_starttijd ON events
( 	 naam
	,starttijd 
) 
TABLESPACE &app_index_tablespace;

PROMPT ====================================================
PROMPT 
PROMPT Create index STARTTIJD, STATUS  on EVENTS
PROMPT 
PROMPT ====================================================

CREATE INDEX i_events_starttijd_status ON events
( 	 starttijd 
	,status 
) 
TABLESPACE &app_index_tablespace;


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Create sequence SEQ_EVENTS
PROMPT 
PROMPT ====================================================

CREATE SEQUENCE seq_events
	START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;