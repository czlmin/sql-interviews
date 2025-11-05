Excellent question — and yes, you’ve captured the core intuition. Let’s unpack it precisely:

---

### ✅ 1. Why `SUM()` can inflate

`SUM()` adds up all numeric values in *every joined row*.

If you join two fact tables that each have **multiple rows per key**, SQL produces **a Cartesian product per key** (multiplying combinations).

Example:

| challenge_id | total_submissions |
| ------------ | ----------------- |
| 10           | 2                 |
| 10           | 3                 |

| challenge_id | total_views |
| ------------ | ----------- |
| 10           | 4           |
| 10           | 5           |

Join on `challenge_id`:

| submissions | views |
| ----------- | ----- |
| 2           | 4     |
| 2           | 5     |
| 3           | 4     |
| 3           | 5     |

→ now `SUM(submissions) = 2+2+3+3 = 10` (should be 5)
→ `SUM(views) = 4+5+4+5 = 18` (should be 9)

So the **multiplication of rows** makes your sums larger than reality.
That’s why in the *Interviews* problem you must **aggregate each stats table first (one row per challenge)** before joining — to collapse the duplicates before summing.

---

### ✅ 2. Why `COUNT(DISTINCT …)` doesn’t inflate (if used correctly)

`COUNT(DISTINCT column)` counts unique values *after the join result is formed*.
So even if the join duplicates the same `lead_manager_code` multiple times, the distinct set removes the duplicates before counting.

Example:

| company_code | lead_manager_code |
| ------------ | ----------------- |
| C1           | L1                |
| C1           | L2                |

| company_code | senior_manager_code |
| ------------ | ------------------- |
| C1           | S1                  |

Join:

| lead_manager_code | senior_manager_code |
| ----------------- | ------------------- |
| L1                | S1                  |
| L2                | S1                  |

`COUNT(DISTINCT lead_manager_code)` → 2
`COUNT(DISTINCT senior_manager_code)` → 1
✔ correct, no inflation.

---

### ✅ 3. In short

| Function                  | Behavior in a multi-row join              | Can prevent inflation?       |
| ------------------------- | ----------------------------------------- | ---------------------------- |
| `SUM()`                   | Adds up every duplicate → inflated totals | ❌ must pre-aggregate         |
| `AVG()`, `MIN()`, `MAX()` | Can distort because of duplication        | ❌ must pre-aggregate         |
| `COUNT(*)`                | Counts every joined row (duplicates)      | ❌ unless de-duplicated first |
| `COUNT(DISTINCT column)`  | Removes duplicates before counting        | ✅ (within its column)        |

---

### ✅ 4. General rule

* **When combining multiple fact tables (numeric measures):** pre-aggregate before joining, then `SUM()`.
* **When combining multiple dimension/lookup tables:** use `COUNT(DISTINCT)` if you just need unique entity counts.

---

So yes — you’re right:
**`SUM()` itself isn’t “wrong,”** but without pre-aggregation it multiplies measures because of the join.
**`COUNT(DISTINCT …)`** can “survive” those joins because it collapses duplicates before counting.
