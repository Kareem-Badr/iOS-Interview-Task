import SwiftUI
import Navigator

@main
struct iOS_Interview_TaskApp: App {
  private let service = DefaultGiveawayService()
  
  var body: some Scene {
    WindowGroup {
      ManagedNavigationStack {
        HomeView(viewModel: HomeViewModel(giveawayService: service))
          .navigationDestination(HomeDestinations.self)
      }
    }
  }
}
