# node-builder
FROM node:23.6-bookworm AS node-builder

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /usr/src
COPY ./web/package.json ./web/pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

COPY ./web .
RUN pnpm run build

# go-builder
FROM golang:1.23 AS go-builder

WORKDIR /usr/src
COPY app/go.mod app/go.sum ./
RUN go mod download
COPY ./app .

COPY --from=node-builder /usr/src/dist/ /usr/src/web_dist/
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-s -w" -o /opt/todo-app .

# final image
FROM gcr.io/distroless/static:nonroot

COPY --from=go-builder --chown=nonroot:nonroot /opt/todo-app /opt/todo-app

CMD ["/opt/todo-app"]
