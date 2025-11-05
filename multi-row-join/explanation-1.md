Great observation. The difference boils down to **what you’re aggregating** and **how**:

## Why the “Interviews” query inflates

* You have two *fact-like* tables at the **same grain** (`Submission_Stats` and `View_Stats`, both by `challenge_id`).
* If a challenge has 3 submission rows and 4 view rows, a direct join produces **3×4 = 12** joined rows.
* Summing numeric columns across that join **double-counts** unless you pre-aggregate each table to **one row per challenge** and then join.

## Why “The Company” query doesn’t inflate

* You’re counting **unique entities** per tier (lead_manager_code, senior_manager_code, …) **by company**, not summing measures.
* Even though joining four role tables on `company_code` can create multiplicative combinations across tiers, the query uses:

  ```sql
  COUNT(DISTINCT lm.lead_manager_code),
  COUNT(DISTINCT sm.senior_manager_code),
  COUNT(DISTINCT m.manager_code),
  COUNT(DISTINCT e.employee_code)
  ```

  The **DISTINCT** makes each tier’s count based on **unique codes** in that tier, **independent** of how many cross-tier combinations the join produced.

## Tiny example

Company C1 has:

* Lead_Manager: L1, L2  (2 rows)
* Senior_Manager: S1     (1 row)

Joining on `company_code` yields 2×1 = 2 rows: (L1,S1), (L2,S1).
With `COUNT(*)` you’d get 2; with `COUNT(DISTINCT lm.lead_manager_code)` you get **2**, and with `COUNT(DISTINCT sm.senior_manager_code)` you get **1** — the correct per-tier counts.

## Rule of thumb

* **Multiple fact tables at same grain + SUM ⇒ pre-aggregate first** (or use separate subqueries/CTEs and join on the key).
* **Counting entities across wide joins ⇒ use `COUNT(DISTINCT key)` per entity type** to avoid inflation.
