import BigInt
import Web3Core

public struct AllowInfo: Safe4T {
    public var addrs: [EthereumAddress]
    public var amounts: [BigUInt]

    public init(addrs: [EthereumAddress], amounts: [BigUInt]) {
        self.addrs = addrs
        self.amounts = amounts
    }

    public init?(_ result: [String: Any]) {
        if(result.count != 2 && result.count != 4) {
            return nil
        }
        guard let addrs = result["0"] as? [EthereumAddress] else { return nil }
        guard let amounts = result["1"] as? [BigUInt] else { return nil }
        self.init(addrs: addrs, amounts: amounts)
    }
}