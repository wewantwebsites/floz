build-ui:
  cd client && pnpm build

dev-ui:
  cd client && pnpm dev

dev-api:
  cargo run -- --dev

run-app:
  cd client && pnpm build
  cargo run
