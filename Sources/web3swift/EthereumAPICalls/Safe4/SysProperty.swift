import Foundation
import BigInt
import Web3Core

public class SysProperty {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.PropertyContractAddr, contractABI: Safe4ContractABI.PropertyABI)
    }


}

public extension SysProperty {
    func applyUpdate(privateKey: Data, name: String, value: BigUInt, reason: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "applyUpdate", parameters: [name, value, reason])
    }

    func vote4Update(privateKey: Data, name: String, voteResult: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "vote4Update", parameters: [name, voteResult])
    }

    func getInfo(_ name: String) async throws -> PropertyInfo {
        return try await contract.queryStruct("getInfo", parameters: [name], outType: PropertyInfo.self)
    }

    func getUnconfirmedInfo(_ name: String) async throws -> UnconfirmedPropertyInfo {
        return try await contract.queryStruct("getUnconfirmedInfo", parameters: [name], outType: UnconfirmedPropertyInfo.self)
    }

    func getValue(_ name: String) async throws -> BigUInt {
        return try await contract.query("getValue", parameters: [name], outType: BigUInt.self)
    }

    func getNum() async throws -> BigUInt {
        return try await contract.query("getNum", outType: BigUInt.self)
    }

    func getAll(_ start: BigUInt, _ count: BigUInt) async throws -> [String] {
        return try await contract.query("getAll", parameters: [start, count], outType: [String].self)
    }

    func getUnconfirmedNum() async throws -> BigUInt {
        return try await contract.query("getUnconfirmedNum", outType: BigUInt.self)
    }

    func getAllUnconfirmed(_ start: BigUInt, _ count: BigUInt) async throws -> [String] {
        return try await contract.query("getAllUnconfirmed", parameters: [start, count], outType: [String].self)
    }

    func exist(_ name: String) async throws -> Bool {
        return try await contract.query("exist", parameters: [name], outType: Bool.self)
    }

    func existUnconfirmed(_ name: String) async throws -> Bool {
        return try await contract.query("existUnconfirmed", parameters: [name], outType: Bool.self)
    }
}
