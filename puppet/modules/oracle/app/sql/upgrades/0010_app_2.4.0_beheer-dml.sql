PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

INSERT INTO config (paramname,paramvalue,module) VALUES ('minimum.stationnement.tijd','3','RITRIJK');

PROMPT ====================================================
PROMPT 
PROMPT Delering records in table CONFIG
PROMPT 
PROMPT =================================================


DELETE FROM config WHERE paramname = 'perc.rijtijd.vermindering' AND module = 'VTG';
DELETE FROM config WHERE paramname = 'significante.vertragings.afwijking' AND module = 'VTG';
DELETE FROM config WHERE paramname = 'minimale.vertrekverschil.gesplitste.treinen' AND module = 'VTG';
DELETE FROM config WHERE paramname = 'minimum.stationnement.tijd' AND module = 'VTG';