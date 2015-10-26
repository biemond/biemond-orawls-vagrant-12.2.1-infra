PROMPT ====================================================
PROMPT 
PROMPT Deleting record from table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config where paramname = 'vervangende.treinseries';

PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

INSERT INTO config (paramname,paramvalue,module) VALUES ('vervangende.treinseries.dagplan','690000-699999,700000-799999','SYSTEEM');
INSERT INTO config (paramname,paramvalue,module) VALUES ('vervangende.treinseries.bijsturing','300000-399999','SYSTEEM');

COMMIT;