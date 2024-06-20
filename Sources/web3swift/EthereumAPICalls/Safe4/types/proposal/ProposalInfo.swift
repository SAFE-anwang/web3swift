import BigInt
import Web3Core

public struct ProposalInfo: Safe4T {
    public var id: BigUInt
    public var creator: EthereumAddress
    public var title: String
    public var payAmount: BigUInt
    public var payTimes: BigUInt
    public var startPayTime: BigUInt
    public var endPayTime: BigUInt
    public var description: String
    public var state: BigUInt
    public var createHeight: BigUInt
    public var updateHeight: BigUInt

    public init(id: BigUInt, creator: EthereumAddress, title: String, payAmount: BigUInt, payTime: BigUInt, startPayTime: BigUInt, endPayTime: BigUInt, description: String, state: BigUInt, createHeight: BigUInt, updateHeight: BigUInt) {
        self.id = id
        self.creator = creator
        self.title = title
        self.payAmount = payAmount
        self.payTimes = payTime
        self.startPayTime = startPayTime
        self.endPayTime = endPayTime
        self.description = description
        self.state = state
        self.createHeight = createHeight
        self.updateHeight = updateHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 11,
              let id = values[0] as? BigUInt,
              let creator = values[1] as? EthereumAddress,
              let title = values[2] as? String,
              let payAmount = values[3] as? BigUInt,
              let payTimes = values[4] as? BigUInt,
              let startPayTime = values[5] as? BigUInt,
              let endPayTime = values[6] as? BigUInt,
              let description = values[7] as? String,
              let state = values[8] as? BigUInt,
              let createHeight = values[9] as? BigUInt,
              let updateHeight = values[10] as? BigUInt
         else { return nil }
         self.init(id: id, creator: creator, title: title, payAmount: payAmount, payTime: payTimes, startPayTime: startPayTime, endPayTime: endPayTime, description: description, state: state, createHeight: createHeight, updateHeight: updateHeight)
    }
}