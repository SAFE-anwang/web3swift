import Foundation
import BigInt
import Web3Core

public class SRC20LockFactory {
    var abi = "[{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_lockAddr\",\"type\":\"address\"}],\"name\":\"CreateLockContract\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256[]\",\"name\":\"_ids\",\"type\":\"uint256[]\"}],\"name\":\"TokenBatchLock\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_lockDay\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_id\",\"type\":\"uint256\"}],\"name\":\"TokenLock\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256[]\",\"name\":\"_ids\",\"type\":\"uint256[]\"}],\"name\":\"TokenWithdraw\",\"type\":\"event\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_times\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_spaceDay\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_startDay\",\"type\":\"uint256\"}],\"name\":\"batchLock\",\"outputs\":[{\"internalType\":\"uint256[]\",\"name\":\"ids\",\"type\":\"uint256[]\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"}],\"name\":\"getAvailableIDNum\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_start\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_count\",\"type\":\"uint256\"}],\"name\":\"getAvailableIDs\",\"outputs\":[{\"internalType\":\"uint256[]\",\"name\":\"\",\"type\":\"uint256[]\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"}],\"name\":\"getLock\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"}],\"name\":\"getLockedIDNum\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_start\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_count\",\"type\":\"uint256\"}],\"name\":\"getLockedIDs\",\"outputs\":[{\"internalType\":\"uint256[]\",\"name\":\"\",\"type\":\"uint256[]\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_id\",\"type\":\"uint256\"}],\"name\":\"getRecordByID\",\"outputs\":[{\"components\":[{\"internalType\":\"uint256\",\"name\":\"id\",\"type\":\"uint256\"},{\"internalType\":\"address\",\"name\":\"addr\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"lockDay\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"startHeight\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"unlockHeight\",\"type\":\"uint256\"}],\"internalType\":\"struct SRC20LockFactory.LockRecord\",\"name\":\"\",\"type\":\"tuple\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_lock\",\"type\":\"address\"}],\"name\":\"getToken\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"}],\"name\":\"getTotalIDNum\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_addr\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_start\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_count\",\"type\":\"uint256\"}],\"name\":\"getTotalIDs\",\"outputs\":[{\"internalType\":\"uint256[]\",\"name\":\"\",\"type\":\"uint256[]\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_lockDay\",\"type\":\"uint256\"}],\"name\":\"lock\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"id\",\"type\":\"uint256\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"uint256[]\",\"name\":\"_ids\",\"type\":\"uint256[]\"}],\"name\":\"withdrawByID\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"

    private var contract: Safe4Contract

    public init(web3: Web3, contractAddr: String) {
        contract = Safe4Contract(web3: web3, contractAddr: contractAddr, contractABI: abi)
    }
}

public extension SRC20LockFactory {
    func lock(privateKey: Data, token: EthereumAddress, to: EthereumAddress, amount: BigUInt, lockDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "lock", parameters: [token, to, amount, lockDay])
    }

    func batchLock(privateKey: Data, token: EthereumAddress, to: EthereumAddress, amount: BigUInt, times: BigUInt, spaceDay: BigUInt, startDay: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "batchLock", parameters: [token, to, amount, times, spaceDay, startDay])
    }
    
    func withdrawByID(privateKey: Data, token: EthereumAddress, ids: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "withdrawByID", parameters: [token, ids])
    }

    func getTotalIDNum(_ token: EthereumAddress, _ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getTotalIDNum", parameters: [token, addr], outType: BigUInt.self)
    }

    func getTotalIDs(_ token: EthereumAddress, _ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getTotalIDs", parameters: [token, addr, start, count], outType: [BigUInt].self)
    }

    func getAvailableIDNum(_ token: EthereumAddress, _ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getAvailableIDNum", parameters: [token, addr], outType: BigUInt.self)
    }

    func getAvailableIDs(_ token: EthereumAddress, _ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getAvailableIDs", parameters: [token, addr, start, count], outType: [BigUInt].self)
    }

    func getLockedIDNum(_ token: EthereumAddress, _ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getLockedIDNum", parameters: [token, addr], outType: BigUInt.self)
    }

    func getLockedIDs(_ token: EthereumAddress, _ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getLockedIDs", parameters: [token, addr, start, count], outType: [BigUInt].self)
    }

    func getRecordByID(_ token: EthereumAddress, _ id: BigUInt) async throws -> LockRecord {
        return try await contract.queryStruct("getRecordByID", parameters: [token, id], outType: LockRecord.self)
    }

    func getLock(_ token: EthereumAddress) async throws -> EthereumAddress {
        return try await contract.query("getLock", parameters: [token], outType: EthereumAddress.self)
    }

    func getToken(_ lock: EthereumAddress) async throws -> EthereumAddress {
        return try await contract.query("getToken", parameters: [lock], outType: EthereumAddress.self)
    }

}
