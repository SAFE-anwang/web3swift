import Foundation
import BigInt
import Web3Core

public class Safe4Contract {
    private var provider: Web3Provider
    private var web3: Web3
    private var contract: Web3.Contract

    static private var NullAddr = EthereumAddress("0x0000000000000000000000000000000000000000")!

    init(provider: Web3Provider, web3: Web3, contractAddr: String, contractABI: String) {
        self.provider = provider
        self.web3 = web3
        self.contract = web3.contract(contractABI, at: EthereumAddress(contractAddr))!
    }

    func getAddress(_ privateKey: Data) -> EthereumAddress? {
        return Utilities.publicToAddress(Utilities.privateToPublic(privateKey)!)
    }

    func getNonce(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await web3.eth.getTransactionCount(for: addr, onBlock: .pending)
    }

    func getGasPrice() async throws -> BigUInt {
        return try await web3.eth.gasPrice()
    }

    func getGasLimit(_ tx: CodableTransaction) async throws -> BigUInt {
        return try await web3.eth.estimateGas(for: tx, onBlock: .pending)
    }

    func call(privateKey: Data, value: BigUInt = 0, method: String, parameters: [Any] = []) async throws -> String {
        let from = getAddress(privateKey)!
        let nonce = try await getNonce(from)
        let gasPrice = try await getGasPrice()
        var tx = CodableTransaction(
            type: .legacy,
            to: contract.contract.address!,
            nonce: nonce,
            chainID: provider.network!.chainID,
            value: value,
            gasPrice: gasPrice
        )
        tx.from = from
        tx.data = contract.contract.method(method, parameters: parameters, extraData: Data())!
        tx.gasLimit = try await getGasLimit(tx)
        try tx.sign(privateKey: privateKey)
        let result = try await web3.eth.send(raw: tx.encode(for: .transaction)!)
        return result.hash
    }

    func query<T>(_ method: String, parameters: [Any] = [], from: EthereumAddress = NullAddr, outType: T.Type) async throws -> T {
        let read = contract.createReadOperation(method, parameters: parameters)!
        if(from != Safe4Contract.NullAddr) {
            read.transaction.from = from
        }
        let result = try await read.callContractMethod()
        guard let res = result["0"] as? T else { throw Web3Error.processingError(desc: "Failed to get result of expected type from the Ethereum node") }
        return res
    }

    func queryStruct<T: Safe4T>(_ method: String, parameters: [Any] = [], from: EthereumAddress = NullAddr, outType: T.Type) async throws -> T {
        let read = contract.createReadOperation(method, parameters: parameters)!
        if(from != Safe4Contract.NullAddr) {
            read.transaction.from = from
        }
        let result = try await read.callContractMethod()
        // guard result["0"] is [Any] else { throw Web3Error.processingError(desc: "Failed to get struct result from the Ethereum node") }
        return outType.init(result)!
    }

    func queryStructList<T: Safe4T>(_ method: String, parameters: [Any] = [], from: EthereumAddress = NullAddr, outType: T.Type) async throws -> [T] {
        let read = contract.createReadOperation(method, parameters: parameters)!
        if(from != Safe4Contract.NullAddr) {
            read.transaction.from = from
        }
        let result = try await read.callContractMethod()
        guard let values =  result["0"] as? [Any] else { throw Web3Error.processingError(desc: "Failed to get struct result list from the Ethereum node") }
        var ret: [T] = []
        var temp: [String: Any] = [:]
        for item in values {
            temp["0"] = item
            ret.append(outType.init(temp)!)
        }
        return ret
    }

    // func queryMulti<T: Safe4T>(_ method: String, parameters: [Any] = [], from: EthereumAddress = NullAddr, outType: T.Type) async throws -> T {
    //     let read = contract.createReadOperation(method, parameters: parameters)!
    //     if(from != Safe4Contract.NullAddr) {
    //         read.transaction.from = from
    //     }
    //     let result = try await read.callContractMethod()
    //     guard result.count > 2 else { throw Web3Error.processingError(desc: "Failed to get multi result from the Ethereum node") }
    //     return outType.init(result)!
    // }
}
