import SwiftUI

struct CheckoutView: View {
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                checkoutViewModel.checkoutCart()
            }) {
                Text("Checkout")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarHidden(true)    }
}
