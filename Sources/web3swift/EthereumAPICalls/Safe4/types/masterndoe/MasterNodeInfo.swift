import BigInt
import Web3Core

public struct MasterNodeInfo: Safe4T {
    public var id: BigUInt
    public var addr: EthereumAddress
    public var creator: EthereumAddress
    public var enode: String
    public var description: String
    public var isOfficial: Bool
    public var state: BigUInt
    public var founders: [MasterNodeMemberInfo]
    public var incentivePlan: MasterNodeIncentivePlan
    public var lastRewardHeight: BigUInt
    public var createHeight: BigUInt
    public var updateHeight: BigUInt

    public init(id: BigUInt, addr: EthereumAddress, creator: EthereumAddress, enode: String, description: String, isOfficial: Bool, state: BigUInt, founders: [MasterNodeMemberInfo], incentivePlan: MasterNodeIncentivePlan, lastRewardHeight: BigUInt, createHeight: BigUInt, updateHeight: BigUInt) {
        self.id = id
        self.addr = addr
        self.creator = creator
        self.enode = enode
        self.description = description
        self.isOfficial = isOfficial
        self.state = state
        self.founders = founders
        self.incentivePlan = incentivePlan
        self.lastRewardHeight = lastRewardHeight
        self.createHeight = createHeight
        self.updateHeight = updateHeight
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 12,
              let id = values[0] as? BigUInt,
              let addr = values[1] as? EthereumAddress,
              let creator = values[2] as? EthereumAddress,
              let enode = values[3] as? String,
              let description = values[4] as? String,
              let isOfficial = values[5] as? Bool,
              let state = values[6] as? BigUInt,
              let founders = MasterNodeInfo.parseFounders(values[7]),
              let incentivePlan = MasterNodeInfo.parseIncentivePlan(values[8]),
              let lastRewardHeight = values[9] as? BigUInt,
              let createHeight = values[10] as? BigUInt,
              let updateHeight = values[11] as? BigUInt
         else { return nil }
         self.init(id: id, addr: addr, creator: creator, enode: enode, description: description, isOfficial: isOfficial, state: state, founders: founders, incentivePlan: incentivePlan, lastRewardHeight: lastRewardHeight, createHeight: createHeight, updateHeight: updateHeight)
    }

    static func parseFounders(_ value: Any) -> [MasterNodeMemberInfo]? {
        guard let founders = value as? [Any] else { return nil }
        var ret: [MasterNodeMemberInfo] = []
        for item in founders {
            guard let values = item as? [Any] else { return nil }
            guard let founder = MasterNodeMemberInfo.init(values: values) else { return nil }
            ret.append(founder)
        }
        return ret
    }

    static func parseIncentivePlan(_ value: Any) -> MasterNodeIncentivePlan? {
        guard let values = value as? [Any] else { return nil }
        return MasterNodeIncentivePlan.init(values: values)
    }
}
