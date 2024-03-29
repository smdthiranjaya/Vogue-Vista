import SwiftUI

@main
struct Vogue_VistaApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "userToken") != nil {
                HomeView()
            } else {
                SwiftUIWrapperView()
            }
        }
    }
}

