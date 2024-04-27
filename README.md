## Student ID : COBSCCOMP4Y222P-033

![Vogue Vista Mobile App](https://github.com/smdthiranjaya/Vogue-Vista-Server/assets/37227365/4b367f9c-75d6-4f64-9525-d31e40c765fa)

### Figma All In One:
https://www.figma.com/file/ULPbKSl3hREytQvPVonPVu/Vogue-Vista-Mobile-App?type=design&node-id=48%3A225&mode=design&t=ad62VOj52rmUgqOf-1
### Figma Low Fidelity Link:
https://www.figma.com/file/ULPbKSl3hREytQvPVonPVu/Vogue-Vista-Mobile-App?type=design&node-id=1-3&mode=design
### Figma High Fidelity Link:
https://www.figma.com/file/ULPbKSl3hREytQvPVonPVu/Vogue-Vista-Mobile-App?type=design&node-id=1-4&mode=design
### Figma Prototype Link:
https://www.figma.com/file/ULPbKSl3hREytQvPVonPVu/Vogue-Vista-Mobile-App?type=design&node-id=1-5&mode=design
### Swift IOS Mobile App (Fontend) GitHub Link:
https://github.com/smdthiranjaya/Vogue-Vista
### Backend Server Repository Link:
https://github.com/smdthiranjaya/Vogue-Vista-Server
### Post Man Public Collection:
https://www.postman.com/spacecraft-cosmologist-43205865/workspace/public-ios-vogue-vista
### Video Demonstration:
https://drive.google.com/drive/folders/1lFHFPKkMToYiqMC5lxAA4oXZSdc5ngHH?usp=sharing

# Vogue Vista

Vogue Vista is an iOS application designed for an online clothing brand. It allows users to browse, search, and purchase clothing items directly from their iOS devices. The app utilizes Auth0 for user authentication and Supabase for backend services.

![7](https://github.com/smdthiranjaya/Vogue-Vista-Server/assets/37227365/9d10584f-f44f-4921-8eb2-dcdfd8b8be41)
![8](https://github.com/smdthiranjaya/Vogue-Vista-Server/assets/37227365/22a3b4ab-6805-4aee-baef-972b4aeaca01)

## Introduction

In this digital era, where ease of use and effectiveness are paramount, our initiative embarked on creating an innovative iOS application for a leading-edge fashion brand. Engineered with the latest technology and a focus on user driven design philosophies, this app seeks to revolutionize the conventional shopping experience, making it fluid and delightful for fashion aficionados. By harnessing the powerful features of Heroku, PostgreSQL, and a suite of backend technologies, we have developed a platform that surpasses the expectations of modern, discerning consumers.

## Problem

Online clothing shopping often faces challenges with navigation, product search, and checkout processes, leading to customer dissatisfaction.

## Solution

An iOS application for an online clothing brand, enhancing the shopping experience with a user-friendly interface, streamlined browsing, secure user authentication, and efficient checkout flows. Hosted on Heroku, it utilizes a PostgreSQL database for robust performance.

## Key Features

Our application is built on a foundation of key features and technologies that distinguish it in the digital marketplace:
- Heroku and GitHub Integration: Utilizing Heroku for hosting our backend Node.js server and integrating with GitHub for continuous deployment allows for streamlined development and deployment processes.
- Heroku PostgreSQL Database: The use of Heroku PostgreSQL offers a reliable and scalable database solution, ensuring efficient data management throughout the application.
- Robust Backend Technologies: Incorporating Express for server-side logic, pg pool for database interaction, bcrypt for secure password handling, and JSON Web Tokens for authentication, we’ve established a secure and efficient backend structure.
- Postman and Sourcetree Utilization: Leveraging Postman for API testing and Sourcetree for version control, our development process is both efficient and manageable.
- Postico 2 for Database Management: Employing Postico 2 provides a user-friendly interface for database management, enhancing our data handling capabilities.

## App Flow

![Modern App Portfolio Mockup Presentation](https://github.com/smdthiranjaya/Vogue-Vista-Server/assets/37227365/d6c7cde4-3825-482e-99b4-bf6a4ebc69e6)
![Modern App Portfolio Mockup Presentation (1)](https://github.com/smdthiranjaya/Vogue-Vista-Server/assets/37227365/e56c8e05-1e2b-4a2e-b96d-f717ccee526f)

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
