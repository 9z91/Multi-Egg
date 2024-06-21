FROM oven/bun

COPY . .

ADD src .

RUN bun install --ignore-scripts --production  

CMD ["bun", "index.ts"]
