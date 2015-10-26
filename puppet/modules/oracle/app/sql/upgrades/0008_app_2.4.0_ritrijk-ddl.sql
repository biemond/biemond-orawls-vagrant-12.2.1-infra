PROMPT ====================================================
PROMPT
PROMPT alter table RITSTATION drop GELIJKRITBEELD
PROMPT
PROMPT ====================================================

ALTER TABLE ritstation DROP COLUMN Gelijkritbeeld;

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
						
ALTER SEQUENCE seq_instaptip CACHE 5788;									
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELDEELROUTE 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieeldeelroute CACHE 630210;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELRELATIEKOP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieelrelatiekop CACHE 14168;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_MATERIEELRELATIEREGEL 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_materieelrelatieregel CACHE 34922;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_OVERSTAPTIP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_overstaptip CACHE 1833;							
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RANGEERACTIVITEIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_rangeeractiviteit CACHE 20174;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_REISTIP 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_reistip CACHE 194115;								
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_rit CACHE 140099;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_RITSTATION 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_ritstation CACHE 1779459;						
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_TRAJECTDEEL 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_trajectdeel CACHE 40659;
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_TVVRIT 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_tvvrit CACHE 1132;
						
PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_VERKORTEROUTE 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_verkorteroute CACHE 1128569;

PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_VJPTRANSACTIE 
PROMPT
PROMPT ====================================================

ALTER SEQUENCE seq_vjptransactie CACHE 258;

SELECT sequence_name, cache_size 
FROM user_sequences
WHERE sequence_name IN ('SEQ_INSTAPTIP','SEQ_MATERIEELDEELROUTE','SEQ_MATERIEELRELATIEKOP','SEQ_MATERIEELRELATIEREGEL','SEQ_OVERSTAPTIP','SEQ_RANGEERACTIVITEIT','SEQ_REISTIP','SEQ_RIT',
						'SEQ_RITSTATION','SEQ_TRAJECTDEEL','SEQ_TVVRIT','SEQ_VERKORTEROUTE','SEQ_VJPTRANSACTIE')
ORDER BY sequence_name;
