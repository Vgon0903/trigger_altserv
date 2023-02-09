create or replace TRIGGER "VIASOFT"."OS_ALTTABSERV" BEFORE
    INSERT ON viasoft.u_alttabserv
    FOR EACH ROW

BEGIN 


IF inserting THEN

if :NEW.TPCOBRANCA = 'Romaneio'  and :NEW.TIPOSERVICO = 30 then

UPDATE romatxservico
SET
    romatxservico.tabumiserv = :NEW.TABSERVICO
WHERE
    romatxservico.estab = :NEW.ESTAB
    AND romatxservico.romaneio = :NEW.DOCUMENTO
    AND romatxservico.numerocm = :NEW.NUMEROCM
    AND romatxservico.entradasaida = 'E'
    AND romatxservico.servico = :NEW.TIPOSERVICO
    AND romatxservico.item = :NEW.ITEM;
  --  AND romatxservico.tabumiserv = :NEW.TABSERVICO;

END IF;

if :NEW.TPCOBRANCA = 'Romaneio' and :NEW.TIPOSERVICO in (31,32) then

UPDATE romatxservico
SET
    romatxservico.tabperserv = :NEW.TABSERVICO
WHERE
    romatxservico.estab = :NEW.ESTAB
    AND romatxservico.romaneio = :NEW.DOCUMENTO
    AND romatxservico.numerocm = :NEW.NUMEROCM
    AND romatxservico.entradasaida = 'E'
    AND romatxservico.servico = :NEW.TIPOSERVICO
    AND romatxservico.item = :NEW.ITEM;
  --  AND romatxservico.tabumiserv = :NEW.TABSERVICO;

END IF;


if :NEW.TPCOBRANCA = 'Nota' and :NEW.TIPOSERVICO = 30 then
UPDATE nfitemtxservico SET nfitemtxservico.tabumiserv =  :NEW.TABSERVICO
WHERE 
            nfitemtxservico.ESTAB  = :NEW.ESTAB 
        AND nfitemtxservico.SEQNOTA = :NEW.DOCUMENTO
        AND nfitemtxservico.SERVICO = :NEW.TIPOSERVICO
        AND nfitemtxservico.ITEM = :NEW.ITEM 
        --aND nfitemtxservico.tabumiserv = :NEW.TABSERVICO
        AND nfitemtxservico.SITUACAO <> 'C';

END IF;

if :NEW.TPCOBRANCA = 'Nota' and :NEW.TIPOSERVICO in (31,32) then
UPDATE nfitemtxservico SET nfitemtxservico.tabprcserv =  :NEW.TABSERVICO
WHERE 
            nfitemtxservico.ESTAB  = :NEW.ESTAB 
        AND nfitemtxservico.SEQNOTA = :NEW.DOCUMENTO
        AND nfitemtxservico.SERVICO = :NEW.TIPOSERVICO
        AND nfitemtxservico.ITEM = :NEW.ITEM 
        --aND nfitemtxservico.tabumiserv = :NEW.TABSERVICO
        AND nfitemtxservico.SITUACAO <> 'C';

END IF;
END IF;



EXCEPTION
    WHEN no_data_found THEN
        NULL;
END;
