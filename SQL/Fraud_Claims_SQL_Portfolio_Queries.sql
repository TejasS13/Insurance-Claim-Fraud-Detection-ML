-- ============================================================
-- Insurance Claim Fraud Detection — SQL Portfolio Queries
-- Tejas Surana | Insurance claims dataset used for portfolio analysis
-- ============================================================

-- NOTE ON SCHEMA:
-- Claims   = insurance_data_2_.csv  (10,000 rows) — main fact table
-- Vendors  = vendor_data_2_.csv     (600 rows)
-- Agents   = employee_data_2_.csv   (1,200 rows)
-- Join keys: Claims.AGENT_ID -> Agents.AGENT_ID | Claims.VENDOR_ID -> Vendors.VENDOR_ID
-- Project definition:
-- For this analysis, CLAIM_STATUS = 'D' is treated as Fraud
-- and CLAIM_STATUS = 'A' as Not Fraud, based on the dataset definition.

-- ============================================================
-- 1. SELECT + WHERE
-- High-value denied (fraud) claims 
-- ============================================================

Use FraudDetectionDB

SELECT TOP 10 TRANSACTION_ID, CUSTOMER_NAME, CLAIM_AMOUNT, INSURANCE_TYPE, STATE
FROM Claims
WHERE CLAIM_STATUS = 'D' AND CAST(CLAIM_AMOUNT AS FLOAT) > 20000
ORDER BY CAST(CLAIM_AMOUNT AS FLOAT) DESC;

-- ============================================================
-- 2. Aggregate + GROUP BY
-- Overall claim volume: Approved vs Denied
-- Validated result: 9,497 Not Fraud (A) | 503 Fraud (D)  
-- ============================================================
SELECT CLAIM_STATUS, COUNT(*) AS TotalClaims
FROM Claims
GROUP BY CLAIM_STATUS;

-- ============================================================
-- 3. AVG aggregate by category
-- Average claim amount by insurance type
-- Validated result: Life ($54,386 avg) is by far the highest-value claim category, Mobile lowest ($407 avg)
-- ============================================================
SELECT INSURANCE_TYPE,
       ROUND(AVG(CAST(CLAIM_AMOUNT AS FLOAT)), 2) AS AvgClaimAmount,
       COUNT(*) AS ClaimCount
FROM Claims
GROUP BY INSURANCE_TYPE
ORDER BY AvgClaimAmount DESC;

-- ============================================================
-- 4. GROUP BY + HAVING  
-- Fraud rate % by insurance type, only categories with meaningful volume (>100 claims)
-- Validated result: Motor has the highest fraud rate at 5.40%, followed by Travel (5.27%)
-- ============================================================
SELECT INSURANCE_TYPE,
       COUNT(*) AS TotalClaims,
       SUM(CASE WHEN CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) AS FraudClaims,
       ROUND(100.0 * SUM(CASE WHEN CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) / COUNT(*), 2) AS FraudRatePct
FROM Claims
GROUP BY INSURANCE_TYPE
HAVING COUNT(*) > 100
ORDER BY FraudRatePct DESC;

-- ============================================================
-- 5. INNER JOIN — Claims to Agents
-- Pulls agent details alongside each claim
-- ============================================================
SELECT TOP 10 c.TRANSACTION_ID, c.CLAIM_AMOUNT, c.CLAIM_STATUS, a.AGENT_NAME, a.CITY AS AgentCity
FROM Claims c
INNER JOIN Agents a ON c.AGENT_ID = a.AGENT_ID;

-- ============================================================
-- 6. LEFT JOIN + aggregation — Vendors to Claims
-- Which vendors handled the most claims (includes vendors with zero claims via LEFT JOIN)
-- Validated result: top vendors ("Hicks, Patton and Cook", "French and Sons") each handled 28 claims
-- ============================================================
SELECT TOP 10 v.VENDOR_ID, v.VENDOR_NAME, COUNT(c.TRANSACTION_ID) AS ClaimsHandled
FROM Vendors v
LEFT JOIN Claims c ON v.VENDOR_ID = c.VENDOR_ID
GROUP BY v.VENDOR_ID, v.VENDOR_NAME
ORDER BY ClaimsHandled DESC;

-- ============================================================
-- 7. Subquery
-- Count of claims above the overall average claim amount
-- Validated result: 3,208 claims (out of 10,000) exceed the average claim amount
-- ============================================================
SELECT COUNT(*) AS ClaimsAboveAvg
FROM Claims
WHERE CAST(CLAIM_AMOUNT AS FLOAT) > (SELECT AVG(CAST(CLAIM_AMOUNT AS FLOAT)) FROM Claims);

-- ============================================================
-- 8. CTE (Common Table Expression)
-- Fraud rate by incident severity
-- Validated result: Total Loss incidents have the highest fraud rate (5.19%), followed by Minor Loss (5.07%)
-- ============================================================
WITH FraudBySeverity AS (
    SELECT INCIDENT_SEVERITY,
           COUNT(*) AS TotalClaims,
           SUM(CASE WHEN CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) AS FraudClaims,
           ROUND(100.0 * SUM(CASE WHEN CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) / COUNT(*), 2) AS FraudRatePct
    FROM Claims
    GROUP BY INCIDENT_SEVERITY
)
SELECT * FROM FraudBySeverity
ORDER BY FraudRatePct DESC;

-- ============================================================
-- 9. Window Function (advanced SQL)
-- Rank claims by amount within each state
-- ============================================================
SELECT TOP 10 TRANSACTION_ID, STATE, CLAIM_AMOUNT,
       RANK() OVER (PARTITION BY STATE ORDER BY CAST(CLAIM_AMOUNT AS FLOAT) DESC) AS StateRank
FROM Claims;

-- ============================================================
-- 10. JOIN + GROUP BY + HAVING combined  (best "business insight" query)
-- Agent-level fraud rate — flags agents with disproportionately high fraud rates among their claims
-- Validated result: Bertha Reynolds & Robert Villareal show 30% fraud rate on 10 handled claims each
-- vs. ~5% company-wide average — a genuine audit-worthy finding
-- ============================================================
SELECT TOP 10 a.AGENT_ID, a.AGENT_NAME,
       COUNT(c.TRANSACTION_ID) AS TotalClaims,
       SUM(CASE WHEN c.CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) AS FraudClaims,
       ROUND(100.0 * SUM(CASE WHEN c.CLAIM_STATUS = 'D' THEN 1 ELSE 0 END) / COUNT(c.TRANSACTION_ID), 2) AS FraudRatePct
FROM Agents a
JOIN Claims c ON a.AGENT_ID = c.AGENT_ID
GROUP BY a.AGENT_ID, a.AGENT_NAME
HAVING COUNT(c.TRANSACTION_ID) >= 10
ORDER BY FraudRatePct DESC;
