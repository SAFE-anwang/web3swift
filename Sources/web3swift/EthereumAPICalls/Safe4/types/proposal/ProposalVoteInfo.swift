import BigInt
import Web3Core

public struct ProposalVoteInfo: Safe4T {
    public var voter: EthereumAddress
    public var voteResult: BigUInt

    public init(voter: EthereumAddress, voteResult: BigUInt) {
        self.voter = voter
        self.voteResult = voteResult
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 2,
              let voter = values[0] as? EthereumAddress,
              let voteResult = values[1] as? BigUInt
         else { return nil }
         self.init(voter: voter, voteResult: voteResult)
    }
}