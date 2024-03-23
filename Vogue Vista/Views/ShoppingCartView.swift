import SwiftUI

struct ShoppingCartView: View {
    @ObservedObject var viewModel = ShoppingCartViewModel()
    // Initialize the CheckoutViewModel for passing to CheckoutView
    let checkoutViewModel = CheckoutViewModel()

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
                    Text("Total: ")
                        .font(.headline)
                    Spacer()
                
                    Text("$\(viewModel.totalPrice)")
                        .font(.headline)
                        .bold()
                    
                }
                .padding()
                
                // Checkout button - navigates to CheckoutView
                NavigationLink(destination: CheckoutView(checkoutViewModel: checkoutViewModel)) {
                    Text("Checkout")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .padding()
            }
            .navigationBarTitle("Shopping Cart", displayMode: .inline)
        }
        .onAppear {
            viewModel.fetchCart()
        }
    }
}
