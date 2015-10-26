PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

INSERT INTO config (paramname,paramvalue,module) VALUES ('perc.rijtijd.vermindering','7','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('significante.vertragings.afwijking','1','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('minimale.vertrekverschil.gesplitste.treinen','2','VTG');
INSERT INTO config (paramname,paramvalue,module) VALUES ('minimum.stationnement.tijd','2','VTG');

PROMPT ====================================================
PROMPT 
PROMPT Delete record in table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config WHERE paramname = 'minimum.stationnement.tijd' AND module = 'RITRIJK';

