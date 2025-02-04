import SwiftUI

// MARK: - Main View
struct GiveawayDetailView: View {
  @Environment(\.dismiss) private var dismiss
  let giveaway: Giveaway
  
  var body: some View {
    makeContent()
  }
}

// MARK: - Content Layout
private extension GiveawayDetailView {
  func makeContent() -> some View {
    ScrollView {
      VStack(alignment: .leading) {
        headerSection
        detailsSection
      }
    }
    .ignoresSafeArea(.all, edges: .top)
    .toolbar(.hidden, for: .navigationBar)
    .overlay(alignment: .topLeading) {
      makeBackButton()
    }
  }
  
  var headerSection: some View {
    ZStack(alignment: .bottom) {
      bannerImage
      bannerOverlay
      titleRow
    }
    .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
  }
  
  var detailsSection: some View {
    VStack(alignment: .leading, spacing: 20) {
      statsRow
      platformInfo
      endDateInfo
      descriptionInfo
    }
    .padding(.horizontal, 50)
    .padding(.vertical, 20)
  }
}

// MARK: - Header Components
private extension GiveawayDetailView {
  var bannerImage: some View {
    AsyncImage(url: URL(string: giveaway.image)) { image in
      image
        .resizable()
        .scaledToFill()
    } placeholder: {
      ProgressView()
    }
    .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
    .clipped()
  }
  
  var bannerOverlay: some View {
    Color.black.opacity(0.4)
      .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
  }
  
  var titleRow: some View {
    HStack(alignment: .bottom, spacing: 8) {
      Text(giveaway.title)
        .font(.title2)
        .bold()
        .foregroundColor(.white)
        .lineLimit(2)
        .padding(.leading, 16)
      
      Image(systemName: "checkmark.circle.fill")
        .foregroundColor(.green)
        .font(.title3)
      
      Spacer()
      
      getItButton
        .padding(.trailing, 16)
    }
    .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
    .padding(.bottom, 16)
  }
  
  var getItButton: some View {
    Button("Get it") {
      if let url = URL(string: giveaway.openGiveawayURL) {
        UIApplication.shared.open(url)
      }
    }
    .buttonStyle(TextButtonStyle())
    .controlSize(.small)
  }
}

// MARK: - Details Components
private extension GiveawayDetailView {
  var statsRow: some View {
    HStack(spacing: 25) {
      infoItem(iconName: "dollarsign.square.fill", value: giveaway.worth ?? "N/A")
      infoItem(iconName: "person.2.fill", value: "\(giveaway.users ?? 0)")
      infoItem(iconName: "gamecontroller.fill", value: giveaway.type ?? "N/A")
    }
    .padding(.vertical, 15)
  }
  
  var platformInfo: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("Platforms")
        .font(.headline)
        .foregroundColor(Color(.label))
      Text(giveaway.platforms)
        .foregroundColor(.secondary)
        .font(.system(size: 15, design: .default))
    }
  }
  
  var endDateInfo: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("Giveaway End Date")
        .font(.headline)
        .foregroundColor(Color(.label))
      Text(giveaway.endDate)
        .foregroundColor(.secondary)
        .font(.system(size: 15, design: .default))
    }
  }
  
  var descriptionInfo: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("Description")
        .font(.headline)
        .foregroundColor(Color(.label))
      Text(giveaway.description)
        .foregroundColor(.secondary)
        .font(.system(size: 14, design: .default))
        .lineLimit(nil)
    }
    .padding(.top, 2)
  }
}

// MARK: - Supporting Views
private extension GiveawayDetailView {
  func infoItem(iconName: String, value: String) -> some View {
    VStack(spacing: 8) {
      Image(systemName: iconName)
        .font(.title)
        .foregroundColor(.black)
      Text(value)
        .font(.headline)
        .bold()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
  }
  
  func makeBackButton() -> some View {
    Button(
      action: { dismiss() },
      label: {
        ZStack {
          Circle()
            .fill(Color.black)
            .frame(width: 28, height: 28)
          
          Image(systemName: "arrow.left.circle.fill")
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(.white)
        }
      }
    )
    .buttonStyle(.plain)
    .padding(.top, 16)
    .padding(.horizontal, 16)
  }
}

// MARK: - Button Style
struct TextButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.body.bold())
      .foregroundColor(.black)
      .opacity(configuration.isPressed ? 0.7 : 1.0)
      .padding(6)
      .background {
        Color.white
      }
      .clipShape(.rect(cornerRadius: 10))
  }
}
