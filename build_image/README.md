docker build -t fund_news:latest .
docker run -it --name fund_news_container --network=host fund_news:latest
