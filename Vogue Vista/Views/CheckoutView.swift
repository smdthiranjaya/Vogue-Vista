import SwiftUI

struct CheckoutView: View {
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    let deliveryFee = 5.00
    let serviceFee = 2.00
    @State private var address: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var showingPopup = false
    @Environment(\.presentationMode) var presentationMode
    @State private var promoCode: String = ""
    
    var body: some View {
        VStack {
            Text("Checkout")
                .font(.title)
                .bold()
                .padding(.top, 20)
                
            Image("checkoutProcessImage")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                        .iconPrefix(systemName: "house.fill")
                    
                    TextField("Card Number", text: $cardNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .iconPrefix(systemName: "creditcard.fill")
                    
                    TextField("Expiry Date", text: $expiryDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .iconPrefix(systemName: "calendar")
                    
                    TextField("CVV", text: $cvv)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .iconPrefix(systemName: "lock.fill")
                    
                    FeeRowView(title: "Total Fee", icon: "cart.fill", amount: checkoutViewModel.totalAmount)
                    FeeRowView(title: "Delivery Fee", icon: "bicycle", amount: deliveryFee)
                    FeeRowView(title: "Service Fee", icon: "wrench.and.screwdriver.fill", amount: serviceFee)
                    
                    TotalView(totalAmount: checkoutViewModel.totalAmount + deliveryFee + serviceFee)
                    
                    PromoCodeEntryField(promoCode: $promoCode)
                    
                    Button("Place Order") {
                        if validateInputs() {
                            placeOrder()
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(validateInputs() ? AppColor.appPrimary : AppColor.appPrimary.opacity(0.1))
                    .cornerRadius(40)
                    .padding()
                }
                .padding()
            }
            .padding()
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                showingPopup ? PopupMessageView(showingPopup: $showingPopup) : nil
            )
        }}
    
    private func validateInputs() -> Bool {
        return !address.isEmpty && !cardNumber.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty
    }

    private func placeOrder() {
        showingPopup = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showingPopup = false
            presentationMode.wrappedValue.dismiss()
        }
    }
}


struct FeeRowView: View {
    let title: String
    let icon: String
    let amount: Double
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppColor.appPrimary)
            Text(title)
            Spacer()
            Text("$\(amount, specifier: "%.2f")")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(AppColor.appPrimary)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
struct TotalView: View {
    let totalAmount: Double
    
    var body: some View {
        HStack {
            Image(systemName: "sum")
                .foregroundColor(AppColor.appPrimary)
            Text("Total")
                .font(.title2)
                .bold()
            Spacer()
            Text("$\(totalAmount, specifier: "%.2f")")
                .font(.title2)
                .bold()
        }
        .padding()
        .background(AppColor.appPrimary.opacity(0.1))
        .cornerRadius(10)
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


struct PopupMessageView: View {
    @Binding var showingPopup: Bool
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
            Text("Order Placed!")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(20)
        .padding(20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showingPopup = false
            }
        }
    }
}

struct PromoCodeEntryField: View {
    @Binding var promoCode: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Have a promo code?")
                .font(.headline)
            TextField("Promo Code", text: $promoCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 5)
        }
    }
}
