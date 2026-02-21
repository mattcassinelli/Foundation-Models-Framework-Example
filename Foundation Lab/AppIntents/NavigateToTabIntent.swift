//
//  NavigateToTabIntent.swift
//  FoundationLab
//
//  NAVIGATE: Open a main tab (view) — makes all top-level views Siri- and Shortcuts-addressable.
//  Pattern: App Intents–driven design (see app-intents-docs); intent performs work and drives UI.
//

import AppIntents

struct NavigateToTabIntent: AppIntent {
    static let title: LocalizedStringResource = "Open View"
    static let description = IntentDescription("Open a view in Foundation Lab (Examples, Tools, Schemas, Languages, or Settings).", categoryName: "Navigation")
    static let supportedModes: IntentModes = .foreground

    @Parameter(title: "View", default: .examples)
    var destination: TabDestination

    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$destination)")
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        NavigationCoordinator.shared.navigate(to: destination.tabSelection)
        return .result()
    }
}
