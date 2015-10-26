PROMPT ====================================================
PROMPT 
PROMPT Deleting record from table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config where paramname = 'vervangende.vertrektijdrange';

COMMIT;