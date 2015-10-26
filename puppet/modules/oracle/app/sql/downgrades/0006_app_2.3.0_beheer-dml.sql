PROMPT ====================================================
PROMPT 
PROMPT Deleting record from table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config WHERE module = 'SYSTEEM' AND paramname IN ('vervangende.treinseries.dagplan', 'vervangende.treinseries.bijsturing');

PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

INSERT INTO config (paramname,paramvalue,module) VALUES ('vervangende.treinseries','300000-399999,690000-699999,700000-799999','SYSTEEM');

COMMIT;