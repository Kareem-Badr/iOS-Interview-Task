import XCTest
@testable import iOS_Interview_Task
import Combine

final class HomeViewModelTests: XCTestCase {
  var mockGiveawayService: MockGiveawayService!
  var viewModel: HomeViewModel!
  var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    super.setUp()
    mockGiveawayService = MockGiveawayService()
    viewModel = HomeViewModel(giveawayService: mockGiveawayService)
    cancellables = .init()
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    mockGiveawayService = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_onAppearTrigger_fetchesEpicGamesAndAllGiveaways() {
    // Given
    let testGiveaways: [Giveaway] = [
      .testableInstance(id: 1, title: "Game 1"),
      .testableInstance(id: 2, title: "Game 2")
    ]
    
    mockGiveawayService.getGiveawaysResult = .success(testGiveaways)
    
    let epicGamesStateExpectation = expectation(description: "Epic Games State Loaded")
    let giveawaysStateExpectation = expectation(description: "Giveaways State Loaded")
    
    viewModel.output.$epicGamesState
      .dropFirst() // Ignore initial .idle state
      .sink { state in
        if case .loaded(let giveaways) = state, giveaways == testGiveaways {
          epicGamesStateExpectation.fulfill()
        }
      }
      .store(in: &cancellables)
    
    viewModel.output.$giveawaysState
      .dropFirst() // Ignore initial .idle state
      .sink { state in
        if case .loaded(let giveaways) = state, giveaways == testGiveaways {
          giveawaysStateExpectation.fulfill()
        }
      }
      .store(in: &cancellables)
    
    
    // When
    viewModel.input.onAppearTrigger.send()
    
    // Then
    wait(for: [epicGamesStateExpectation, giveawaysStateExpectation], timeout: 2.0)
    XCTAssertEqual(mockGiveawayService.getGiveawaysCallCount, 2, "getGiveaways should be called twice")
  }
  
  func test_onAppearTrigger_fetchesEpicGamesAndAllGiveaways_usingRecorder() {
    // Given
    let testGiveaways: [Giveaway] = [
      .testableInstance(id: 1, title: "Game 1"),
      .testableInstance(id: 2, title: "Game 2")
    ]

    mockGiveawayService.getGiveawaysResult = .success(testGiveaways)
    
    let recorder = mockGiveawayService.getGiveaways(platform: .ios).recorder(count: 1)
    
    
    // When
    viewModel.input.onAppearTrigger.send()
    let records = recorder.record()
    
    // Then
    XCTAssertEqual(records.first, testGiveaways)
    XCTAssertEqual(mockGiveawayService.getGiveawaysCallCount, 2)
  }
}
