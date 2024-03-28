
import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var products: [Product] = []
    @State private var specialOffers: [Product] = []
    @State private var navigateToProfile = false
    @State private var navigateToCart = false

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
                                loadProducts()
                            }
                        
                        if !specialOffers.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Special Offers")
                                    .font(.headline)
                                    .padding()

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(specialOffers) { offer in
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
                        Text("New Arrivals")
                            .font(.headline)
                            .padding()
                        
                        ForEach(products) { product in
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
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                            .foregroundStyle(AppColor.appPrimary)
                    }
                },
                trailing: Button(action: {
                    self.navigateToCart = true
                }) {
                    Image(systemName: "cart")
                        .foregroundStyle(AppColor.appPrimary)
                }
            )
            .onAppear {
                loadProducts()
                loadSpecialOffers()
            }
        }
    }
    
    private func loadSpecialOffers() {
        guard let url = URL(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/special-offers") else {
            print("Invalid URL for special offers")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error with the response, unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }
            // Log the raw data for debugging
            if let data = data, let rawJSON = String(data: data, encoding: .utf8) {
                print("Received raw JSON: \(rawJSON)")
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.specialOffers = decodedResponse
                        print("Special offers loaded: \(self.specialOffers.count)")
                    }
                } catch let jsonError {
                    print("Failed to decode JSON for special offers: \(jsonError.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    

    private func loadProducts() {
        var components = URLComponents(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/products")

        var queryItems = [URLQueryItem]()
        if !searchText.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: searchText))
        }
        components?.queryItems = queryItems

        guard let url = components?.url else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
               
                print("Error fetching products: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        
                print("Error with the response, unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }

            if let data = data {
                do {
                    
                    let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                   
                    DispatchQueue.main.async {
                        self.products = decodedResponse
                    }
                } catch let jsonError {
                    
                    print("Failed to decode JSON: \(jsonError.localizedDescription)")
                }
            }
        }

        task.resume()
    }
}
