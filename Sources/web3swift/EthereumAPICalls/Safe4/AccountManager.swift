import Foundation
import BigInt
import Web3Core

public class AccountManager {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.AccountManagerContractAddr, contractABI: Safe4ContractABI.AccountManagerABI)
    }
}

public extension AccountManager {
    func deposit(privateKey: Data, value: BigUInt, to: EthereumAddress, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "deposit", parameters: [to, lockDay])
    }

    func batchDeposit4One(privateKey: Data, value: BigUInt, to: EthereumAddress, times: BigUInt, spaceDay: BigUInt, startDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "batchDeposit4One", parameters: [to, times, spaceDay, startDay])
    }

    func batchDeposit4Multi(privateKey: Data, value: BigUInt, addrs: [EthereumAddress], times: BigUInt, spaceDay: BigUInt, startDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "batchDeposit4Multi", parameters: [addrs, times, spaceDay, startDay])
    }

    func withdraw(privateKey: Data) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdraw")
    }

    func withdrawByID(privateKey: Data, ids: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdrawByID", parameters: [ids])
    }

    func transfer(privateKey: Data, to: EthereumAddress, amount: BigUInt, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "transfer", parameters: [to, amount, lockDay])
    }

    func addLockDay(privateKey: Data, id: BigUInt, day: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "addLockDay", parameters: [id, day])
    }

    func getTotalAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getTotalAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    func getTotalIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getTotalIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    func getAvailableAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getAvailableAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    func getAvailableIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getAvailableIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    func getLockedAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getLockedAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    func getLockedIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getLockedIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    func getUsedAmount(_ addr: EthereumAddress) async throws -> AccountAmountInfo {
        return try await contract.queryStruct("getUsedAmount", parameters: [addr], outType: AccountAmountInfo.self)
    }

    func getUsedIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getUsedIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }

    func getRecord0(_ addr: EthereumAddress) async throws -> AccountRecord {
        return try await contract.queryStruct("getRecord0", parameters: [addr], outType: AccountRecord.self)
    }

    func getRecordByID(_ id: BigUInt) async throws -> AccountRecord {
        return try await contract.queryStruct("getRecordByID", parameters: [id], outType: AccountRecord.self)
    }

    func getRecordUseInfo(_ id: BigUInt) async throws -> RecordUseInfo {
        return try await contract.queryStruct("getRecordUseInfo", parameters: [id], outType: RecordUseInfo.self)
    }
}
