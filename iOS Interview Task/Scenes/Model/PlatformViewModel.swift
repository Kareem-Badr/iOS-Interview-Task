import Foundation

struct PlatformViewModel: Hashable, Identifiable {
  let id: String
  let platform: Platform
  let title: String
  
  init(platform: Platform) {
    self.id = UUID().uuidString
    self.platform = platform

    self.title = switch platform {
    case .all:
      "All"
      
    case .pc:
      "PC"
      
    case .steam:
      "Steam"
      
    case .epicGamesStore:
      "Epic Games Store"
      
    case .ubisoft:
      "Ubisoft"
      
    case .gog:
      "GOG"
      
    case .itchIO:
      "itch.io"
      
    case .ps4:
      "PS4"
      
    case .ps5:
      "PS5"
      
    case .xboxOne:
      "Xbox One"
      
    case .xboxSeriesX:
      "Xbox Series X/S"
      
    case .switch:
      "Switch"
      
    case .android:
      "Android"
      
    case .ios:
      "iOS"
      
    case .vr:
      "VR"
      
    case .battlenet:
      "Battle.net"
      
    case .origin:
      "Origin"
      
    case .drmFree:
      "DRM-Free"
      
    case .xbox360:
      "Xbox 360"
      
    case .unknown:
      "Unknown"
    }
  }
}
