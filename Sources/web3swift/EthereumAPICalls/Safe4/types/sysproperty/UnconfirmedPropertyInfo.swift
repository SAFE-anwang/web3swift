import BigInt
import Web3Core

public struct UnconfirmedPropertyInfo: Safe4T {
    public var name: String
    public var value: BigUInt
    public var applicant: EthereumAddress
    public var voters: [EthereumAddress]
    public var voteResults: [BigUInt]
    public var reason: String
    public var applyHeight: BigUInt

    public init(name: String, value: BigUInt, applicant: EthereumAddress, voters: [EthereumAddress], voteResults: [BigUInt], reason: String, applyHeight: BigUInt) {
        self.name = name
        self.value = value
        self.applicant = applicant
        self.voters = voters
        self.voteResults = voteResults
        self.reason = reason
        self.applyHeight = applyHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 7,
              let name = values[0] as? String,
              let value = values[1] as? BigUInt,
              let applicant = values[2] as? EthereumAddress,
              let voters = values[3] as? [EthereumAddress],
              let voteResults = values[4] as? [BigUInt],
              let reason = values[5] as? String,
              let applyHeight = values[6] as? BigUInt
         else { return nil }
         self.init(name: name, value: value, applicant: applicant, voters: voters, voteResults: voteResults, reason: reason, applyHeight: applyHeight)
    }
}