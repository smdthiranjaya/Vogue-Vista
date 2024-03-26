
import SwiftUI

struct ProductDetailView: View {
    var products: [Product]
    @State private var selectedColor: String
    @State private var selectedSize: String
    @State private var selectedProduct: Product?
    @State private var quantity: Int = 1
    @State private var showingAddToCartAlert = false
    @State private var addToCartMessage = ""
    @State private var navigateToCart = false

    private let cartManager = CartManager()

    private var colors: [String] {
        Set(products.map { $0.color }).sorted()
    }

    private var sizes: [String] {
        Set(products.map { $0.size }).sorted()
    }

    init(products: [Product]) {
        self.products = products
        _selectedColor = State(initialValue: products.first?.color ?? "")
        _selectedSize = State(initialValue: products.first?.size ?? "")
        _selectedProduct = State(initialValue: products.first)
        
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: selectedProduct?.imageUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)

                Text(selectedProduct?.name ?? "")
                    .font(.title)
                
                Text(selectedProduct?.description ?? "")
                    .font(.body)

                Picker("Color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color).tag(color)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedColor) { newValue in
                    selectProduct()
                }

                Picker("Size", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) { size in
                        Text(size).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                
                Picker("Quantity", selection: $quantity) {
                    ForEach(1..<10) { count in
                        Text("\(count)").tag(count)
                    }
                }
                .pickerStyle(.wheel)
                
                .onChange(of: selectedSize) { newValue in
                    selectProduct()
                }

                if let price = selectedProduct?.price {
                    Text("Price: \(price)")
                        .font(.headline)
                }

                
                Button("Add to Cart") {
                    if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
                        guard let product = selectedProduct,
                              let price = Double(product.price) else { return }
                        addToCart(userId: userId, productId: product.id, color: selectedColor, size: selectedSize, quantity: quantity, price: price, name: product.name, imageUrl: product.imageUrl)
                    } else {
                        self.addToCartMessage = "Please login to add items to cart."
                        self.showingAddToCartAlert = true
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)

            
                .alert(isPresented: $showingAddToCartAlert) {
                    Alert(title: Text("Cart Update"), message: Text(addToCartMessage), dismissButton: .default(Text("OK")))
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
            NavigationLink(destination: ShoppingCartView(), isActive: $navigateToCart) { EmptyView() }
        }
        .navigationBarTitle(Text(selectedProduct?.name ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.navigateToCart = true
        }) {
            Image(systemName: "cart")
        })
    }

    private func selectProduct() {
        selectedProduct = products.first { $0.color == selectedColor && $0.size == selectedSize }
    }
    
    private func addToCart(userId: Int, productId: Int, color: String, size: String, quantity: Int, price: Double, name: String, imageUrl: String) {
        cartManager.addToCart(userId: userId, productId: productId, color: color, size: size, quantity: quantity, price: price, name: name, imageUrl: imageUrl) { success, message in
            DispatchQueue.main.async {
                self.addToCartMessage = message
                self.showingAddToCartAlert = true
            }
        }
    }
    
}
