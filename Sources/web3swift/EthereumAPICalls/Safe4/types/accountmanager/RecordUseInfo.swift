import BigInt
import Web3Core

public struct RecordUseInfo: Safe4T {
    public var frozenAddr: EthereumAddress
    public var freezeHeight: BigUInt
    public var unfreezeHeight: BigUInt
    public var votedAddr: EthereumAddress
    public var voteHeight: BigUInt
    public var releaseHeight: BigUInt

    public init(frozenAddr: EthereumAddress, freezeHeight: BigUInt, unfreezeHeight: BigUInt, votedAddr: EthereumAddress, voteHeight: BigUInt, releaseHeight: BigUInt) {
        self.frozenAddr = frozenAddr
        self.freezeHeight = freezeHeight
        self.unfreezeHeight = unfreezeHeight
        self.votedAddr = votedAddr
        self.voteHeight = voteHeight
        self.releaseHeight = releaseHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 6,
              let frozenAddr = values[0] as? EthereumAddress,
              let freezeHeight = values[1] as? BigUInt,
              let unfreezeHeight = values[2] as? BigUInt,
              let votedAddr = values[3] as? EthereumAddress,
              let voteHeight = values[4] as? BigUInt,
              let releaseHeight = values[5] as? BigUInt
         else { return nil }
         self.init(frozenAddr: frozenAddr, freezeHeight: freezeHeight, unfreezeHeight: unfreezeHeight, votedAddr: votedAddr, voteHeight: voteHeight, releaseHeight: releaseHeight)
    }
}