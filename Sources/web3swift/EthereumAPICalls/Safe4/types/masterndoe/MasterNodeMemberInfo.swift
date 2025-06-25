import BigInt
import Web3Core

public struct MasterNodeMemberInfo {
    public var lockID: BigUInt
    public var addr: EthereumAddress
    public var amount: BigUInt
    public var unlockHeight: BigUInt

    public init(lockID: BigUInt, addr: EthereumAddress, amount: BigUInt, unlockHeight: BigUInt) {
        self.lockID = lockID
        self.addr = addr
        self.amount = amount
        self.unlockHeight = unlockHeight
    }

    public init?(values: [Any]) {
        guard values.count == 4,
              let lockID = values[0] as? BigUInt,
              let addr = values[1] as? EthereumAddress,
              let amount = values[2] as? BigUInt,
              let unlockHeight = values[3] as? BigUInt
         else { return nil }
         self.init(lockID: lockID, addr: addr, amount: amount, unlockHeight: unlockHeight)
    }
}