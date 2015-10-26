PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION add GELIJKRITBEELD
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation ADD gelijkritbeeld VARCHAR2(1) DEFAULT '1';

PROMPT ====================================================
PROMPT
PROMPT Verplaats bestaande data in kolom gelijkritbeeld_vertrek 
PROMPT naar kolom gelijkritbeeld
PROMPT
PROMPT ====================================================

UPDATE ritstation 
SET gelijkritbeeld = gelijkritbeeld_vertrek;

PROMPT ====================================================
PROMPT
PROMPT alter cache for sequences
PROMPT 
PROMPT * SEQ_INSTAPTIP
PROMPT * SEQ_MATERIEELDEELROUTE
PROMPT * SEQ_MATERIEELRELATIEKOP
PROMPT * SEQ_MATERIEELRELATIEREGEL
PROMPT * SEQ_OVERSTAPTIP
PROMPT * SEQ_RANGEERACTIVITEIT
PROMPT * SEQ_REISTIP
PROMPT * SEQ_RIT
PROMPT * SEQ_RITSTATION
PROMPT * SEQ_TRAJECTDEEL
PROMPT * SEQ_TVVRIT
PROMPT * SEQ_VERKORTEROUTE
PROMPT * SEQ_VJPTRANSACTIE
PROMPT
PROMPT ====================================================

SELECT sequence_name, cache_size 
FROM user_sequences
WHERE sequence_name IN ('SEQ_INSTAPTIP','SEQ_MATERIEELDEELROUTE','SEQ_MATERIEELRELATIEKOP','SEQ_MATERIEELRELATIEREGEL','SEQ_OVERSTAPTIP','SEQ_RANGEERACTIVITEIT','SEQ_REISTIP','SEQ_RIT',
						'SEQ_RITSTATION','SEQ_TRAJECTDEEL','SEQ_TVVRIT','SEQ_VERKORTEROUTE','SEQ_VJPTRANSACTIE')
ORDER BY sequence_name;

PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_INSTAPTIP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_instaptip CACHE 20;									
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELDEELROUTE 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieeldeelroute CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELRELATIEKOP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieelrelatiekop CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELRELATIEREGEL 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieelrelatieregel CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_OVERSTAPTIP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_overstaptip CACHE 20;							
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RANGEERACTIVITEIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_rangeeractiviteit CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_REISTIP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_reistip CACHE 20;								
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_rit CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RITSTATION 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_ritstation CACHE 20;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_TRAJECTDEEL 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_trajectdeel CACHE 20;
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_TVVRIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_tvvrit CACHE 20;
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_VERKORTEROUTE 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_verkorteroute CACHE 20;

PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_VJPTRANSACTIE 
PROMPT
PROMPT ====================================================

ALTER SEQUENCE seq_vjptransactie CACHE 20;

SELECT sequence_name, cache_size 
FROM user_sequences
WHERE sequence_name IN ('SEQ_INSTAPTIP','SEQ_MATERIEELDEELROUTE','SEQ_MATERIEELRELATIEKOP','SEQ_MATERIEELRELATIEREGEL','SEQ_OVERSTAPTIP','SEQ_RANGEERACTIVITEIT','SEQ_REISTIP','SEQ_RIT',
						'SEQ_RITSTATION','SEQ_TRAJECTDEEL','SEQ_TVVRIT','SEQ_VERKORTEROUTE','SEQ_VJPTRANSACTIE')
ORDER BY sequence_name;
