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
}
