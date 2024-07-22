import Foundation
import BigInt
import Web3Core

public class Proposal {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.ProposalContractAddr, contractABI: Safe4ContractABI.ProposalABI)
    }
}

public extension Proposal {
    func getBalance() async throws -> BigUInt {
        return try await contract.query("getBalance", outType: BigUInt.self)
    }
    
    func create(privateKey: Data, title: String, payAmount: BigUInt, payTimes: BigUInt, startPayTime: BigUInt, endPayTime: BigUInt, description: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: BigUInt(1e18), method: "create", parameters: [title, payAmount, payTimes, startPayTime, endPayTime, description])
    }

    func vote(privateKey: Data, id: BigUInt, voteResult: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "vote", parameters: [id, voteResult])
    }

    func changeTitle(privateKey: Data, id: BigUInt, title: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changeTitle", parameters: [id, title])
    }

    func changePayAmount(privateKey: Data, id: BigUInt, payAmount: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changePayAmount", parameters: [id, payAmount])
    }

    func changePayTimes(privateKey: Data, id: BigUInt, payTimes: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changePayTimes", parameters: [id, payTimes])
    }

    func changeStartPayTime(privateKey: Data, id: BigUInt, startPayTime: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changeStartPayTime", parameters: [id, startPayTime])
    }

    func changeEndPayTime(privateKey: Data, id: BigUInt, endPayTime: BigUInt) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changeEndPayTime", parameters: [id, endPayTime])
    }

    func changeDescription(privateKey: Data, id: BigUInt, description: String) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "changeDescription", parameters: [id, description])
    }

    func getInfo(_ id: BigUInt) async throws -> ProposalInfo {
        return try await contract.queryStruct("getInfo", parameters: [id], outType: ProposalInfo.self)
    }

    func getVoterNum(_ id: BigUInt) async throws -> BigUInt {
        return try await contract.query("getVoterNum", parameters: [id], outType: BigUInt.self)
    }

    func getVoteInfo(_ id: BigUInt, _ start: BigUInt, _ count: BigUInt) async throws -> [ProposalVoteInfo] {
        return try await contract.queryStructList("getVoteInfo", parameters: [id, start, count], outType: ProposalVoteInfo.self)
    }

    func getNum() async throws -> BigUInt {
        return try await contract.query("getNum", outType: BigUInt.self)
    }

    func getAll(_ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getAll", parameters: [start, count], outType: [BigUInt].self)
    }

    func getMineNum(_ privateKey: Data) async throws -> BigUInt {
        let from = contract.getAddress(privateKey)!
        return try await contract.query("getMineNum", from: from, outType: BigUInt.self)
    }

    func getMines(_ privateKey: Data, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        let from = contract.getAddress(privateKey)!
        return try await contract.query("getMines", parameters: [start, count], from: from, outType: [BigUInt].self)
    }

    func exist(_ id: BigUInt) async throws -> Bool {
        return try await contract.query("exist", parameters: [id], outType: Bool.self)
    }
}
