import BigInt
import Web3Core

public struct VoteRecord: Safe4T {
    public var voterAddr: EthereumAddress
    public var dstAddr: EthereumAddress
    public var amount: BigUInt
    public var num: BigUInt
    public var height: BigUInt

    public init(voterAddr: EthereumAddress, dstAddr: EthereumAddress, amount: BigUInt, num: BigUInt, height: BigUInt) {
        self.voterAddr = voterAddr
        self.dstAddr = dstAddr
        self.amount = amount
        self.num = num
        self.height = height
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 5,
              let voterAddr = values[0] as? EthereumAddress,
              let dstAddr = values[1] as? EthereumAddress,
              let amount = values[2] as? BigUInt,
              let num = values[3] as? BigUInt,
              let height = values[4] as? BigUInt
         else { return nil }
         self.init(voterAddr: voterAddr, dstAddr: dstAddr, amount: amount, num: num, height: height)
    }
}