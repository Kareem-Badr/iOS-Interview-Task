import Foundation

// MARK: - Models
struct Giveaway: Codable, Identifiable, Hashable {
  let id: Int
  let title: String
  let worth: String?
  let thumbnail: String
  let image: String
  let description: String
  let platforms: String
  let endDate: String
  let users: Int?
  let status: String?
  let openGiveawayURL: String
  let type: String?
  let instructions: String?
  let publisher: String?
  let developers: String?
  let genre: String?
  let giveawayURL: String?
}

extension Giveaway {
  enum CodingKeys: String, CodingKey {
    case id, title, worth, thumbnail, image, description, platforms
    case endDate = "end_date"
    case users, status
    case openGiveawayURL = "open_giveaway_url"
    case type, instructions, publisher, developers, genre
    case giveawayURL = "giveaway_url"
  }
}

// MARK: - Errors
enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case decodingError
  case serverError(Int)
  case noInternet
  case timeout
  case unknown(Error)
  
  var localizedDescription: String {
    switch self {
    case .invalidURL:
      return "Invalid URL"
    case .invalidResponse:
      return "Invalid response from server"
    case .decodingError:
      return "Error decoding response"
    case .serverError(let code):
      return "Server error: \(code)"
    case .noInternet:
      return "No internet connection"
    case .timeout:
      return "Request timed out"
    case .unknown(let error):
      return error.localizedDescription
    }
  }
}
