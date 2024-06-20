import BigInt
import Web3Core

public struct SNVoteRetInfo: Safe4T {
    public var addrs: [EthereumAddress]
    public var voteNums: [BigUInt]

    public init(addrs: [EthereumAddress], voteNums: [BigUInt]) {
        self.addrs = addrs
        self.voteNums = voteNums
    }

    public init?(_ result: [String: Any]) {
        if(result.count != 3) {
            return nil
        }
        guard let addrs = result["0"] as? [EthereumAddress] else { return nil }
        guard let voteNums = result["1"] as? [BigUInt] else { return nil }
        self.init(addrs: addrs, voteNums: voteNums)
    }
}