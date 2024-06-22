FROM oven/bun

RUN apt-get update -y && apt-get install wget -y

COPY package.json bun.lockb ./

RUN bun install --ignore-scripts --production  

COPY src .

RUN rm -rf src

CMD ["bun", "index.ts"]
