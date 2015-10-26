PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION drop GELIJKRITBEELD_AANKOMST
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation DROP COLUMN gelijkritbeeld_aankomst;

PROMPT ====================================================
PROMPT
PROMPT Verplaats bestaande data in kolom gelijkritbeeld_vertrek 
PROMPT naar kolom gelijkritbeeld
PROMPT
PROMPT ====================================================

UPDATE ritstation SET gelijkritbeeld = gelijkritbeeld_vertrek;

PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION drop GELIJKRITBEELD_VERTREK
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation DROP COLUMN gelijkritbeeld_vertrek;

COMMIT;