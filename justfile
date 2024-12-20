build-ui:
  cd client && pnpm build

run-ui:
  cd client && pnpm dev

run-app:
  cargo run

run-dev:
  cargo run -- --dev
  cd client && pnpm dev