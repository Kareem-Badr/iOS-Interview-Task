# GamerPower giveaways Explorer

## Overview
This iOS application fetches and displays a list of game giveaways from the GamerPower giveaways API, also detailed giveaway information.

## Build Requirements
- Xcode 16.0+
- Swift 5.9+
- iOS 16.0+

## Setup and Installation
1. Clone the repository
2. Open the project in Xcode
3. Resolve Swift Package Manager dependencies
   - Xcode will automatically download and integrate the following packages:
     - Moya (Network abstraction layer)
     - Navigator (Navigation Support for SwiftUI.)
4. Build and run the project in Xcode

## Architecture and Design Decisions
- Implemented using SwiftUI
- MVVM (Model-View-ViewModel) architectural pattern
- Leverage Combine for reactive programming
- Dependency injection for improved testability

## API Integration
- Used GamerPower giveaways public API (https://www.gamerpower.com/api/giveaways/)
s
## Features
### Giveaways List Screen
### Giveaway Details Screen

## Assumptions Made
- Assumed standard internet connectivity
- Implemented basic error handling for network requests
- Assumed support for iOS 16.0+ devices

## Testing
- Plan:
  - Unit tests covering:
    - View model logic
  - Mock data used for consistent testing
  - Used XCTest framework for test implementation

## Future Improvements
- Implement coordinator design pattern
- Improve UI/UX
- Use Swift Testing framework for testing
