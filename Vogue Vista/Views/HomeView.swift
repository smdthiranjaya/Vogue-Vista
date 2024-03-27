import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var products: [Product] = []
    @State private var showingAlert = false
    @State private var navigateToLogin = false
    @State private var navigateToProfile = false
    

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("Search...", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.top, 20)
                        .onSubmit {
                        
                            loadProducts()
                        }
                    List(products) { product in
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
                                    Text(product.description)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                    Text(product.price)
                                        .font(.subheadline)
                    
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())

                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        // Trigger navigation to Profile
                        self.navigateToProfile = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }
                },
                trailing: HStack {
                    Button("Log Out") {
                        showingAlert = true
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Yes")) {
                        UserDefaults.standard.removeObject(forKey: "userToken")
                        UserDefaults.standard.removeObject(forKey: "userId")
                        navigateToLogin = true
                    },
                    secondaryButton: .cancel()
                )
            }
            .fullScreenCover(isPresented: $navigateToLogin) {
                StartupPageViewRepresentable()
            }            .background(
                NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
                    EmptyView()
                }
            )
            .onAppear(perform: loadProducts)
        }
    }
    
    private func loadProducts() {
        let urlString = "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/products"
        guard let url = URL(string: urlString) else {
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