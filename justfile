build-ui:
  cd client && pnpm build

run-ui:
  cd client && pnpm dev

run-api:
  cargo run -- --dev

run-app:
  cargo run
