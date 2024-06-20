import BigInt
import Web3Core

public struct SuperNodeIncentivePlan {
    public var creator: BigUInt
    public var partner: BigUInt
    public var voter: BigUInt

    public init(creator: BigUInt, partner: BigUInt, voter: BigUInt) {
        self.creator = creator
        self.partner = partner
        self.voter = voter
    }

    public init?(values: [Any]) {
        guard values.count == 3,
              let creator = values[0] as? BigUInt,
              let partner = values[1] as? BigUInt,
              let voter = values[2] as? BigUInt
         else { return nil }
         self.init(creator: creator, partner: partner, voter: voter)
    }
}