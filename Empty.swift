import SwiftUI
import Auth0
import MongoKitten

struct LoginView: View {
  @State private var isAuthenticated = false
  private var database: MongoDatabase? // Ensure this matches your MongoKitten version

  init() {
    do {
      let client = try MongoClient("your_mongodb_connection_string")
      self.database = client.database("your_database_name")
    } catch {
      print("Failed to connect to MongoDB: \(error.localizedDescription)")
    }
  }

  // Body and other methods remain the same...

  func storeOrUpdateUserInMongo(userId: String) {
    guard let db = database else { return }
    let usersCollection = db["users"]
    let query: Document = ["userId": userId] // Ensure this is a Document
    let update: Document = ["$set": ["userId": userId]] // This should also be a Document
    do {
      if try usersCollection.findOne(query) == nil { // Remove 'where:'
        // If user does not exist, insert new document
        try usersCollection.insert(["userId": userId]) // Make sure this is correct
      } else {
        // If user exists, update existing document
        try usersCollection.updateOne(filter: query, to: update) // Adjust parameters as needed
      }
      print("User stored/updated in MongoDB successfully")
    } catch {
      print("Failed to store/update user in MongoDB: \(error.localizedDescription)")
    }
  }
}
