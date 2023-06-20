FROM rust:buster AS builder

RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked trunk
COPY . .
RUN trunk build --release

FROM nginx:latest
COPY --from=builder ./dist/ /usr/share/nginx/html/
