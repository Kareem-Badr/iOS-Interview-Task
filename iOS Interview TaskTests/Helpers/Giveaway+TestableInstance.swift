@testable import iOS_Interview_Task

extension Giveaway {
  static func testableInstance(
    id: Int = 1,
    title: String = "Test Giveaway",
    worth: String? = "N/A",
    thumbnail: String = "",
    image: String = "",
    description: String = "A test giveaway",
    platforms: String = "PC (Windows)",
    endDate: String = "2024-01-01",
    users: Int? = 1000,
    status: String? = "Active",
    openGiveawayURL: String = "",
    type: String? = "game",
    instructions: String? = nil,
    publisher: String? = nil,
    developers: String? = nil,
    genre: String? = nil,
    giveawayURL: String? = nil
  ) -> Giveaway {
    Giveaway(
      id: id,
      title: title,
      worth: worth,
      thumbnail: thumbnail,
      image: image,
      description: description,
      platforms: platforms,
      endDate: endDate,
      users: users,
      status: status,
      openGiveawayURL: openGiveawayURL,
      type: type,
      instructions: instructions,
      publisher: publisher,
      developers: developers,
      genre: genre,
      giveawayURL: giveawayURL
    )
  }
}
