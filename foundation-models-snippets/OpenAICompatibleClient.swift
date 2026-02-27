// OpenAICompatibleClient.swift
// Copy into any of the SwiftUI apps when you want to call a local MLX server (PicoMLXServer, mlx_lm.server) or any OpenAI-compatible endpoint. Configure baseURL (e.g. http://127.0.0.1:8080); never ship API keys in the client—use a proxy (e.g. Pico AI Proxy) for cloud. See FOUNDATION_MODELS_AND_MLX.md.

import Foundation

struct OpenAICompatibleClient {
    var baseURL: URL
    var apiKey: String? // optional; many local servers ignore it

    init(baseURL: URL = URL(string: "http://127.0.0.1:8080")!, apiKey: String? = nil) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }

    /// POST to /v1/chat/completions and return the first choice message content.
    func complete(messages: [[String: String]], model: String = "mlx-community/Meta-Llama-3-8B-Instruct-4bit") async throws -> String {
        let url = baseURL.appendingPathComponent("v1/chat/completions")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let key = apiKey, !key.isEmpty {
            request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        }
        let body: [String: Any] = [
            "model": model,
            "messages": messages,
            "max_tokens": 512
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw NSError(domain: "OpenAICompatibleClient", code: -1, userInfo: [NSLocalizedDescriptionKey: String(data: data, encoding: .utf8) ?? "Unknown error"])
        }
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let choices = json?["choices"] as? [[String: Any]],
              let first = choices.first,
              let message = first["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw NSError(domain: "OpenAICompatibleClient", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid response shape"])
        }
        return content
    }
}
