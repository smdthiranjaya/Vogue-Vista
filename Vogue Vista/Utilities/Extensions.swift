
import SwiftUI

enum AppColor {
    static let appPrimary = Color(red: 38 / 255, green: 34 / 255, blue: 97 / 255)
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension View {
    func iconPrefix(systemName: String) -> some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(AppColor.appPrimary.opacity(0.8))
            self
        }
    }
}
