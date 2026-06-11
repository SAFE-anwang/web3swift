import BigInt
import Web3Core

public struct DAppInfo: Safe4T {
    public var id: BigUInt
    public var name: String
    public var contractAddr: EthereumAddress
    public var runUrl: String
    public var gitUrl: String
    public var officialUrl: String
    public var officialEmail: String
    public var officialAccount: EthereumAddress
    public var description: String
    public var keyword: String
    public var fraudNum: BigUInt
    public var isFrozen: Bool

    public init(id: BigUInt, name: String, contractAddr: EthereumAddress, runUrl: String, gitUrl: String, officialUrl: String, officialEmail: String, officialAccount: EthereumAddress, description: String, keyword: String, fraudNum: BigUInt, isFrozen: Bool) {
        self.id = id
        self.name = name
        self.contractAddr = contractAddr
        self.runUrl = runUrl
        self.gitUrl = gitUrl
        self.officialUrl = officialUrl
        self.officialEmail = officialEmail
        self.officialAccount = officialAccount
        self.description = description
        self.keyword = keyword
        self.fraudNum = fraudNum
        self.isFrozen = isFrozen
    }

    public init?(_ result: [String: Any]) {
        guard let values = result["0"] as? [Any] else { return nil }
        guard values.count == 12,
              let id = values[0] as? BigUInt,
              let name = values[1] as? String,
              let contractAddr = values[2] as? EthereumAddress,
              let runUrl = values[3] as? String,
              let gitUrl = values[4] as? String,
              let officialUrl = values[5] as? String,
              let officialEmail = values[6] as? String,
              let officialAccount = values[7] as? EthereumAddress,
              let description = values[8] as? String,
              let keyword = values[9] as? String,
              let fraudNum = values[10] as? BigUInt,
              let isFrozen = values[11] as? Bool
         else { return nil }
         self.init(id: id, name: name, contractAddr: contractAddr, runUrl: runUrl, gitUrl: gitUrl, officialUrl: officialUrl, officialEmail: officialEmail, officialAccount: officialAccount, description: description, keyword: keyword, fraudNum: fraudNum, isFrozen: isFrozen)
    }
}