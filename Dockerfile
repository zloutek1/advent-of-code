FROM dyalog/dyalog:18.2

WORKDIR /app
COPY . .

ENTRYPOINT ["./run.sh"]
