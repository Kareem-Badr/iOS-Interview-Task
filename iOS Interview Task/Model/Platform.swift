enum Platform: String, CaseIterable, Decodable, Hashable {
  case all
  case pc
  case steam
  case epicGamesStore = "epic-games-store"
  case ubisoft = "Ubisoft"
  case gog
  case itchIO = "itchio"
  case ps4
  case ps5
  case xboxOne  = "xbox-one"
  case xboxSeriesX = "xbox-series-xs"
  case `switch` = "switch"
  case android
  case ios
  case vr = "vr"
  case battlenet = "battlenet"
  case origin = "origin"
  case drmFree = "drm-free"
  case xbox360 = "xbox-360"
  case unknown
}
