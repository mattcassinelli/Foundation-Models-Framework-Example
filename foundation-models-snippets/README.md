# Foundation Models / MLX snippets

Copy these into any of the SwiftUI apps when you add local-model or MLX-backed features. See **../FOUNDATION_MODELS_AND_MLX.md** for the full design and per-app ideas.

- **OpenAICompatibleClient.swift** – Minimal Swift client for `/v1/chat/completions`. Set `baseURL` to your local server (e.g. `http://127.0.0.1:8080` for PicoMLXServer or `mlx_lm.server`) or to a proxy URL for cloud. Use with App Intents or from view models for "Summarize," "Categorize," "Get hint," "Describe route," "Summarize ride," etc.
