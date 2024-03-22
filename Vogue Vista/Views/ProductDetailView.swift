import SwiftUI

struct ProductDetailView: View {
    var product: Product
    @State private var quantity: Int = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)

                Text(product.name)
                    .font(.title)
                
                Text(product.description)
                    .font(.body)

                HStack {
                    Text("Price: \(product.price)")
                        .font(.headline)
                    
                    Spacer()

                    Picker("Quantity", selection: $quantity) {
                        ForEach(1..<10) { count in
                            Text("\(count)").tag(count)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Button("Add to Cart") {
                    // Handle adding to cart here
                    print("Added \(quantity) of \(product.name) to cart")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
        }
        .navigationBarTitle(Text(product.name), displayMode: .inline)
    }
}
