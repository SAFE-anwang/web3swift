import BigInt
import Web3Core

public struct AvailableSafe3Info: Safe4T {
    public var safe3Addr: String
    public var amount: BigUInt
    public var safe4Addr: EthereumAddress
    public var redeemHeight: BigUInt

    public init(safe3Addr: String, amount: BigUInt, safe4Addr: EthereumAddress, redeemHeight: BigUInt) {
        self.safe3Addr = safe3Addr
        self.amount = amount
        self.safe4Addr = safe4Addr
        self.redeemHeight = redeemHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 4,
              let safe3Addr = values[0] as? String,
              let amount = values[1] as? BigUInt,
              let safe4Addr = values[2] as? EthereumAddress,
              let redeemHeight = values[3] as? BigUInt
         else { return nil }
         self.init(safe3Addr: safe3Addr, amount: amount, safe4Addr: safe4Addr, redeemHeight: redeemHeight)
    }
}