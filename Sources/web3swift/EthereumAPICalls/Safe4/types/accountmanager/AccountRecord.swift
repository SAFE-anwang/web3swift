import BigInt
import Web3Core

public struct AccountRecord: Safe4T {
    public var id: BigUInt
    public var addr: EthereumAddress
    public var amount: BigUInt
    public var lockDay: BigUInt
    public var startHeight: BigUInt
    public var unlockHeight: BigUInt

    public init(id: BigUInt, addr: EthereumAddress, amount: BigUInt, lockDay: BigUInt, startHeight: BigUInt, unlockHeight: BigUInt) {
        self.id = id
        self.addr = addr
        self.amount = amount
        self.lockDay = lockDay
        self.startHeight = startHeight
        self.unlockHeight = unlockHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 6,
              let id = values[0] as? BigUInt,
              let addr = values[1] as? EthereumAddress,
              let amount = values[2] as? BigUInt,
              let lockDay = values[3] as? BigUInt,
              let startHeight = values[4] as? BigUInt,
              let unlockHeight = values[5] as? BigUInt
         else { return nil }
         self.init(id: id, addr: addr, amount: amount, lockDay: lockDay, startHeight: startHeight, unlockHeight: unlockHeight)
    }
}