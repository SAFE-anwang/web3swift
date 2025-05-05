import Foundation
import BigInt
import Web3Core

public class Safe4Swap {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.Safe4SwapContractAddress, contractABI: Safe4ContractABI.AccountManagerABI)
    }
}
extension Safe4Swap {
    public func safe4ToSrc20(privateKey: Data, value: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "deposit")
    }
    
    public func src20ToSafe4(privateKey: Data, value: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdraw", parameters: [value])
    }
}
