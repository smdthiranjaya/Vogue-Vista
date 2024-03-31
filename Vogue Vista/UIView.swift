import SwiftUI

struct SwiftUIWrapperView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIHostingController<StartupPageView>
    
    func makeUIViewController(context: Context) -> UIHostingController<StartupPageView> {

        let hostingController = UIHostingController(rootView: StartupPageView())
        return hostingController
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<StartupPageView>, context: Context) {

    }
}
