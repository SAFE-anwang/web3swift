import Foundation
import BigInt
import Web3Core

public class MasterNode {
    private let logic: Safe4Contract
    private let storage: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        logic = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.MasterNodeLogicContractAddr, contractABI: Safe4ContractABI.MasterNodeLogicABI)
        storage = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.MasterNodeStorageContractAddr, contractABI: Safe4ContractABI.MasterNodeStorageABI)
    }

    func register(privateKey: Data, value: BigUInt, isUnion: Bool, addr: EthereumAddress, lockDay: BigUInt, enode: String, description: String, creatorIncentive: BigUInt, partnerIncentive: BigUInt) async throws -> String {
        return try await logic.call(privateKey: privateKey, value: value, method: "register", parameters: [isUnion, addr, lockDay, enode, description, creatorIncentive, partnerIncentive])
    }

    func appendRegister(privateKey: Data, value: BigUInt, addr: EthereumAddress, lockDay: BigUInt) async throws -> String {
        return try await logic.call(privateKey: privateKey, value: value, method: "appendRegister", parameters: [addr, lockDay])
    }

    func turnRegister(privateKey: Data, addr: EthereumAddress, lockID: BigUInt) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "turnRegister", parameters: [addr, lockID])
    }

    func changeAddress(privateKey: Data, addr: EthereumAddress, newAddr: EthereumAddress) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeAddress", parameters: [addr, newAddr])
    }

    func changeEnode(privateKey: Data, addr: EthereumAddress, enode: String) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeEnode", parameters: [addr, enode])
    }

    func changeDescription(privateKey: Data, addr: EthereumAddress, description: String) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeDescription", parameters: [addr, description])
    }

    func getInfo(_ addr: EthereumAddress) async throws -> MasterNodeInfo {
        return try await storage.queryStruct("getInfo", parameters: [addr], outType: MasterNodeInfo.self)
    }

    func getInfoByID(_ id: BigUInt) async throws -> MasterNodeInfo {
        return try await storage.queryStruct("getInfoByID", parameters: [id], outType: MasterNodeInfo.self)
    }

    func getNext() async throws -> EthereumAddress {
        return try await storage.query("getNext", outType: EthereumAddress.self)
    }

    func getNum() async throws -> BigUInt {
        return try await storage.query("getNum", outType: BigUInt.self)
    }

    func getAll(_ start: BigUInt, _ count: BigUInt) async throws -> [EthereumAddress] {
        return try await storage.query("getAll", parameters: [start, count], outType: [EthereumAddress].self)
    }

    func getOfficials() async throws -> [EthereumAddress] {
        return try await storage.query("getOfficials", outType: [EthereumAddress].self)
    }

    func exist(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("exist", parameters: [addr], outType: Bool.self)
    }

    func existID(_ id: BigUInt) async throws -> Bool {
        return try await storage.query("existID", parameters: [id], outType: Bool.self)
    }

    func existEnode(_ enode: String) async throws -> Bool {
        return try await storage.query("existEnode", parameters: [enode], outType: Bool.self)
    }

    func existLockID(_ addr: EthereumAddress, _ lockID: BigUInt) async throws -> Bool {
        return try await storage.query("existLockID", parameters: [addr, lockID], outType: Bool.self)
    }

    func isValid(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("isValid", parameters: [addr], outType: Bool.self)
    }
}
