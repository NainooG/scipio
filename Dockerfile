FROM messense/cargo-zigbuild:sha-4e5d0f9 as builder

WORKDIR /app

COPY . .

RUN cargo zigbuild --release --target x86_64-unknown-linux-musl
# RUN cargo zigbuild --release --target aarch64-unknown-linux-musl

FROM scratch AS runtime
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/scipio /usr/local/bin/
COPY --from=builder /app/templates /templates
# COPY --from=builder /app/target/aarch64-unknown-linux-musl/release/scipio /usr/local/bin/

CMD ["/usr/local/bin/scipio"]

# NOTE: The following is a multi-stage build that works for aarch64-unknown-linux-musl but doesn't cross
# compile correctly. If you can fix this, please submit a PR.

# FROM clux/muslrust:stable AS chef
# RUN cargo install cargo-chef
# WORKDIR /app
#
# RUN rustup target add aarch64-unknown-linux-musl && rustup target add x86_64-unknown-linux-musl
#
# FROM chef AS planner
# COPY . .
# RUN cargo chef prepare --recipe-path recipe.json
#
# FROM chef AS builder
# COPY --from=planner /app/recipe.json recipe.json
# RUN cargo chef cook --release --target aarch64-unknown-linux-musl --recipe-path recipe.json
# COPY . .
# RUN cargo build --release --target aarch64-unknown-linux-musl --bin scipio
#
# FROM scratch AS runtime
# COPY --from=builder /app/target/aarch64-unknown-linux-musl/release/scipio /usr/local/bin/
# CMD ["/usr/local/bin/scipio"]

