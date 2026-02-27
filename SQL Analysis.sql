/*====================================================
  Calculate running total of all customer debit and credit
  amounts using windows function grouped by CustomerID
  and ordered by TransactionDate.
====================================================*/

SELECT
    ft.TransactionID,
    dc.CustomerID,
    ft.TransactionDate,
    ft.TransactionAmount,
    SUM(ft.TransactionAmount) OVER (PARTITION BY dc.CustomerID ORDER BY ft.TransactionDate) AS cumulative_balance
FROM
    FactTransaction ft
	INNER JOIN DimAccount da
	ON ft.AccountID = da.AccountID
	INNER JOIN DimCustomer dc
	ON da.CustomerID = dc.CustomerID
ORDER BY
    dc.CustomerID,
    ft.TransactionDate;


/*====================================================
  Finding days between every transaction for each
  customer using LAG
====================================================*/

SELECT dc.CustomerID, ft.TransactionDate,
LAG(ft.TransactionDate) OVER (PARTITION BY dc.CustomerID ORDER BY ft.TransactionDate) AS prev_date
FROM FactTransaction ft
	INNER JOIN DimAccount da
	ON ft.AccountID = da.AccountID
	INNER JOIN DimCustomer dc
	ON da.CustomerID = dc.CustomerID;

/*====================================================
  Categorizing Financial Transactions by Type as
  Income or Expense
====================================================*/

SELECT
    TransactionID,
    TransactionAmount,
    TransactionType, -- e.g. debit or credit
    TransactionDate AS TransactionDate,
    CASE
        WHEN TransactionType = 'Debit' THEN 'Income'
        WHEN TransactionType in ('Credit', 'credit') THEN 'Expense'
        ELSE 'Unknown'
    END AS TransactionCategory
FROM
    FactTransaction;


/*====================================================
  Aggregating total income, expenses and net flow
====================================================*/

WITH aggregates AS (
SELECT
    SUM(CASE WHEN TransactionType = 'Debit' THEN TransactionAmount ELSE 0 END) AS TotalIncome,
    SUM(CASE WHEN TransactionType = 'Credit' THEN TransactionAmount ELSE 0 END) AS TotalExpenses
FROM
    FactTransaction
	)

	SELECT FORMAT(TotalIncome, 'C'), FORMAT(TotalExpenses, 'C'), FORMAT(TotalIncome + TotalExpenses, 'C') as NetFlow
	FROM aggregates


SELECT user_id FROM users u WHERE NOT EXISTS (
    SELECT 1 FROM transactions t
	WHERE t.user_id = u.user_id
	AND t.transaction_date >= CURRENT_DATE - INTERVAL '60 days'
);
