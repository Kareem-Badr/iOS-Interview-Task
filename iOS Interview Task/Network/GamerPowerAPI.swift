import Foundation
import Combine
import Moya

enum GamerPowerAPI {
  case giveaways(platform: String?)
}

extension GamerPowerAPI: TargetType {
  var baseURL: URL {
    URL(string: "https://www.gamerpower.com/api")!
  }
  
  var path: String {
    switch self {
    case .giveaways:
      return "/giveaways"
    }
  }
  
  var method: Moya.Method {
    .get
  }
  
  var task: Moya.Task {
    switch self {
    case .giveaways(let platform):
      var params: [String: Any] = [:]
      if let platform = platform {
        params["platform"] = platform
      }
      return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String: String]? {
    ["Content-type": "application/json"]
  }
}
