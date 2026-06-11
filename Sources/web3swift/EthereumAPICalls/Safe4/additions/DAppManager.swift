import Foundation
import BigInt
import Web3Core

public class DAppManager {
    private var contract: Safe4Contract

    init(web3: Web3) {
        let chainID = web3.provider.network?.chainID ?? 6666666
        contract = Safe4Contract(web3: web3, contractAddr: chainID == 6666666 ? Safe4ContractAddress.DAppManagerContractAddress_Test : Safe4ContractAddress.DAppManagerContractAddress_Main, contractABI: Safe4ContractABI.DAppManagerABI)
    }
}

public extension DAppManager {
    func register(privateKey: Data, name: String, contractAddr: EthereumAddress, runUrl: String, description: String, gitUrl: String, officialUrl: String, officialEmail: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "register", parameters: [name, contractAddr, runUrl, description, gitUrl, officialUrl, officialEmail])
    }

    func setName(privateKey: Data, id: BigUInt, name: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setName", parameters: [id, name])
    }

    func setContractAddr(privateKey: Data, id: BigUInt, contractAddr: EthereumAddress) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setContractAddr", parameters: [id, contractAddr])
    }

    func setRunUrl(privateKey: Data, id: BigUInt, runUrl: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setRunUrl", parameters: [id, runUrl])
    }

    func setGitUrl(privateKey: Data, id: BigUInt, gitUrl: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setGitUrl", parameters: [id, gitUrl])
    }

    func setOfficialUrl(privateKey: Data, id: BigUInt, officialUrl: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setOfficialUrl", parameters: [id, officialUrl])
    }

    func setOfficialEmail(privateKey: Data, id: BigUInt, officialEmail: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setOfficialEmail", parameters: [id, officialEmail])
    }

    func setOfficialAccount(privateKey: Data, id: BigUInt, account: EthereumAddress) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setOfficialAccount", parameters: [id, account])
    }

    func setDescription(privateKey: Data, id: BigUInt, description: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setDescription", parameters: [id, description])
    }

    func setKeyword(privateKey: Data, id: BigUInt, keyword: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "setKeyword", parameters: [id, keyword])
    }

    func setLogo(privateKey: Data, id: BigUInt, logo: Data) async throws -> String {
        if logo.count > 128 * 1024 {
            throw Web3Error.inputError(desc: "oversize logo, max size: 128 KB")
        }
        return try await contract.call(privateKey: privateKey, value: getLogoPayAmount(), method: "setLogo", parameters: [id, logo])
    }

    func remove(privateKey: Data, id: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "remove", parameters: [id])
    }

    func markFraud(privateKey: Data, id: BigUInt, flag: Bool) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "markFraud", parameters: [id, flag])
    }

    func getInfo(_ id: BigUInt) async throws -> DAppInfo {
        return try await contract.queryStruct("getInfo", parameters: [id], outType: DAppInfo.self)
    }

    func getInfoByName(_ name: String) async throws -> DAppInfo {
        return try await contract.queryStruct("getInfoByName", parameters: [name], outType: DAppInfo.self)
    }

    func getInfoByContractAddr(_ contractAddr: EthereumAddress) async throws -> DAppInfo {
        return try await contract.queryStruct("getInfoByContractAddr", parameters: [contractAddr], outType: DAppInfo.self)
    }

    func getInfoByRunUrl(_ runUrl: String) async throws -> DAppInfo {
        return try await contract.queryStruct("getInfoByRunUrl", parameters: [runUrl], outType: DAppInfo.self)
    }

    func getLogo(_ id: BigUInt) async throws -> Data {
        return try await contract.query("getLogo", parameters: [id], outType: Data.self)
    }

    func getNum() async throws -> BigUInt {
        return try await contract.query("getNum", outType: BigUInt.self)
    }

    func getIDs(_ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getIDs", parameters: [start, count], outType: [BigUInt].self)
    }

    func getMineNum(_ account: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getMineNum", parameters: [account], outType: BigUInt.self)
    }

    func getMineIDs(_ account: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getMineIDs", parameters: [account, start, count], outType: [BigUInt].self)
    }

    func existID(_ id: BigUInt) async throws -> Bool {
        return try await contract.query("existID", parameters: [id], outType: Bool.self)
    }

    func existName(_ name: String) async throws -> Bool {
        return try await contract.query("existName", parameters: [name], outType: Bool.self)
    }

    func existContractAddr(_ contractAddr: EthereumAddress) async throws -> Bool {
        return try await contract.query("existContractAddr", parameters: [contractAddr], outType: Bool.self)
    }

    func existRunUrl(_ runUrl: String) async throws -> Bool {
        return try await contract.query("existRunUrl", parameters: [runUrl], outType: Bool.self)
    }

    func isMarkedFraud(_ account: EthereumAddress, _ id: BigUInt) async throws -> Bool {
        return try await contract.query("isMarkedFraud", parameters: [account, id], outType: Bool.self)
    }

    func isFrozen(_ id: BigUInt) async throws -> Bool {
        return try await contract.query("isFrozen", parameters: [id], outType: Bool.self)
    }

    func getLogoPayAmount() async throws -> BigUInt {
        return try await contract.query("getLogoPayAmount", outType: BigUInt.self)
    }

    func getLogoPayAddress() async throws -> EthereumAddress {
        return try await contract.query("getLogoPayAddress", outType: EthereumAddress.self)
    }
}
