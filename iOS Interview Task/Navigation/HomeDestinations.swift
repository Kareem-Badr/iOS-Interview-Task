import SwiftUI
import Navigator

enum HomeDestinations: Hashable {
  case detailView(giveaway: Giveaway)
}

extension HomeDestinations: NavigationDestination {
  var view: some View {
    switch self {
    case let .detailView(giveaway):
      GiveawayDetailView(giveaway: giveaway)
    }
  }
}
