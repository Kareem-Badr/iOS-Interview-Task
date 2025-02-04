import Navigator
import SwiftUI

// MARK: - Theme
struct Theme {
  static let primaryColor = Color.blue.opacity(0.7)
  static let secondaryColor = Color.gray.opacity(0.2)
  static let padding = EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
}

// MARK: - HomeView
struct HomeView: View {
  private let viewModelInput: HomeViewModel.Input
  @StateObject private var viewModelOutput: HomeViewModel.Output
  @State private var selectedPlatform: Platform = .all
  
  init(viewModel: HomeViewModel) {
    viewModelInput = viewModel.input
    _viewModelOutput = StateObject(wrappedValue: viewModel.output)
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 20) {
          epicGamesSection
          categorySection
          giveawaysList
        }
        .padding(Theme.padding)
      }
      .navigationTitle("Game Giveaways")
      .refreshable {
        viewModelInput.refreshTrigger.send()
      }
    }
    .onAppear {
      viewModelInput.onAppearTrigger.send()
    }
  }
  
  private var epicGamesSection: some View {
    Group {
      switch viewModelOutput.epicGamesState {
      case .loaded(let giveaways) where !giveaways.isEmpty:
        VStack(alignment: .leading) {
          Text("Epic Games Giveaways")
            .font(.headline)
          EpicGamesCarouselView(giveaways: giveaways)
        }
      case .error(let message):
        ErrorView(message: message)
      case .loading:
        ProgressView()
      default:
        EmptyView()
      }
    }
  }
  
  private var categorySection: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(viewModelOutput.platformsViewModels, id: \.id) { platformViewModel in
          CategoryButton(
            title: platformViewModel.title,
            isSelected: selectedPlatform == platformViewModel.platform
          ) {
            selectedPlatform = platformViewModel.platform
            viewModelInput.filterTrigger.send(platformViewModel.platform)
          }
        }
      }
    }
  }
  
  private var giveawaysList: some View {
    Group {
      switch viewModelOutput.giveawaysState {
      case .loading:
        ProgressView("Loading giveaways...")
      case .loaded(let giveaways):
        if giveaways.isEmpty {
          Text("No giveaways found")
            .foregroundColor(.secondary)
        } else {
          LazyVStack(spacing: 16) {
            makeGiveawaysList(giveaways: (giveaways))
          }
        }
      case .error(let message):
        ErrorView(message: message)
      case .idle:
        EmptyView()
      }
    }
  }
  
  private func makeGiveawaysList(giveaways: [Giveaway]) -> some View {
    ForEach(giveaways) { giveaway in
      NavigationLink(value: HomeDestinations.detailView(giveaway: giveaway)) {
        GiveawayCardView(giveaway: giveaway)
      }
    }
  }
}

// MARK: - CategoryButton
struct CategoryButton: View {
  let title: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .underline(isSelected, color: .black)
        .foregroundColor(isSelected ? .black : .gray)
        .baselineOffset(8)
        .bold()
    }
  }
}

// MARK: - ErrorView
struct ErrorView: View {
  let message: String
  
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: "exclamationmark.triangle")
        .font(.largeTitle)
        .foregroundColor(.red)
      Text(message)
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
    }
    .padding()
  }
}
