PROMPT ====================================================
PROMPT 
PROMPT Inserting records in table CONFIG
PROMPT 
PROMPT ====================================================

DELETE FROM config WHERE paramname = 'enable.versturen.tub' AND module = 'RITRIJK';

COMMIT;