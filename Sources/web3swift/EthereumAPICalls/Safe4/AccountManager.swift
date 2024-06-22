import Foundation
import BigInt
import Web3Core

public class AccountManager {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.AccountManagerContractAddr, contractABI: Safe4ContractABI.AccountManagerABI)
    }

    public func deposit(privateKey: Data, value: BigUInt, to: EthereumAddress, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "deposit", parameters: [to, lockDay])
    }

    public func withdraw(privateKey: Data) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdraw")
    }

    public func withdrawByID(privateKey: Data, ids: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdrawByID", parameters: [ids])
    }

    public func transfer(privateKey: Data, to: EthereumAddress, amount: BigUInt, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "transfer", parameters: [to, amount, lockDay])
    }

    public func addLockDay(privateKey: Data, id: BigUInt, day: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "addLockDay", parameters: [id, day])
    }

    public func getTotalAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getTotalAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    public func getTotalIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getTotalIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    public func getAvailableAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getAvailableAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    public func getAvailableIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getAvailableIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    public func getLockedAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getLockedAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    public func getLockedIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getLockedIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    public func getUsedAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getUsedAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    public func getUsedIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getUsedIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    public func getRecord0(_ addr: EthereumAddress) async throws -> AccountRecord {
        return try await contract.queryStruct("getRecord0", parameters: [addr], outType: AccountRecord.self)
    }

    public func getRecordByID(_ id: BigUInt) async throws -> AccountRecord {
        return try await contract.queryStruct("getRecordByID", parameters: [id], outType: AccountRecord.self)
    }

    public func getRecordUseInfo(_ id: BigUInt) async throws -> RecordUseInfo {
        return try await contract.queryStruct("getRecordUseInfo", parameters: [id], outType: RecordUseInfo.self)
    }
}
