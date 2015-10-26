PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION add GELIJKRITBEELD_AANKOMST
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation ADD gelijkritbeeld_aankomst VARCHAR2(1) DEFAULT '1';

PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION add GELIJKRITBEELD_VERTREK
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation ADD gelijkritbeeld_vertrek VARCHAR2(1) DEFAULT '1';


PROMPT ====================================================
PROMPT
PROMPT Verplaats bestaande data in kolom gelijkritbeeld 
PROMPT naar kolom gelijkritbeeld_vertrek
PROMPT
PROMPT ====================================================


UPDATE ritstation 
SET gelijkritbeeld_vertrek = gelijkritbeeld;

COMMIT;