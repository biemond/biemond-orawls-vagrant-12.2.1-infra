PROMPT ====================================================
PROMPT
PROMPT alter cache for sequences
PROMPT 
PROMPT * SEQ_EVENTS
PROMPT
PROMPT ====================================================

SELECT sequence_name, cache_size 
FROM user_sequences
WHERE sequence_name IN ('SEQ_EVENTS')
ORDER BY sequence_name;

PROMPT ====================================================
PROMPT
PROMPT alter sequence SEQ_EVENTS 
PROMPT
PROMPT ====================================================
						
ALTER SEQUENCE seq_events CACHE 26;

SELECT sequence_name, cache_size 
FROM user_sequences
WHERE sequence_name IN ('SEQ_EVENTS')
ORDER BY sequence_name;