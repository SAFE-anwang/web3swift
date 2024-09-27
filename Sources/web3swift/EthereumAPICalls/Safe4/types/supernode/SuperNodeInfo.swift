import BigInt
import Web3Core

public struct SuperNodeInfo: Safe4T {
    public var id: BigUInt
    public var name: String
    public var addr: EthereumAddress
    public var creator: EthereumAddress
    public var enode: String
    public var description: String
    public var isOfficial: Bool
    public var state: BigUInt
    public var founders: [SuperNodeMemberInfo]
    public var incentivePlan: SuperNodeIncentivePlan
    public var lastRewardHeight: BigUInt
    public var createHeight: BigUInt
    public var updateHeight: BigUInt

    public init(id: BigUInt, name: String, addr: EthereumAddress, creator: EthereumAddress, enode: String, description: String, isOfficial: Bool, state: BigUInt, founders: [SuperNodeMemberInfo], incentivePlan: SuperNodeIncentivePlan, lastRewardHeight: BigUInt, createHeight: BigUInt, updateHeight: BigUInt) {
        self.id = id
        if name.count == 0 {
            self.name = "Unknown Name"
        } else {
            self.name = name
        }
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
        guard values.count == 13,
              let id = values[0] as? BigUInt,
              let name = values[1] as? String,
              let addr = values[2] as? EthereumAddress,
              let creator = values[3] as? EthereumAddress,
              let enode = values[4] as? String,
              let description = values[5] as? String,
              let isOfficial = values[6] as? Bool,
              let state = values[7] as? BigUInt,
              let founders = SuperNodeInfo.parseFounders(values[8]),
              let incentivePlan = SuperNodeInfo.parseIncentivePlan(values[9]),
              let lastRewardHeight = values[10] as? BigUInt,
              let createHeight = values[11] as? BigUInt,
              let updateHeight = values[12] as? BigUInt
         else { return nil }
         self.init(id: id, name: name, addr: addr, creator: creator, enode: enode, description: description, isOfficial: isOfficial, state: state, founders: founders, incentivePlan: incentivePlan, lastRewardHeight: lastRewardHeight, createHeight: createHeight, updateHeight: updateHeight)
    }

    static func parseFounders(_ value: Any) -> [SuperNodeMemberInfo]? {
        guard let founders = value as? [Any] else { return nil }
        var ret: [SuperNodeMemberInfo] = []
        for item in founders {
            guard let values = item as? [Any] else { return nil }
            guard let founder = SuperNodeMemberInfo.init(values: values) else { return nil }
            ret.append(founder)
        }
        return ret
    }

    static func parseIncentivePlan(_ value: Any) -> SuperNodeIncentivePlan? {
        guard let values = value as? [Any] else { return nil }
        return SuperNodeIncentivePlan.init(values: values)
    }
}
