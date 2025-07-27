#!/bin/bash
prefect deployment build fund_news_flow.py:fund_news_main2 \
  -n fund-news-daily \
  -q default \
  --cron "0 6 * * *" \
  --apply
