PROMPT ====================================================
PROMPT 
PROMPT Deleting records from table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config;

PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

INSERT INTO config (paramname,paramvalue,module) VALUES ('instaptip.venster.begin','-10','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('instaptip.venster.eind','20','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('schoning.delay.time','180','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('overstaptip.max.overstaptijd','120','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('overstaptip.min.overstaptijd','2','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gedemptevertrekvertraging.afronding.minuten','5','SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('wijzigingsaanleiding.vertraging.threshold.minuten','5','SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gemiddelde.baklengte','2640','SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('rechte.wissel.berijding.tussen.fasen','true','SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('zoek.binnenkomende.treinen.periode','180','SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.input','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.aps','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.dasoutput','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.dvsoutput','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.ritinfooutput','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('valideer.xml.argosoutput','true','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('snmp.trap.frequentie','5','SNMP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('snmp.remote.host','127.0.0.1','SNMP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('snmp.remote.port','162','SNMP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('log.niveau','WARN','LOG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('log.directory','/var/log/weblogic/applications/infoplus/cris/debug','LOG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('log.max.bestandsgrootte','10240','LOG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('log.max.backup.index','50','LOG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('enable.queue.logging','false','ARCHIVE');
INSERT INTO config (paramname,paramvalue,module) VALUES ('keepalive.interval','15','MQA');
INSERT INTO config (paramname,paramvalue,module) VALUES ('keepalive.timeouts','15','MQA');
INSERT INTO config (paramname,paramvalue,module) VALUES ('message.time.to.live','15','MQA');
INSERT INTO config (paramname,paramvalue,module) VALUES ('harm.timeout.interval','15','INP');
INSERT INTO config (paramname,paramvalue,module) VALUES ('minimum.stationnement.tijd','2','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('perc.rijtijd.vermindering','7','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('significante.vertragings.afwijking','1','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('minimale.vertrekverschil.gesplitste.treinen','2','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('bericht.beheerder','Geen bijzonderheden','SYSTEEM');
INSERT INTO config (paramname,paramvalue,module) VALUES ('termijn.veroudering.plan.stamgegevens.uren','24','SYSTEEM');
INSERT INTO config (paramname,paramvalue,module) VALUES ('vervangende.treinseries','300000-399999,690000-699999,700000-799999','SYSTEEM');
INSERT INTO config (paramname,paramvalue,module) VALUES ('voortrein_natrein.treinseries','100000-199999,200000-299999','SYSTEEM');
INSERT INTO config (paramname,paramvalue,module) VALUES ('vervangende.vertrektijdrange','30','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('reistip.tijdsvenster.stoptrein','30','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('reistip.tijdsvenster.sneltreinintercity','60','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('vjp.verwerkingsvertraging','1','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('omw.verwerkingsvertraging','1','RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('tvv.overstaptijd', '300', 'RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('tvv.aansluitinginterval', '30', 'RITRIJK');
INSERT INTO config (paramname,paramvalue,module) VALUES ('max.initieer.interval', '90', 'SAS');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gui.AantalKerenFoutWachtwoord', '3', 'GUI');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gui.MaximaleGeldigheidsduurWachtwoord', '31', 'GUI');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gui.MinimaleLengteWachtwoord', '7', 'GUI');
INSERT INTO config (paramname,paramvalue,module) VALUES ('gui.WaarschuwingsTekst', ' ', 'GUI');
INSERT INTO config (paramname,paramvalue,module) VALUES ('tijd.tussen.opeenvolgende.ritten.DVB', '15', 'RITRIJK');


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Deleting records from table PASSWORDPOLICY
PROMPT 
PROMPT ====================================================

DELETE FROM passwordpolicy;

PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table PASSWORDPOLICY
PROMPT 
PROMPT ====================================================

INSERT INTO passwordpolicy (policyid,policy,description,histsize,nrattempts,disabledtime,active)  VALUES ( 'PP_POLICY', '[a-zA-Z]{6}[0-9]{2}', 'password bestaande uit 6 alfanumerieke karakters opvolgend door 2 numerieke karakters', 5, 5, 30, 1); 


----------------------------------------------------------------------------------


PROMPT ====================================================
PROMPT 
PROMPT Deleting records from table USERS
PROMPT 
PROMPT ====================================================

DELETE FROM users;

PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table USERS
PROMPT 
PROMPT ====================================================

INSERT INTO users (username,password,inlogpoging,blokkering,bloktijdstip,password_change,voornaam,tussenvoegsel,achternaam,rollen,eenheid_code,contactinfo) VALUES( 'cris', '93026b671c96be43b475b53b8c0f8b77dc661ebf', 0, 0, null, sysdate, 'Cris', null, 'Administrator', '1', null,null);
INSERT INTO users (username,password,inlogpoging,blokkering,bloktijdstip,password_change,voornaam,tussenvoegsel,achternaam,rollen,eenheid_code,contactinfo) VALUES( 'admin', '0c638ef9fd70a0c947e920372aacaccc9c209946', 0, 0, null, sysdate, 'Admin', null, 'Administrator', '2', null,null);

COMMIT;