import Foundation
import BigInt
import Web3Core

public class AccountManager {
    private var contract: Safe4Contract
    private(set) var type: ContractType
    
    init(web3: Web3, type: ContractType) {
        contract = Safe4Contract(web3: web3, contractAddr: type.contractAddr, contractABI: Safe4ContractABI.AccountManagerABI)
        self.type = type
    }
}

// supported ContractType: native, smallAmount_01, smallAmount_02
public extension AccountManager {

    func batchDeposit4One(privateKey: Data, value: BigUInt, to: EthereumAddress, times: BigUInt, spaceDay: BigUInt, startDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "batchDeposit4One", parameters: [to, times, spaceDay, startDay])
    }
    
    func withdrawByID(privateKey: Data, ids: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdrawByID", parameters: [ids])
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
}

// supported ContractType: native
public extension AccountManager {
    func deposit(privateKey: Data, value: BigUInt, to: EthereumAddress, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "deposit", parameters: [to, lockDay])
    }

    func batchDeposit4Multi(privateKey: Data, value: BigUInt, addrs: [EthereumAddress], times: BigUInt, spaceDay: BigUInt, startDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "batchDeposit4Multi", parameters: [addrs, times, spaceDay, startDay])
    }

    func withdraw(privateKey: Data) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdraw")
    }

    func transfer(privateKey: Data, to: EthereumAddress, amount: BigUInt, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "transfer", parameters: [to, amount, lockDay])
    }

    func addLockDay(privateKey: Data, id: BigUInt, day: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "addLockDay", parameters: [id, day])
    }

    func getImmatureAmount(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getImmatureAmount", parameters: [addr], outType: BigUInt.self)
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

public extension AccountManager {
    enum ContractType {
        case native
        case smallAmount_01 // [0.1, 1)
        case smallAmount_02 // [0.01, 0.1)
        
        var contractAddr: String {
            switch self {
            case .native:
                Safe4ContractAddress.AccountManagerContractAddr
            case .smallAmount_01:
                Safe4ContractAddress.AccountManagerContractAddr_91b2
            case .smallAmount_02:
                Safe4ContractAddress.AccountManagerContractAddr_4aC6
            }
        }
    }
}
