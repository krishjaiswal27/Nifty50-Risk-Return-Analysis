# Nifty 50 Risk & Return Analysis (1991–2025)

## Executive Summary:
Nifty 50 stocks are often treated as uniformly "safe" simply because they're blue-chip and heavily tracked, which masks very different risk and return profiles underneath. Using Python, SQL, and Power BI, I pulled and cleaned over three decades of daily price data across all 50 Nifty 50 constituents and built a dashboard tracking return, volatility, drawdown, and correlation across the index. After finding that pharma and consumer-facing stocks delivered stronger risk-adjusted returns than banks and industrials over the full period, a few things stand out for anyone using this kind of analysis to inform a long-term allocation:
1. Weigh risk-adjusted return over headline return, not just raw price performance
2. Treat recently-listed stocks' rankings with caution given their shorter track record
3. Use correlation, not just past returns, to actually diversify within the index

### Business Problem:
An investor or analyst trying to build a long-term Nifty 50 allocation needs more than brand recognition or recent headlines to go on: which of these 50 stocks have actually compounded wealth most efficiently, which carried outsized risk for the return delivered, and how independently do they move from one another? This project answers that using 30+ years of daily trading data rather than sentiment or recency bias.

<img width="912" height="502" alt="Image" src="https://github.com/user-attachments/assets/a58d2ea5-76d1-4546-a52d-236b891cc072" />

### Methodology:
1. Sourced and combined three decades of daily OHLCV and adjusted close data for all 50 Nifty 50 constituents in Python, looping through 50 individual per-stock files.
2. Identified and corrected three separate data quality issues before trusting any results: a benchmark index file mistakenly swept up alongside the 50 stock files, a header-row export bug that had mislabeled the date column, and an accidental column-wise merge that introduced duplicate, empty columns.
3. Calculated daily returns, annualized return and volatility, a risk-adjusted return ratio, maximum drawdown, and a full 50x50 return correlation matrix for every stock.
4. Loaded the cleaned data into PostgreSQL and wrote SQL queries, including CTEs and window functions (RANK, LAG), to rank yearly performance and track year-over-year volatility shifts.
5. Connected Power BI directly to the PostgreSQL database and built a multi-page interactive dashboard, letting a viewer filter by years of listed history and drill into any individual stock's price trend.

### Skills:
SQL: CTEs, Joins, Window functions (RANK, LAG), Views, aggregate functions.
Power BI: DAX measures and calculated columns, data modeling and relationships, conditional formatting, interactive slicers and cross-filtering, dashboard design.
Python: Pandas, NumPy, Matplotlib, Seaborn, Plotly, data cleaning, financial return/risk calculations, exploratory data analysis.

### Results & Business Recommendation:
Pharma and consumer-facing names led the risk-adjusted leaderboard — Divi's Laboratories, Sun Pharma, Apollo Hospitals, Britannia, and Asian Paints all delivered strong returns at comparatively low volatility (16-23% annualized), while several banks and industrials further down the list carried volatility above 40% for similar or even lower returns.

<img width="1012" height="528" alt="Image" src="https://github.com/user-attachments/assets/713951f6-f700-4f59-829d-1d8fb5781f2c" />


Correlation across the 50 stocks stayed mostly in a light-to-moderate range rather than clustering near 1, suggesting real diversification benefit to holding a broad basket rather than concentrating in a handful of names.

<img width="1151" height="1053" alt="Image" src="https://github.com/user-attachments/assets/c660c575-d7e4-40aa-9ee7-34f98afdf93c" />

For anyone using this analysis to inform a long-term Nifty 50 allocation, a few things stand out:
1. Risk-adjusted return is a more useful lens than headline return — several of the highest-volatility stocks didn't deliver proportionally higher return for the risk taken on.
2. Recently-listed stocks' rankings deserve extra scrutiny, since a strong few years isn't the same evidence as three decades of resilience through multiple market cycles.
3. Outliers are worth investigating before acting on them — what looks like a red flag in a chart is sometimes real risk, and sometimes just messy data underneath it.

*This analysis is for educational and portfolio purposes; nothing here should be read as investment advice.*

### Next Steps:
1. Build the correlation matrix as an interactive Power BI visual rather than a static image
2. Bring in real sector classifications (currently inferred) for a cleaner sector-level comparison
3. Backtest a simple equal-weight vs. risk-adjusted-weight portfolio construction using this same dataset
4. Publish the Power BI report and link it directly from this README
