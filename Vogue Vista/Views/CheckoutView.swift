import SwiftUI

struct CheckoutView: View {
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    @ObservedObject var viewModel = ShoppingCartViewModel()
    
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
        
        ScrollView (showsIndicators: false){
            VStack(alignment: .leading, spacing: 15) {
                Text("Checkout")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                
                TextField("Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 5)
                    .iconPrefix(systemName: "location.fill")
                
                TextField("Card Number", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .iconPrefix(systemName: "creditcard.fill")
                
                TextField("Expiry Date", text: $expiryDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .iconPrefix(systemName: "calendar")
                
                TextField("CVV", text: $cvv)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .iconPrefix(systemName: "lock.fill")
                
                PromoCodeEntryField(promoCode: $promoCode)
                
                FeeRowView(title: "Subtotal", icon: "cart.fill", amount: checkoutViewModel.totalAmount)
                FeeRowView(title: "Delivery Fee", icon: "bicycle", amount: deliveryFee)
                FeeRowView(title: "Service Fee", icon: "wrench.and.screwdriver.fill", amount: serviceFee)
                
                TotalView(totalAmount: checkoutViewModel.totalAmount + deliveryFee + serviceFee)
                
                Text("By completing your purchase, you agree to our payment terms: All sales are final, payments are processed securely, and personal data is handled in accordance with our privacy policy. For support, please contact customer service.")
                    .font(.caption2)
                    .padding(.top, 20)
                
            }
            .padding()
            
            Button("Place Order") {
                if validateInputs() {
                    placeOrder()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(validateInputs() ? AppColor.appPrimary : AppColor.appPrimary.opacity(0.1))
            .cornerRadius(10)
            .padding()
        }.onAppear {
            viewModel.fetchCart()
        }
        .padding()
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            showingPopup ? PopupMessageView(showingPopup: $showingPopup) : nil
        )
    }
    
    private func validateInputs() -> Bool {
        return !address.isEmpty && !cardNumber.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty
    }
    
    private func placeOrder() {
        guard let userId = UserDefaults.standard.object(forKey: "userId") as? Int else {
            print("User ID not found")
            return
        }
        let orderDetails = Order( id: 1, userId: userId, items: viewModel.items, address: address, cardNumber: cardNumber, totalAmount: checkoutViewModel.totalAmount + deliveryFee + serviceFee, createdAt: getCurrentDate(), status: "Pending")
        
        sendOrderToServer(orderDetails)
        
        showingPopup = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showingPopup = false
            presentationMode.wrappedValue.dismiss()
        }
    }
}

func sendOrderToServer(_ orderDetails: Order) {
    guard let url = URL(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/order/create") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(orderDetails)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending order: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
        }.resume()
    } catch {
        print("Error encoding order details: \(error)")
    }
}


private func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: Date())
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
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
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
        .padding(100)
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
