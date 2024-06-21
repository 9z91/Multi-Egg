FROM oven/bun

COPY bun.lockb . 
COPY package.json . 

RUN bun install --frozen-lockfile

COPY src . 

CMD ["bun", "index.ts"]
