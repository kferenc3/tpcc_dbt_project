# tpcc_dbt

A small dbt project for testing Fivetran Transformations on Databricks. It transforms TPC-C tables that Fivetran replicates from Oracle.

## Models

| Layer | Model | Description |
|---|---|---|
| staging (views) | `stg_tpcc__customer`, `stg_tpcc__orders`, `stg_tpcc__order_line`, `stg_tpcc__item` | Casts types, trims CHAR padding, builds composite keys |
| marts (tables) | `customer_order_summary` | Order count, lifetime revenue and first/last order per customer |
| marts (tables) | `item_sales_summary` | Units sold and revenue per item |

## Source tables to sync

Include these four Oracle tables in the Fivetran connector schema: `CUSTOMER`, `ORDERS`, `ORDER_LINE`, `ITEM`.

Fivetran writes lowercase table and column names in Databricks, and the models rely on that.

## Pointing the project at your data

Sources are read from the schema in the `tpcc_source_schema` var (default `tpcc_tpcc`). Set it to the schema Fivetran creates in Databricks, in either of two ways:

- Edit `vars.tpcc_source_schema` in `dbt_project.yml`.
- Set the same var in the Fivetran transformation's environment or run settings.

Fivetran runs the models against the destination's catalog. Output goes to the schema configured on the transformation.

## Hooking it up to Fivetran

1. Push this repo to GitHub with the project at the repo root. A `main` or `production` branch is fine.
2. In Fivetran, go to **Transformations → Add transformation → Connect to Git repository**.
3. Pick the Databricks destination, paste the repo URL, choose the branch, and add the deploy key Fivetran shows to the GitHub repo (read access is enough).
4. Set the dbt project path to the repo root. If you put it in a subfolder, set the folder name.
5. Schedule it. Use **Integrated** scheduling so it runs after the Oracle connector sync completes.

`profiles.yml` holds no secrets. Fivetran injects the destination credentials at run time. The env var defaults are only placeholders for local runs.

## Running locally (optional)

```bash
pip install dbt-databricks
export DATABRICKS_HOST=... DATABRICKS_HTTP_PATH=... DATABRICKS_TOKEN=... DATABRICKS_CATALOG=...
dbt build --profiles-dir .
```
