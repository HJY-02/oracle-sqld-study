CREATE TABLE TBL (
    ID VARCHAR2(10),
    SVAL NUMBER,
    EVAL NUMBER
);

INSERT INTO TBL VALUES ('A01', 1, 2);
INSERT INTO TBL VALUES ('A02', 2, 3);
INSERT INTO TBL VALUES ('A03', 3, 4);
INSERT INTO TBL VALUES ('B04', 4, 5);
INSERT INTO TBL VALUES ('B05', 7, 8);
INSERT INTO TBL VALUES ('B06', 8, NULL);
COMMIT;

SELECT *
FROM TBL;

SELECT ID, SVAL, EVAL
FROM (
    SELECT ID,
            GR,
            SVAL,
            NVL(EVAL, 99) EVAL,
            CASE WHEN SVAL = LAG(EVAL) OVER (PARTITION BY GR ORDER BY SVAL, NVL(EVAL,99)) THEN 1 ELSE 0 END AS FLAG1,
            CASE WHEN EVAL = LEAD(SVAL) OVER (PARTITION BY GR ORDER BY SVAL, NVL(EVAL,99)) THEN 1 ELSE 0 END AS FLAG2
    FROM (
        SELECT ID,
                SUBSTR(ID, 1, 1) AS GR,
                SVAL,
                EVAL
        FROM TBL
    )
)
WHERE FLAG1 = 1 AND FLAG2 = 1;
