import SwiftUI

struct GiveawayCardView: View {
  let giveaway: Giveaway
  
  var body: some View {
    ZStack(alignment: .center) {
      AsyncImage(url: URL(string: giveaway.thumbnail)) { image in
        image
          .resizable()
          .scaledToFill()
          .cornerRadius(8)
      } placeholder: {
        ProgressView()
          .frame(width: 100, height: 70)
      }
      
      Color.black.opacity(0.6)
      
      VStack(alignment: .leading, spacing: 5) {
        Text(giveaway.title)
          .font(.headline)
          .bold()
          .foregroundColor(.white)
        
        Text(giveaway.platforms)
          .font(.subheadline)
          .foregroundColor(Color(.lightGray))
        
        Spacer()
        
        Text(giveaway.description)
          .font(.caption)
          .foregroundColor(Color(.lightGray))
          .lineLimit(3)
      }
      .padding(16)
    }
    .clipShape(.rect(cornerRadius: 8))
  }
}
