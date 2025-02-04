import Foundation
import Combine
import Moya
import CombineMoya

protocol GiveawayServiceProtocol {
  func getGiveaways(platform: Platform?) -> AnyPublisher<[Giveaway], NetworkError>
}

final class DefaultGiveawayService: GiveawayServiceProtocol {
  private let provider: MoyaProvider<GamerPowerAPI>
  
  init(provider: MoyaProvider<GamerPowerAPI>? = nil) {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    
    self.provider = provider ?? MoyaProvider<GamerPowerAPI>(
      session: Session(configuration: configuration), plugins: [NetworkLoggerPlugin()]
    )
  }
  
  func getGiveaways(platform: Platform?) -> AnyPublisher<[Giveaway], NetworkError> {
    provider.requestPublisher(.giveaways(platform: platform?.rawValue))
      .filterSuccessfulStatusCodes()
      .map(\.data)
      .decode(type: [Giveaway].self, decoder: JSONDecoder())
      .mapError { error -> NetworkError in
        switch error {
        case is DecodingError:
          return .decodingError
        case let MoyaError.statusCode(response):
          return .serverError(response.statusCode)
        case MoyaError.underlying(let nsError as NSError, _):
          switch nsError.code {
          case NSURLErrorNotConnectedToInternet:
            return .noInternet
          case NSURLErrorTimedOut:
            return .timeout
          default:
            return .unknown(error)
          }
        default:
          return .unknown(error)
        }
      }
      .eraseToAnyPublisher()
  }
}
