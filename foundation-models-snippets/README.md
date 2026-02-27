# Foundation Models / MLX snippets

## Developer setup

- **Type:** Container. Projects are in subfolders.

- **Git:** [https://github.com/mattcassinelli/Foundation-Models-Framework-Example.git](https://github.com/mattcassinelli/Foundation-Models-Framework-Example.git)

- **Recent commits:**
  - `9f342a4` Save work (takedown audit) (2026-02-26)

- **Structure (snapshot):**
  ```
  OpenAICompatibleClient.swift
  README.md
  ```

- *Snapshot: 2026-02-27*



Copy these into any of the SwiftUI apps when you add local-model or MLX-backed features. See **../FOUNDATION_MODELS_AND_MLX.md** for the full design and per-app ideas.

- **OpenAICompatibleClient.swift** – Minimal Swift client for `/v1/chat/completions`. Set `baseURL` to your local server (e.g. `http://127.0.0.1:8080` for PicoMLXServer or `mlx_lm.server`) or to a proxy URL for cloud. Use with App Intents or from view models for "Summarize," "Categorize," "Get hint," "Describe route," "Summarize ride," etc.
