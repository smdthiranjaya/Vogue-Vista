
import SwiftUI

struct ShoppingCartView: View {
    @ObservedObject var viewModel = ShoppingCartViewModel()
    @State private var showingCheckout = false

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.items) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("\(item.quantity) x $\(item.price) - \(item.color), \(item.size)")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        Text("$\(String(format: "%.2f", Double(item.price)! * Double(item.quantity)))")
                            .bold()
                        
                        Button(action: {
                            viewModel.removeItemFromCart(itemId: item.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }

                    }
                    
                }
                HStack {
                    Text("Subtotal: ")
                        .font(.headline)
                    Spacer()
                
                    Text("$\(viewModel.totalPrice)")
                        .font(.headline)
                        .bold()
                    
                }
                .padding()
                
                Button("Checkout") {
                    // This triggers the modal presentation
                    showingCheckout = true
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(AppColor.appPrimary)
                .cornerRadius(40)
                .padding()
            }
            .navigationBarTitle("Shopping Cart", displayMode: .inline)
            .sheet(isPresented: $showingCheckout) {
                // Assuming CheckoutView initialization with necessary parameters
                CheckoutView(checkoutViewModel: CheckoutViewModel(totalAmount: Double(viewModel.totalPrice) ?? 0.0))
            }
        }
        .onAppear {
            viewModel.fetchCart()
        }
    }
}
