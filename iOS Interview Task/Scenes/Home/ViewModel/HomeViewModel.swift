import SwiftUI
import Combine

enum ViewState<T: Equatable>: Equatable {
  case idle
  case loading
  case loaded(T)
  case error(String)
}

final class HomeViewModel {
  final class Input {
    let onAppearTrigger: UIEvent<Void> = PassthroughSubject<Void, Never>()
    let refreshTrigger: UIEvent<Void> = PassthroughSubject<Void, Never>()
    let filterTrigger = CurrentValueSubject<Platform?, Never>(nil)
  }
  
  final class Output: ObservableObject {
    @Published fileprivate(set) var giveawaysState: ViewState<[Giveaway]> = .idle
    @Published fileprivate(set) var epicGamesState: ViewState<[Giveaway]> = .idle
    @Published fileprivate(set) var platformsViewModels = Platform.allCases.map(PlatformViewModel.init)
  }
  
  // MARK: DI
  private let giveawayService: GiveawayServiceProtocol
  
  // MARK: Input / Output
  let input: Input
  let output: Output
  
  // MARK: Properties
  private var cancellables = Set<AnyCancellable>()
  private var fetchEpicGamesGiveawaysCancellable: Cancellable?
  private var fetchGiveawaysCancellable: Cancellable?

  // MARK: Init
  init(giveawayService: GiveawayServiceProtocol) {
    input = .init()
    output = .init()
    
    self.giveawayService = giveawayService
    
    observeViewDidLoadTrigger()
    observeRefreshTrigger()
    observeFilterTrigger()
  }
}


// MARK: Observers
extension HomeViewModel {
  private func observeViewDidLoadTrigger() {
    input
      .onAppearTrigger
      .sink { [weak self] in
        guard let self else { return }

        fetchEpicGamesGiveaways()
        fetchGiveaways(platform: input.filterTrigger.value)
      }
      .store(in: &cancellables)
  }
  
  private func observeRefreshTrigger() {
    input
      .refreshTrigger
      .sink { [weak self] in
        guard let self else { return }
        
        fetchEpicGamesGiveaways()
        fetchGiveaways(platform: input.filterTrigger.value)
      }
      .store(in: &cancellables)
  }
  
  private func observeFilterTrigger() {
    input
      .filterTrigger
      .dropFirst()
      .sink { [weak self] platform in
        guard let self else { return }
        fetchGiveaways(platform: platform)
      }
      .store(in: &cancellables)
  }
}

// MARK: Network
extension HomeViewModel {
  private func fetchData() {
    fetchEpicGamesGiveaways()
    fetchGiveaways(platform: input.filterTrigger.value)
  }
  
  private func fetchGiveaways(platform: Platform?) {
    output.giveawaysState = .loading
    
    fetchGiveawaysCancellable?.cancel()
    
    let platform = platform == .all ? nil : platform
    
    fetchGiveawaysCancellable = giveawayService.getGiveaways(platform: platform)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          if case .failure(let error) = completion {
            self?.output.giveawaysState = .error(error.localizedDescription)
          }
        },
        receiveValue: { [weak self] giveaways in
          self?.output.giveawaysState = .loaded(giveaways)
        }
      )
  }
  
  private func fetchEpicGamesGiveaways() {
    output.epicGamesState = .loading
    
    fetchEpicGamesGiveawaysCancellable?.cancel()
    
    fetchEpicGamesGiveawaysCancellable = giveawayService.getGiveaways(platform: Platform.epicGamesStore)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          if case .failure(let error) = completion {
            self?.output.epicGamesState = .error(error.localizedDescription)
          }
        },
        receiveValue: { [weak self] giveaways in
          self?.output.epicGamesState = .loaded(giveaways)
        }
      )
  }
}
