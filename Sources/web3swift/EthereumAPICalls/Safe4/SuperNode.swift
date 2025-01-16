import Foundation
import BigInt
import Web3Core

public class SuperNode {
    private let logic: Safe4Contract
    private let storage: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        logic = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.SuperNodeLogicContractAddr, contractABI: Safe4ContractABI.SuperNodeLogicABI)
        storage = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.SuperNodeStorageContractAddr, contractABI: Safe4ContractABI.SuperNodeStorageABI)
    }
}

public extension SuperNode {
    func register(privateKey: Data, value: BigUInt, isUnion: Bool, addr: EthereumAddress, lockDay: BigUInt, name: String, enode: String, description: String, creatorIncentive: BigUInt, partnerIncentive: BigUInt, voterIncentive: BigUInt) async throws -> String {
        return try await logic.call(privateKey: privateKey, value: value, method: "register", parameters: [isUnion, addr, lockDay, name, enode, description, creatorIncentive, partnerIncentive, voterIncentive])
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

    func changeName(privateKey: Data, addr: EthereumAddress, name: String) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeName", parameters: [addr, name])
    }

    func changeEnode(privateKey: Data, addr: EthereumAddress, enode: String) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeEnode", parameters: [addr, enode])
    }

    func changeDescription(privateKey: Data, addr: EthereumAddress, description: String) async throws -> String {
        return try await logic.call(privateKey: privateKey, method: "changeDescription", parameters: [addr, description])
    }

    func getInfo(_ addr: EthereumAddress) async throws -> SuperNodeInfo {
        return try await storage.queryStruct("getInfo", parameters: [addr], outType: SuperNodeInfo.self)
    }

    func getInfoByID(_ id: BigUInt) async throws -> SuperNodeInfo {
        return try await storage.queryStruct("getInfoByID", parameters: [id], outType: SuperNodeInfo.self)
    }

    func getNum() async throws -> BigUInt {
        return try await storage.query("getNum", outType: BigUInt.self)
    }

    func getAll(_ start: BigUInt, _ count: BigUInt) async throws -> [EthereumAddress] {
        return try await storage.query("getAll", parameters: [start, count], outType: [EthereumAddress].self)
    }

    func getAddrNum4Creator(_ creator: EthereumAddress) async throws -> BigUInt {
        return try await storage.query("getAddrNum4Creator", parameters: [creator], outType: BigUInt.self)
    }

    func getAddrs4Creator(_ creator: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [EthereumAddress] {
        return try await storage.query("getAddrs4Creator", parameters: [creator, start, count], outType: [EthereumAddress].self)
    }

    func getAddrNum4Partner(_ partner: EthereumAddress) async throws -> BigUInt {
        return try await storage.query("getAddrNum4Partner", parameters: [partner], outType: BigUInt.self)
    }

    func getAddrs4Partner(_ partner: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [EthereumAddress] {
        return try await storage.query("getAddrs4Partner", parameters: [partner, start, count], outType: [EthereumAddress].self)
    }

    func getTops() async throws -> [EthereumAddress] {
        return try await storage.query("getTops", outType: [EthereumAddress].self)
    }

    func getTops4Creator(_ creator: EthereumAddress) async throws -> [EthereumAddress] {
        return try await storage.query("getTops4Creator", parameters: [creator], outType: [EthereumAddress].self)
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

    func existName(_ name: String) async throws -> Bool {
        return try await storage.query("existName", parameters: [name], outType: Bool.self)
    }

    func existEnode(_ enode: String) async throws -> Bool {
        return try await storage.query("existEnode", parameters: [enode], outType: Bool.self)
    }

    func existLockID(_ addr: EthereumAddress, _ lockID: BigUInt) async throws -> Bool {
        return try await storage.query("existLockID", parameters: [addr, lockID], outType: Bool.self)
    }

    func existFounder(_ founder: EthereumAddress) async throws -> Bool {
        return try await storage.query("existFounder", parameters: [founder], outType: Bool.self)
    }

    func isValid(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("isValid", parameters: [addr], outType: Bool.self)
    }

    func isFormal(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("isFormal", parameters: [addr], outType: Bool.self)
    }

    func isUnion(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("isUnion", parameters: [addr], outType: Bool.self)
    }

    func existNodeAddress(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("existNodeAddress", parameters: [addr], outType: Bool.self)
    }

    func existNodeEnode(_ enode: String) async throws -> Bool {
        return try await storage.query("existNodeEnode", parameters: [enode], outType: Bool.self)
    }

    func existNodeFounder(_ addr: EthereumAddress) async throws -> Bool {
        return try await storage.query("existNodeFounder", parameters: [addr], outType: Bool.self)
    }
}
