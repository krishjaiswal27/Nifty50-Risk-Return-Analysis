CREATE TABLE stock_prices (
    date DATE,
    open NUMERIC,
    high NUMERIC,
    low NUMERIC,
    close NUMERIC,
    adj_close NUMERIC,
    volume BIGINT,
    symbol VARCHAR(20),
    daily_return NUMERIC
);

CREATE TABLE risk_return_summary (
    symbol VARCHAR(20) PRIMARY KEY,
    avg_daily_return NUMERIC,
    daily_volatility NUMERIC,
    n_days INTEGER,
    annualized_return NUMERIC,
    annualized_volatility NUMERIC,
    return_per_unit_risk NUMERIC
);

CREATE TABLE drawdowns (
    symbol VARCHAR(20) PRIMARY KEY,
    max_drawdown NUMERIC
);

CREATE INDEX idx_stock_prices_symbol ON stock_prices(symbol);
CREATE INDEX idx_stock_prices_date ON stock_prices(date);

SELECT r.symbol, r.annualized_return, r.annualized_volatility,
       r.return_per_unit_risk, d.max_drawdown
FROM risk_return_summary r
JOIN drawdowns d ON r.symbol = d.symbol
ORDER BY r.return_per_unit_risk DESC
LIMIT 10;

WITH yearly_returns AS (
    SELECT symbol, EXTRACT(YEAR FROM date) AS year,
           AVG(daily_return) * 252 AS approx_annual_return
    FROM stock_prices
    GROUP BY symbol, year
)
SELECT symbol, year, approx_annual_return,
       RANK() OVER (PARTITION BY year ORDER BY approx_annual_return DESC) AS rank_in_year
FROM yearly_returns
ORDER BY year, rank_in_year;

WITH yearly_vol AS (
    SELECT symbol, EXTRACT(YEAR FROM date) AS year,
           STDDEV(daily_return) * SQRT(252) AS annual_vol
    FROM stock_prices
    GROUP BY symbol, year
)
SELECT symbol, year, annual_vol,
       LAG(annual_vol) OVER (PARTITION BY symbol ORDER BY year) AS prev_year_vol
FROM yearly_vol
ORDER BY symbol, year;

CREATE VIEW yearly_rank AS
WITH yearly_returns AS (
    SELECT symbol, EXTRACT(YEAR FROM date) AS year, AVG(daily_return) * 252 AS approx_annual_return
    FROM stock_prices
    GROUP BY symbol, year
)
SELECT symbol, year, approx_annual_return,
       RANK() OVER (PARTITION BY year ORDER BY approx_annual_return DESC) AS rank_in_year
FROM yearly_returns;
