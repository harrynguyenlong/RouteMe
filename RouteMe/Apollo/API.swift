//  This file was automatically generated and should not be edited.

import Apollo

public final class GetStopQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetStop {\n  stops {\n    __typename\n    gtfsId\n    name\n    lat\n    lon\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("stops", type: .list(.object(Stop.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(stops: [Stop?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "stops": stops.flatMap { (value: [Stop?]) -> [ResultMap?] in value.map { (value: Stop?) -> ResultMap? in value.flatMap { (value: Stop) -> ResultMap in value.resultMap } } }])
    }

    /// Get all stops for the specified graph
    public var stops: [Stop?]? {
      get {
        return (resultMap["stops"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Stop?] in value.map { (value: ResultMap?) -> Stop? in value.flatMap { (value: ResultMap) -> Stop in Stop(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Stop?]) -> [ResultMap?] in value.map { (value: Stop?) -> ResultMap? in value.flatMap { (value: Stop) -> ResultMap in value.resultMap } } }, forKey: "stops")
      }
    }

    public struct Stop: GraphQLSelectionSet {
      public static let possibleTypes = ["Stop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("gtfsId", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("lat", type: .scalar(Double.self)),
        GraphQLField("lon", type: .scalar(Double.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(gtfsId: String, name: String, lat: Double? = nil, lon: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "Stop", "gtfsId": gtfsId, "name": name, "lat": lat, "lon": lon])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var gtfsId: String {
        get {
          return resultMap["gtfsId"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gtfsId")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var lat: Double? {
        get {
          return resultMap["lat"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var lon: Double? {
        get {
          return resultMap["lon"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lon")
        }
      }
    }
  }
}