//  This file was automatically generated and should not be edited.

import Apollo

public enum Mode: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// AIRPLANE
  case airplane
  /// BICYCLE
  case bicycle
  /// BUS
  case bus
  /// CABLE_CAR
  case cableCar
  /// CAR
  case car
  /// FERRY
  case ferry
  /// FUNICULAR
  case funicular
  /// GONDOLA
  case gondola
  /// Only used internally. No use for API users.
  case legSwitch
  /// RAIL
  case rail
  /// SUBWAY
  case subway
  /// TRAM
  case tram
  /// A special transport mode, which includes all public transport.
  case transit
  /// WALK
  case walk
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "AIRPLANE": self = .airplane
      case "BICYCLE": self = .bicycle
      case "BUS": self = .bus
      case "CABLE_CAR": self = .cableCar
      case "CAR": self = .car
      case "FERRY": self = .ferry
      case "FUNICULAR": self = .funicular
      case "GONDOLA": self = .gondola
      case "LEG_SWITCH": self = .legSwitch
      case "RAIL": self = .rail
      case "SUBWAY": self = .subway
      case "TRAM": self = .tram
      case "TRANSIT": self = .transit
      case "WALK": self = .walk
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .airplane: return "AIRPLANE"
      case .bicycle: return "BICYCLE"
      case .bus: return "BUS"
      case .cableCar: return "CABLE_CAR"
      case .car: return "CAR"
      case .ferry: return "FERRY"
      case .funicular: return "FUNICULAR"
      case .gondola: return "GONDOLA"
      case .legSwitch: return "LEG_SWITCH"
      case .rail: return "RAIL"
      case .subway: return "SUBWAY"
      case .tram: return "TRAM"
      case .transit: return "TRANSIT"
      case .walk: return "WALK"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Mode, rhs: Mode) -> Bool {
    switch (lhs, rhs) {
      case (.airplane, .airplane): return true
      case (.bicycle, .bicycle): return true
      case (.bus, .bus): return true
      case (.cableCar, .cableCar): return true
      case (.car, .car): return true
      case (.ferry, .ferry): return true
      case (.funicular, .funicular): return true
      case (.gondola, .gondola): return true
      case (.legSwitch, .legSwitch): return true
      case (.rail, .rail): return true
      case (.subway, .subway): return true
      case (.tram, .tram): return true
      case (.transit, .transit): return true
      case (.walk, .walk): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class GetIntinariesQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetIntinaries($fromPlace: String, $fromLocationLatitude: Float!, $fromLocationLongitude: Float!, $toPlace: String, $toLocationLatitude: Float!, $toLocationLongitude: Float!, $modes: String, $date: String, $time: String, $arriveBy: Boolean) {\n  plan(fromPlace: $fromPlace, from: {lat: $fromLocationLatitude, lon: $fromLocationLongitude}, toPlace: $toPlace, to: {lat: $toLocationLatitude, lon: $toLocationLongitude}, modes: $modes, walkReluctance: 2.1, walkBoardCost: 600, date: $date, time: $time, minTransferTime: 180, walkSpeed: 1.2, arriveBy: $arriveBy) {\n    __typename\n    itineraries {\n      __typename\n      ...ItineryDetail\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ItineryDetail.fragmentDefinition) }

  public var fromPlace: String?
  public var fromLocationLatitude: Double
  public var fromLocationLongitude: Double
  public var toPlace: String?
  public var toLocationLatitude: Double
  public var toLocationLongitude: Double
  public var modes: String?
  public var date: String?
  public var time: String?
  public var arriveBy: Bool?

  public init(fromPlace: String? = nil, fromLocationLatitude: Double, fromLocationLongitude: Double, toPlace: String? = nil, toLocationLatitude: Double, toLocationLongitude: Double, modes: String? = nil, date: String? = nil, time: String? = nil, arriveBy: Bool? = nil) {
    self.fromPlace = fromPlace
    self.fromLocationLatitude = fromLocationLatitude
    self.fromLocationLongitude = fromLocationLongitude
    self.toPlace = toPlace
    self.toLocationLatitude = toLocationLatitude
    self.toLocationLongitude = toLocationLongitude
    self.modes = modes
    self.date = date
    self.time = time
    self.arriveBy = arriveBy
  }

  public var variables: GraphQLMap? {
    return ["fromPlace": fromPlace, "fromLocationLatitude": fromLocationLatitude, "fromLocationLongitude": fromLocationLongitude, "toPlace": toPlace, "toLocationLatitude": toLocationLatitude, "toLocationLongitude": toLocationLongitude, "modes": modes, "date": date, "time": time, "arriveBy": arriveBy]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("plan", arguments: ["fromPlace": GraphQLVariable("fromPlace"), "from": ["lat": GraphQLVariable("fromLocationLatitude"), "lon": GraphQLVariable("fromLocationLongitude")], "toPlace": GraphQLVariable("toPlace"), "to": ["lat": GraphQLVariable("toLocationLatitude"), "lon": GraphQLVariable("toLocationLongitude")], "modes": GraphQLVariable("modes"), "walkReluctance": 2.1, "walkBoardCost": 600, "date": GraphQLVariable("date"), "time": GraphQLVariable("time"), "minTransferTime": 180, "walkSpeed": 1.2, "arriveBy": GraphQLVariable("arriveBy")], type: .object(Plan.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(plan: Plan? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "plan": plan.flatMap { (value: Plan) -> ResultMap in value.resultMap }])
    }

    /// Plans an itinerary from point A to point B based on the given arguments
    public var plan: Plan? {
      get {
        return (resultMap["plan"] as? ResultMap).flatMap { Plan(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "plan")
      }
    }

    public struct Plan: GraphQLSelectionSet {
      public static let possibleTypes = ["Plan"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("itineraries", type: .nonNull(.list(.object(Itinerary.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(itineraries: [Itinerary?]) {
        self.init(unsafeResultMap: ["__typename": "Plan", "itineraries": itineraries.map { (value: Itinerary?) -> ResultMap? in value.flatMap { (value: Itinerary) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of possible itineraries
      public var itineraries: [Itinerary?] {
        get {
          return (resultMap["itineraries"] as! [ResultMap?]).map { (value: ResultMap?) -> Itinerary? in value.flatMap { (value: ResultMap) -> Itinerary in Itinerary(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Itinerary?) -> ResultMap? in value.flatMap { (value: Itinerary) -> ResultMap in value.resultMap } }, forKey: "itineraries")
        }
      }

      public struct Itinerary: GraphQLSelectionSet {
        public static let possibleTypes = ["Itinerary"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("walkDistance", type: .scalar(Double.self)),
          GraphQLField("duration", type: .scalar(Long.self)),
          GraphQLField("fares", type: .list(.object(Fare.selections))),
          GraphQLField("legs", type: .nonNull(.list(.object(Leg.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(walkDistance: Double? = nil, duration: Long? = nil, fares: [Fare?]? = nil, legs: [Leg?]) {
          self.init(unsafeResultMap: ["__typename": "Itinerary", "walkDistance": walkDistance, "duration": duration, "fares": fares.flatMap { (value: [Fare?]) -> [ResultMap?] in value.map { (value: Fare?) -> ResultMap? in value.flatMap { (value: Fare) -> ResultMap in value.resultMap } } }, "legs": legs.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// How far the user has to walk, in meters.
        public var walkDistance: Double? {
          get {
            return resultMap["walkDistance"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "walkDistance")
          }
        }

        /// Duration of the trip on this itinerary, in seconds.
        public var duration: Long? {
          get {
            return resultMap["duration"] as? Long
          }
          set {
            resultMap.updateValue(newValue, forKey: "duration")
          }
        }

        /// Information about the fares for this itinerary
        public var fares: [Fare?]? {
          get {
            return (resultMap["fares"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Fare?] in value.map { (value: ResultMap?) -> Fare? in value.flatMap { (value: ResultMap) -> Fare in Fare(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Fare?]) -> [ResultMap?] in value.map { (value: Fare?) -> ResultMap? in value.flatMap { (value: Fare) -> ResultMap in value.resultMap } } }, forKey: "fares")
          }
        }

        /// A list of Legs. Each Leg is either a walking (cycling, car) portion of the itinerary, or a transit leg on a particular vehicle. So a itinerary where the user walks to the Q train, transfers to the 6, then walks to their destination, has four legs.
        public var legs: [Leg?] {
          get {
            return (resultMap["legs"] as! [ResultMap?]).map { (value: ResultMap?) -> Leg? in value.flatMap { (value: ResultMap) -> Leg in Leg(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }, forKey: "legs")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var itineryDetail: ItineryDetail {
            get {
              return ItineryDetail(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Fare: GraphQLSelectionSet {
          public static let possibleTypes = ["fare"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("currency", type: .scalar(String.self)),
            GraphQLField("cents", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(type: String? = nil, currency: String? = nil, cents: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "fare", "type": type, "currency": currency, "cents": cents])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          /// ISO 4217 currency code
          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }

          /// Fare price in cents. **Note:** this value is dependent on the currency used, as one cent is not necessarily ¹/₁₀₀ of the basic monerary unit.
          public var cents: Int? {
            get {
              return resultMap["cents"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "cents")
            }
          }
        }

        public struct Leg: GraphQLSelectionSet {
          public static let possibleTypes = ["Leg"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("mode", type: .scalar(Mode.self)),
            GraphQLField("startTime", type: .scalar(Long.self)),
            GraphQLField("duration", type: .scalar(Double.self)),
            GraphQLField("trip", type: .object(Trip.selections)),
            GraphQLField("agency", type: .object(Agency.selections)),
            GraphQLField("endTime", type: .scalar(Long.self)),
            GraphQLField("from", type: .nonNull(.object(From.selections))),
            GraphQLField("to", type: .nonNull(.object(To.selections))),
            GraphQLField("agency", type: .object(Agency.selections)),
            GraphQLField("distance", type: .scalar(Double.self)),
            GraphQLField("legGeometry", type: .object(LegGeometry.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(mode: Mode? = nil, startTime: Long? = nil, duration: Double? = nil, trip: Trip? = nil, agency: Agency? = nil, endTime: Long? = nil, from: From, to: To, distance: Double? = nil, legGeometry: LegGeometry? = nil) {
            self.init(unsafeResultMap: ["__typename": "Leg", "mode": mode, "startTime": startTime, "duration": duration, "trip": trip.flatMap { (value: Trip) -> ResultMap in value.resultMap }, "agency": agency.flatMap { (value: Agency) -> ResultMap in value.resultMap }, "endTime": endTime, "from": from.resultMap, "to": to.resultMap, "distance": distance, "legGeometry": legGeometry.flatMap { (value: LegGeometry) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The mode (e.g. `WALK`) used when traversing this leg.
          public var mode: Mode? {
            get {
              return resultMap["mode"] as? Mode
            }
            set {
              resultMap.updateValue(newValue, forKey: "mode")
            }
          }

          /// The date and time when this leg begins. Format: Unix timestamp in milliseconds.
          public var startTime: Long? {
            get {
              return resultMap["startTime"] as? Long
            }
            set {
              resultMap.updateValue(newValue, forKey: "startTime")
            }
          }

          /// The leg's duration in seconds
          public var duration: Double? {
            get {
              return resultMap["duration"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "duration")
            }
          }

          /// For transit legs, the trip that is used for traversing the leg. For non-transit legs, `null`.
          public var trip: Trip? {
            get {
              return (resultMap["trip"] as? ResultMap).flatMap { Trip(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "trip")
            }
          }

          /// For transit legs, the transit agency that operates the service used for this leg. For non-transit legs, `null`.
          public var agency: Agency? {
            get {
              return (resultMap["agency"] as? ResultMap).flatMap { Agency(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "agency")
            }
          }

          /// The date and time when this leg ends. Format: Unix timestamp in milliseconds.
          public var endTime: Long? {
            get {
              return resultMap["endTime"] as? Long
            }
            set {
              resultMap.updateValue(newValue, forKey: "endTime")
            }
          }

          /// The Place where the leg originates.
          public var from: From {
            get {
              return From(unsafeResultMap: resultMap["from"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "from")
            }
          }

          /// The Place where the leg ends.
          public var to: To {
            get {
              return To(unsafeResultMap: resultMap["to"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "to")
            }
          }

          /// The distance traveled while traversing the leg in meters.
          public var distance: Double? {
            get {
              return resultMap["distance"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "distance")
            }
          }

          /// The leg's geometry.
          public var legGeometry: LegGeometry? {
            get {
              return (resultMap["legGeometry"] as? ResultMap).flatMap { LegGeometry(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "legGeometry")
            }
          }

          public struct Trip: GraphQLSelectionSet {
            public static let possibleTypes = ["Trip"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("tripHeadsign", type: .scalar(String.self)),
              GraphQLField("tripShortName", type: .scalar(String.self)),
              GraphQLField("route", type: .nonNull(.object(Route.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(tripHeadsign: String? = nil, tripShortName: String? = nil, route: Route) {
              self.init(unsafeResultMap: ["__typename": "Trip", "tripHeadsign": tripHeadsign, "tripShortName": tripShortName, "route": route.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Headsign of the vehicle when running on this trip
            public var tripHeadsign: String? {
              get {
                return resultMap["tripHeadsign"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "tripHeadsign")
              }
            }

            public var tripShortName: String? {
              get {
                return resultMap["tripShortName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "tripShortName")
              }
            }

            /// The route the trip is running on
            public var route: Route {
              get {
                return Route(unsafeResultMap: resultMap["route"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "route")
              }
            }

            public struct Route: GraphQLSelectionSet {
              public static let possibleTypes = ["Route"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("shortName", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(shortName: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Route", "shortName": shortName])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Short name of the route, usually a line number, e.g. 550
              public var shortName: String? {
                get {
                  return resultMap["shortName"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "shortName")
                }
              }
            }
          }

          public struct Agency: GraphQLSelectionSet {
            public static let possibleTypes = ["Agency"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String) {
              self.init(unsafeResultMap: ["__typename": "Agency", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Global object ID provided by Relay. This value can be used to refetch this object using **node** query.
            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// Name of the agency
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct From: GraphQLSelectionSet {
            public static let possibleTypes = ["Place"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
              GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("stop", type: .object(Stop.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(lat: Double, lon: Double, name: String? = nil, stop: Stop? = nil) {
              self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name, "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Latitude of the place (WGS 84)
            public var lat: Double {
              get {
                return resultMap["lat"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lat")
              }
            }

            /// Longitude of the place (WGS 84)
            public var lon: Double {
              get {
                return resultMap["lon"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lon")
              }
            }

            /// For transit stops, the name of the stop. For points of interest, the name of the POI.
            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The stop related to the place.
            public var stop: Stop? {
              get {
                return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "stop")
              }
            }

            public struct Stop: GraphQLSelectionSet {
              public static let possibleTypes = ["Stop"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .scalar(String.self)),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(code: String? = nil, name: String) {
                self.init(unsafeResultMap: ["__typename": "Stop", "code": code, "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Stop code which is visible at the stop
              public var code: String? {
                get {
                  return resultMap["code"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "code")
                }
              }

              /// Name of the stop, e.g. Pasilan asema
              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }
          }

          public struct To: GraphQLSelectionSet {
            public static let possibleTypes = ["Place"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
              GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
              GraphQLField("name", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(lat: Double, lon: Double, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Latitude of the place (WGS 84)
            public var lat: Double {
              get {
                return resultMap["lat"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lat")
              }
            }

            /// Longitude of the place (WGS 84)
            public var lon: Double {
              get {
                return resultMap["lon"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lon")
              }
            }

            /// For transit stops, the name of the stop. For points of interest, the name of the POI.
            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct LegGeometry: GraphQLSelectionSet {
            public static let possibleTypes = ["Geometry"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("length", type: .scalar(Int.self)),
              GraphQLField("points", type: .scalar(Polyline.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(length: Int? = nil, points: Polyline? = nil) {
              self.init(unsafeResultMap: ["__typename": "Geometry", "length": length, "points": points])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The number of points in the string
            public var length: Int? {
              get {
                return resultMap["length"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "length")
              }
            }

            /// List of coordinates of in a Google encoded polyline format (see https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
            public var points: Polyline? {
              get {
                return resultMap["points"] as? Polyline
              }
              set {
                resultMap.updateValue(newValue, forKey: "points")
              }
            }
          }
        }
      }
    }
  }
}

public struct ItineryDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment ItineryDetail on Itinerary {\n  __typename\n  walkDistance\n  duration\n  fares {\n    __typename\n    type\n    currency\n    cents\n  }\n  legs {\n    __typename\n    mode\n    startTime\n    duration\n    trip {\n      __typename\n      tripHeadsign\n      tripShortName\n      route {\n        __typename\n        shortName\n      }\n    }\n    agency {\n      __typename\n      id\n      name\n    }\n    endTime\n    from {\n      __typename\n      lat\n      lon\n      name\n      stop {\n        __typename\n        code\n        name\n      }\n    }\n    to {\n      __typename\n      lat\n      lon\n      name\n    }\n    agency {\n      __typename\n      id\n    }\n    distance\n    legGeometry {\n      __typename\n      length\n      points\n    }\n  }\n}"

  public static let possibleTypes = ["Itinerary"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("walkDistance", type: .scalar(Double.self)),
    GraphQLField("duration", type: .scalar(Long.self)),
    GraphQLField("fares", type: .list(.object(Fare.selections))),
    GraphQLField("legs", type: .nonNull(.list(.object(Leg.selections)))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(walkDistance: Double? = nil, duration: Long? = nil, fares: [Fare?]? = nil, legs: [Leg?]) {
    self.init(unsafeResultMap: ["__typename": "Itinerary", "walkDistance": walkDistance, "duration": duration, "fares": fares.flatMap { (value: [Fare?]) -> [ResultMap?] in value.map { (value: Fare?) -> ResultMap? in value.flatMap { (value: Fare) -> ResultMap in value.resultMap } } }, "legs": legs.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// How far the user has to walk, in meters.
  public var walkDistance: Double? {
    get {
      return resultMap["walkDistance"] as? Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "walkDistance")
    }
  }

  /// Duration of the trip on this itinerary, in seconds.
  public var duration: Long? {
    get {
      return resultMap["duration"] as? Long
    }
    set {
      resultMap.updateValue(newValue, forKey: "duration")
    }
  }

  /// Information about the fares for this itinerary
  public var fares: [Fare?]? {
    get {
      return (resultMap["fares"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Fare?] in value.map { (value: ResultMap?) -> Fare? in value.flatMap { (value: ResultMap) -> Fare in Fare(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Fare?]) -> [ResultMap?] in value.map { (value: Fare?) -> ResultMap? in value.flatMap { (value: Fare) -> ResultMap in value.resultMap } } }, forKey: "fares")
    }
  }

  /// A list of Legs. Each Leg is either a walking (cycling, car) portion of the itinerary, or a transit leg on a particular vehicle. So a itinerary where the user walks to the Q train, transfers to the 6, then walks to their destination, has four legs.
  public var legs: [Leg?] {
    get {
      return (resultMap["legs"] as! [ResultMap?]).map { (value: ResultMap?) -> Leg? in value.flatMap { (value: ResultMap) -> Leg in Leg(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }, forKey: "legs")
    }
  }

  public struct Fare: GraphQLSelectionSet {
    public static let possibleTypes = ["fare"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("type", type: .scalar(String.self)),
      GraphQLField("currency", type: .scalar(String.self)),
      GraphQLField("cents", type: .scalar(Int.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(type: String? = nil, currency: String? = nil, cents: Int? = nil) {
      self.init(unsafeResultMap: ["__typename": "fare", "type": type, "currency": currency, "cents": cents])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var type: String? {
      get {
        return resultMap["type"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "type")
      }
    }

    /// ISO 4217 currency code
    public var currency: String? {
      get {
        return resultMap["currency"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "currency")
      }
    }

    /// Fare price in cents. **Note:** this value is dependent on the currency used, as one cent is not necessarily ¹/₁₀₀ of the basic monerary unit.
    public var cents: Int? {
      get {
        return resultMap["cents"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "cents")
      }
    }
  }

  public struct Leg: GraphQLSelectionSet {
    public static let possibleTypes = ["Leg"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("mode", type: .scalar(Mode.self)),
      GraphQLField("startTime", type: .scalar(Long.self)),
      GraphQLField("duration", type: .scalar(Double.self)),
      GraphQLField("trip", type: .object(Trip.selections)),
      GraphQLField("agency", type: .object(Agency.selections)),
      GraphQLField("endTime", type: .scalar(Long.self)),
      GraphQLField("from", type: .nonNull(.object(From.selections))),
      GraphQLField("to", type: .nonNull(.object(To.selections))),
      GraphQLField("agency", type: .object(Agency.selections)),
      GraphQLField("distance", type: .scalar(Double.self)),
      GraphQLField("legGeometry", type: .object(LegGeometry.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(mode: Mode? = nil, startTime: Long? = nil, duration: Double? = nil, trip: Trip? = nil, agency: Agency? = nil, endTime: Long? = nil, from: From, to: To, distance: Double? = nil, legGeometry: LegGeometry? = nil) {
      self.init(unsafeResultMap: ["__typename": "Leg", "mode": mode, "startTime": startTime, "duration": duration, "trip": trip.flatMap { (value: Trip) -> ResultMap in value.resultMap }, "agency": agency.flatMap { (value: Agency) -> ResultMap in value.resultMap }, "endTime": endTime, "from": from.resultMap, "to": to.resultMap, "distance": distance, "legGeometry": legGeometry.flatMap { (value: LegGeometry) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The mode (e.g. `WALK`) used when traversing this leg.
    public var mode: Mode? {
      get {
        return resultMap["mode"] as? Mode
      }
      set {
        resultMap.updateValue(newValue, forKey: "mode")
      }
    }

    /// The date and time when this leg begins. Format: Unix timestamp in milliseconds.
    public var startTime: Long? {
      get {
        return resultMap["startTime"] as? Long
      }
      set {
        resultMap.updateValue(newValue, forKey: "startTime")
      }
    }

    /// The leg's duration in seconds
    public var duration: Double? {
      get {
        return resultMap["duration"] as? Double
      }
      set {
        resultMap.updateValue(newValue, forKey: "duration")
      }
    }

    /// For transit legs, the trip that is used for traversing the leg. For non-transit legs, `null`.
    public var trip: Trip? {
      get {
        return (resultMap["trip"] as? ResultMap).flatMap { Trip(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trip")
      }
    }

    /// For transit legs, the transit agency that operates the service used for this leg. For non-transit legs, `null`.
    public var agency: Agency? {
      get {
        return (resultMap["agency"] as? ResultMap).flatMap { Agency(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "agency")
      }
    }

    /// The date and time when this leg ends. Format: Unix timestamp in milliseconds.
    public var endTime: Long? {
      get {
        return resultMap["endTime"] as? Long
      }
      set {
        resultMap.updateValue(newValue, forKey: "endTime")
      }
    }

    /// The Place where the leg originates.
    public var from: From {
      get {
        return From(unsafeResultMap: resultMap["from"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "from")
      }
    }

    /// The Place where the leg ends.
    public var to: To {
      get {
        return To(unsafeResultMap: resultMap["to"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "to")
      }
    }

    /// The distance traveled while traversing the leg in meters.
    public var distance: Double? {
      get {
        return resultMap["distance"] as? Double
      }
      set {
        resultMap.updateValue(newValue, forKey: "distance")
      }
    }

    /// The leg's geometry.
    public var legGeometry: LegGeometry? {
      get {
        return (resultMap["legGeometry"] as? ResultMap).flatMap { LegGeometry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "legGeometry")
      }
    }

    public struct Trip: GraphQLSelectionSet {
      public static let possibleTypes = ["Trip"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("tripHeadsign", type: .scalar(String.self)),
        GraphQLField("tripShortName", type: .scalar(String.self)),
        GraphQLField("route", type: .nonNull(.object(Route.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tripHeadsign: String? = nil, tripShortName: String? = nil, route: Route) {
        self.init(unsafeResultMap: ["__typename": "Trip", "tripHeadsign": tripHeadsign, "tripShortName": tripShortName, "route": route.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Headsign of the vehicle when running on this trip
      public var tripHeadsign: String? {
        get {
          return resultMap["tripHeadsign"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tripHeadsign")
        }
      }

      public var tripShortName: String? {
        get {
          return resultMap["tripShortName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tripShortName")
        }
      }

      /// The route the trip is running on
      public var route: Route {
        get {
          return Route(unsafeResultMap: resultMap["route"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "route")
        }
      }

      public struct Route: GraphQLSelectionSet {
        public static let possibleTypes = ["Route"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("shortName", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(shortName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Route", "shortName": shortName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Short name of the route, usually a line number, e.g. 550
        public var shortName: String? {
          get {
            return resultMap["shortName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "shortName")
          }
        }
      }
    }

    public struct Agency: GraphQLSelectionSet {
      public static let possibleTypes = ["Agency"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String) {
        self.init(unsafeResultMap: ["__typename": "Agency", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Global object ID provided by Relay. This value can be used to refetch this object using **node** query.
      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Name of the agency
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }

    public struct From: GraphQLSelectionSet {
      public static let possibleTypes = ["Place"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("stop", type: .object(Stop.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(lat: Double, lon: Double, name: String? = nil, stop: Stop? = nil) {
        self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name, "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Latitude of the place (WGS 84)
      public var lat: Double {
        get {
          return resultMap["lat"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      /// Longitude of the place (WGS 84)
      public var lon: Double {
        get {
          return resultMap["lon"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lon")
        }
      }

      /// For transit stops, the name of the stop. For points of interest, the name of the POI.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The stop related to the place.
      public var stop: Stop? {
        get {
          return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "stop")
        }
      }

      public struct Stop: GraphQLSelectionSet {
        public static let possibleTypes = ["Stop"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .scalar(String.self)),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: String? = nil, name: String) {
          self.init(unsafeResultMap: ["__typename": "Stop", "code": code, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Stop code which is visible at the stop
        public var code: String? {
          get {
            return resultMap["code"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        /// Name of the stop, e.g. Pasilan asema
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }

    public struct To: GraphQLSelectionSet {
      public static let possibleTypes = ["Place"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
        GraphQLField("name", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(lat: Double, lon: Double, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Latitude of the place (WGS 84)
      public var lat: Double {
        get {
          return resultMap["lat"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      /// Longitude of the place (WGS 84)
      public var lon: Double {
        get {
          return resultMap["lon"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lon")
        }
      }

      /// For transit stops, the name of the stop. For points of interest, the name of the POI.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }

    public struct LegGeometry: GraphQLSelectionSet {
      public static let possibleTypes = ["Geometry"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("length", type: .scalar(Int.self)),
        GraphQLField("points", type: .scalar(Polyline.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(length: Int? = nil, points: Polyline? = nil) {
        self.init(unsafeResultMap: ["__typename": "Geometry", "length": length, "points": points])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The number of points in the string
      public var length: Int? {
        get {
          return resultMap["length"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "length")
        }
      }

      /// List of coordinates of in a Google encoded polyline format (see https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
      public var points: Polyline? {
        get {
          return resultMap["points"] as? Polyline
        }
        set {
          resultMap.updateValue(newValue, forKey: "points")
        }
      }
    }
  }
}