import SwiftUI

struct ShoppingCartView: View {
    @ObservedObject var viewModel = ShoppingCartViewModel()

    var body: some View {
        List(viewModel.items) { item in
            // Your UI for displaying cart items
            Text("\(item.quantity) x \(item.id) - \(item.color), \(item.size)")
        }
        .onAppear {
            viewModel.fetchCart()
        }
    }
}
