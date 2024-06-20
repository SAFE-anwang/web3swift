import BigInt

public struct PropertyInfo: Safe4T {
    public var name: String
    public var value: BigUInt
    public var description: String
    public var createHeight: BigUInt
    public var updateHeight: BigUInt

    public init(name: String, value: BigUInt, description: String, createHeight: BigUInt, updateHeight: BigUInt) {
        self.name = name
        self.value = value
        self.description = description
        self.createHeight = createHeight
        self.updateHeight = updateHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 5,
              let name = values[0] as? String,
              let value = values[1] as? BigUInt,
              let description = values[2] as? String,
              let createHeight = values[3] as? BigUInt,
              let updateHeight = values[4] as? BigUInt
         else { return nil }
         self.init(name: name, value: value, description: description, createHeight: createHeight, updateHeight: updateHeight)
    }
}