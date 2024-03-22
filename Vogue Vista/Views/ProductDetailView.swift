import SwiftUI

struct ProductDetailView: View {
    var products: [Product] // Assume this contains all variations of a product
    @State private var selectedColor: String
    @State private var selectedSize: String
    @State private var selectedProduct: Product?
    @State private var quantity: Int = 1
    
    // Unique colors and sizes for the picker
    private var colors: [String] {
        Set(products.map { $0.color }).sorted()
    }

    private var sizes: [String] {
        Set(products.map { $0.size }).sorted()
    }

    init(products: [Product]) {
        self.products = products
        // Initialize with the first available color and size
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
                    // Handle adding to cart here
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
        }
        .navigationBarTitle(Text(selectedProduct?.name ?? ""), displayMode: .inline)
    }

    private func selectProduct() {
        selectedProduct = products.first { $0.color == selectedColor && $0.size == selectedSize }
    }
}
