## Student ID : COBSCCOMP4Y222P-033

![Vogue Vista Mobile App](https://github.com/smdthiranjaya/Vogue-Vista/assets/37227365/abec2f10-d8f0-4739-b421-886188848525)

### NodeJS Sever (Backend) GitHub Link:
https://github.com/smdthiranjaya/Vogue-Vista-Server

### Post Man API Public Collection Link:
https://www.postman.com/spacecraft-cosmologist-43205865/workspace/public-ios-vogue-vista


# Vogue Vista

Vogue Vista is an iOS application designed for an online clothing brand. It allows users to browse, search, and purchase clothing items directly from their iOS devices. The app utilizes Auth0 for user authentication and Supabase for backend services.

## Features

- User Authentication with Auth0
- Product Listings
- Product Detail Views
- Shopping Cart Management
- Checkout Functionality
- Responsive and Intuitive User Interface

## Installation

Before you can run the project, you need to follow these setup steps:

### Prerequisites

- Xcode 12 or later
- CocoaPods or Swift Package Manager
- An Auth0 account
- A Supabase project

### Setting Up Auth0

1. Create a new application in your Auth0 dashboard.
2. Note down your Client ID and Domain.
3. Configure callback URLs, logout URLs, and allowed web origins as per your iOS app's settings.

### Setting Up Supabase

1. Create a new project in Supabase.
2. Note down the API URL and anon key from the project settings.

### Configuring the iOS Project

1. Clone the repository:

```bash
git clone https://github.com/smdthiranjaya/Vogue-Vista.git
cd voguevista
````
If using CocoaPods, run:
```bash
pod install
````

Open the .xcworkspace file in Xcode.

2. Add your Auth0 ClientId and Domain to the Auth0.plist file.

3. Update the Supabase URL and anon key in the application's network configuration.

### Usage

To run the application, open the project in Xcode and run it on a simulator or a physical device.

- **Login/Signup:** Users can sign up or log in using the Auth0 integration.
- **Browse Products:** Users can browse the list of products available for purchase.
- **Product Details:** Users can view detailed information about a product.
- **Add to Cart:** Users can add products to their shopping cart.
- **Checkout:** Users can proceed to checkout to complete their purchase.

### Contributing

Contributions to Vogue Vista are welcome! Please read the CONTRIBUTING.md for guidelines on how to contribute to this project.

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Acknowledgments

- Auth0 for authentication services.
- Supabase for providing the backend as a service.
- All the open-source libraries and tools used in this project.
