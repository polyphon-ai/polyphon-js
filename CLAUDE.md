# polyphon-js — CLAUDE.md

JavaScript/TypeScript SDK for the Polyphon JSON-RPC API. Provides the canonical client, type definitions, and a mock server for testing integrations against Polyphon without a running app.

Published to npm as `@polyphon-ai/js`. Version is kept in sync with the Polyphon app version.

---

## Domain Vocabulary

Use the same language as the Polyphon app:

| Concept | Term |
|---|---|
| An AI agent in a session | **voice** |
| A saved multi-agent configuration | **composition** |
| A conversation thread | **session** |
| The user | **conductor** |

---

## Package Exports

```
@polyphon-ai/js           # Client, types, token helpers, error codes
@polyphon-ai/js/testing   # MockPolyphonServer and fixtures — import only in tests
```

## Source Layout

```
src/
├── types.ts              # Domain types (synced from polyphon/src/shared/types.ts)
├── api.ts                # JSON-RPC types, error codes, method params/results (synced from polyphon/src/shared/api.ts)
├── client.ts             # PolyphonClient — TCP connection, streaming, auth
├── token.ts              # readLocalToken(), defaultTokenPath() — cross-platform helpers
├── errors.ts             # RpcError class, error code constants
├── index.ts              # Public exports
└── testing/
    ├── MockPolyphonServer.ts  # Configurable mock TCP server with realistic streaming
    ├── fixtures.ts            # Default compositions, sessions, messages
    └── index.ts               # Exports for @polyphon-ai/js/testing
```

---

## Source of Truth

`src/types.ts` and `src/api.ts` are **synced from** `polyphon/src/shared/types.ts` and
`polyphon/src/shared/api.ts`. Do not edit them by hand — they are updated automatically
via the `sync-from-polyphon.yml` GitHub Actions workflow when a Polyphon release publishes.

All other source files are maintained here.

---

## Version Policy

The SDK version always matches the Polyphon app version (e.g. Polyphon `0.12.0` → SDK
`0.12.0`). This makes API compatibility unambiguous: install the SDK version that matches
your Polyphon install.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | TypeScript 5 |
| Build | tsc (NodeNext ESM + declarations) |
| Testing | Vitest |
| Runtime | Node.js ≥ 18 (TCP via `node:net`) |

---

## Build & Development

```sh
npm install
make build      # type-check + compile to dist/
make test       # run all tests
make lint       # type-check only
```

---

## Testing Policy

- Unit tests cover `PolyphonClient` in isolation using `MockPolyphonServer`
- Integration tests exercise the full client ↔ server round-trip via `MockPolyphonServer`
- `MockPolyphonServer` must implement all API methods and is the primary testing artifact
- Keep mock responses realistic — word-by-word streaming with configurable delay, not single-chunk dumps

---

## Ecosystem

This project is part of the polyphon-ai workspace. See `../CLAUDE.md` for how the
projects relate to each other.
