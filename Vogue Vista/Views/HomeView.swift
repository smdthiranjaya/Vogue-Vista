
import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var products: [Product] = []
    @State private var specialOffers: [Product] = []
    @State private var navigateToProfile = false
    @State private var navigateToCart = false
    @ObservedObject var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ScrollView (showsIndicators: false){
                    VStack {
                        
                        HStack{
                            Image("checkoutProcessImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text("Welcome to Vogue Vista!")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                            
                        }
                        
                        Text("Discover your unique style with us. Explore the latest trends and timeless pieces that make you feel at home in the world of fashion.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing, .bottom])
                        
                        TextField("Search...", text: $searchText)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.top, 20)
                            .onSubmit {
                                viewModel.loadProducts(searchText: searchText)
                            }
                        
                        if !viewModel.specialOffers.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Special Offers")
                                    .font(.headline)
                                    .padding()
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.specialOffers) { offer in
                                            VStack(alignment: .leading) {
                                                AsyncImage(url: URL(string: offer.imageUrl)) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Color.gray
                                                }
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(5)
                                                
                                                Text(offer.name)
                                                    .font(.headline)
                                                Text("$\(offer.price)")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundStyle(AppColor.appPrimary)
                                            }
                                            .padding(.leading, 10)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        
                        Divider()
                        
                        Text("New Arrivals")
                            .font(.headline)
                            .padding()
                        
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductDetailView(products: [product])) {
                                HStack {
                                    AsyncImage(url: URL(string: product.imageUrl)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(5)
                                    
                                    VStack(alignment: .leading) {
                                        Text(product.name)
                                            .font(.headline)
                                            .foregroundStyle(Color.black)
                                        Text(product.description)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .foregroundStyle(Color.black)
                                        Text("$\(product.price)")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundStyle(AppColor.appPrimary)
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                NavigationLink(destination: ShoppingCartView(), isActive: $navigateToCart) { EmptyView() }.hidden()
                NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) { EmptyView() }.hidden()
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        self.navigateToProfile = true
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(AppColor.appPrimary)
                    }
                },
                trailing: Button(action: {
                    self.navigateToCart = true
                }) {
                    Image(systemName: "cart.fill")
                        .foregroundStyle(AppColor.appPrimary)
                }
            )
            .onAppear {
                viewModel.loadProducts()
                viewModel.loadSpecialOffers()
            }
        }
    }
}
