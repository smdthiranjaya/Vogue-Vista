import SwiftUI

@main
struct Vogue_VistaApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "token") != nil {
                HomeView()
            } else {
                StartupPageViewRepresentable()
            }
        }
    }
}

