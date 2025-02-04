import SwiftUI

// MARK: - EpicGamesCarouselView
struct EpicGamesCarouselView: View {
  let giveaways: [Giveaway]
  
  var body: some View {
    TabView {
      ForEach(giveaways) { giveaway in
        NavigationLink(value: HomeDestinations.detailView(giveaway: giveaway)) {
          GiveawayCardView(giveaway: giveaway)
        }
      }
    }
    .tabViewStyle(.page)
    .frame(height: 200)
    .clipShape(.rect(cornerRadius: 8))
  }
}
