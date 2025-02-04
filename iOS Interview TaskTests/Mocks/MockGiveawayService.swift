@testable import iOS_Interview_Task
import Combine
import Foundation

// Mock GiveawayService
final class MockGiveawayService: GiveawayServiceProtocol {
  var getGiveawaysResult: Result<[Giveaway], NetworkError> = .failure(.unknown(MockError.unknown)) // Default to unknown NetworkError
  var getGiveawaysPlatformArgument: Platform?
  var getGiveawaysCallCount = 0
  
  func getGiveaways(platform: Platform?) -> AnyPublisher<[Giveaway], NetworkError> {
    getGiveawaysCallCount += 1
    getGiveawaysPlatformArgument = platform
    return getGiveawaysResult.publisher.eraseToAnyPublisher()
  }
}

enum MockError: Error, Equatable {
  case unknown
}

extension MockError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .unknown:
      return "Unknown error occurred."
    }
  }
}
