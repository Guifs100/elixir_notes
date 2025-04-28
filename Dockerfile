# # Dockerfile
# FROM elixir:1.15-alpine

# # Instala Hex e rebar
# RUN mix local.hex --force && \
#     mix local.rebar --force

# # Instala Node.js para assets (opcional)
# RUN apk add --no-cache nodejs npm git build-base

# WORKDIR /app

# COPY mix.exs mix.lock ./
# COPY config config
# RUN mix deps.get

# COPY . .

# RUN mix compile

# EXPOSE 4000

# CMD ["mix", "phx.server"]

# Dockerfile
FROM elixir:1.15-alpine

# Instala Hex, Rebar, Node.js e build tools
RUN apk add --no-cache nodejs npm git build-base

WORKDIR /app

# Prepara ambiente para criar o projeto
RUN mix local.hex --force && mix archive.install --force hex phx_new 1.7.10

# Expor a porta 4000
EXPOSE 4000

CMD ["iex"]
