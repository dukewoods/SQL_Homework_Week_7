-- Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders.
-- How can you isolate (or group) the transactions of each cardholder?

-- CREATE VIEW "fraud_trans_all<2.00" AS
SELECT t.id AS transaction_id,
       t.date,
       t.amount,
       t.card AS transaction_card,
       t.id_merchant,
       cc.card AS credit_card,
       cc.cardholder_id,
       ch.id AS card_holder_id,
       ch.name AS card_holder_name
FROM transaction as t
INNER JOIN credit_card as cc ON cc.card = t.card
INNER JOIN card_holder as ch ON ch.id = cc.cardholder_id
WHERE t.amount < 2
ORDER BY ch.name ASC;

-- Count the transactions that are less than $2.00 per cardholder.

SELECT cc.cardholder_id, COUNT(*) 
FROM transaction t
INNER JOIN credit_card cc ON cc.card = t.card
WHERE t.amount < 2
GROUP BY cc.cardholder_id;

-- Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
-- I cant see any evidence in this data as there are mulitple names with less than $2 transactions, also lots of different card number and merchants. 

-- Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made.
-- What are the top 100 highest transactions made between 7:00 am and 9:00 am?

-- CREATE VIEW "fraud_trans_7-9" AS
SELECT t.id AS transaction_id,
       t.date,
       t.amount,
       t.card AS transaction_card,
       t.id_merchant,
       cc.card AS credit_card,
       cc.cardholder_id,
       ch.id AS card_holder_id,
       ch.name AS card_holder_name
FROM transaction as t
INNER JOIN credit_card as cc ON cc.card = t.card
INNER JOIN card_holder as ch ON ch.id = cc.cardholder_id
WHERE EXTRACT(HOUR FROM t.date) BETWEEN 7 AND 8
ORDER BY t.amount DESC
LIMIT 100
;

-- Do you see any anomalous transactions that could be fraudulent?
-- Yes i see two transaction with large float decimals id 3163 and 2451

-- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
-- No i see that there is also fraudulent transactions made during other parts of the day. 

-- CREATE VIEW "fraud_trans_all_day" AS
SELECT t.id AS transaction_id,
       t.date,
       t.amount,
       t.card AS transaction_card,
       t.id_merchant,
       cc.card AS credit_card,
       cc.cardholder_id,
       ch.id AS card_holder_id,
       ch.name AS card_holder_name
FROM transaction as t
INNER JOIN credit_card as cc ON cc.card = t.card
INNER JOIN card_holder as ch ON ch.id = cc.cardholder_id
-- WHERE EXTRACT(HOUR FROM t.date) BETWEEN 7 AND 8
ORDER BY t.amount DESC
LIMIT 100
;

-- What are the top 5 merchants prone to being hacked using small transactions?
-- The top 5 merchants prone to being hacked using small transactions are Riggs-Adams, White-Hall, Jarvis-Turner, Ruiz-Anderson and Johnson and Sons


SELECT t.id AS transaction_id,
       t.date,
       t.amount,
       t.card,
       t.id_merchant,
       cc.card AS credit_card,
       cc.cardholder_id,
       ch.id AS card_holder_id,
       ch.name AS card_holder_name,
       m.id AS merchant_id,
       m.name AS merchant_name,
       m.id_merchant_category
FROM transaction AS t
INNER JOIN credit_card AS cc ON cc.card = t.card
INNER JOIN card_holder AS ch ON ch.id = cc.cardholder_id
INNER JOIN merchant AS m ON m.id = t.id_merchant
WHERE t.amount < 2
ORDER BY ch.name ASC;

-- CREATE VIEW "top_5_merchants<2.00" AS
SELECT t.id_merchant, m.name, COUNT(*) 
FROM transaction t
INNER JOIN merchant m ON m.id = t.id_merchant
GROUP BY t.id_merchant, m.name
ORDER BY COUNT DESC
LIMIT 5;

-- Create a view for each of your queries.
-- Complete in above step. 
