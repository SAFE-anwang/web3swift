import BigInt
import Web3Core

public struct LockedSafe3Info: Safe4T {
    public var safe3Addr: String
    public var amount: BigUInt
    public var remainLockHeight: BigUInt
    public var lockDay: BigUInt
    public var isMN: Bool
    public var safe4Addr: EthereumAddress
    public var redeemHeight: BigUInt

    public init(safe3Addr: String, amount: BigUInt, remainLockHeight: BigUInt, lockDay: BigUInt, isMN: Bool, safe4Addr: EthereumAddress, redeemHeight: BigUInt) {
        self.safe3Addr = safe3Addr
        self.amount = amount
        self.remainLockHeight = remainLockHeight
        self.lockDay = lockDay
        self.isMN = isMN
        self.safe4Addr = safe4Addr
        self.redeemHeight = redeemHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 7,
              let safe3Addr = values[0] as? String,
              let amount = values[1] as? BigUInt,
              let remainLockHeight = values[2] as? BigUInt,
              let lockDay = values[3] as? BigUInt,
              let isMN = values[4] as? Bool,
              let safe4Addr = values[5] as? EthereumAddress,
              let redeemHeight = values[6] as? BigUInt
         else { return nil }
         self.init(safe3Addr: safe3Addr, amount: amount, remainLockHeight: remainLockHeight, lockDay: lockDay, isMN: isMN, safe4Addr: safe4Addr, redeemHeight: redeemHeight)
    }
}