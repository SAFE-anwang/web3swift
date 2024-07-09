import Foundation
import BigInt
import Web3Core

public class SNVote {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.SNVoteContractAddr, contractABI: Safe4ContractABI.SNVoteABI)
    }


}

public extension SNVote {
    func voteOrApproval(privateKey: Data, isVote: Bool, dstAddr: EthereumAddress, recordIDs: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "voteOrApproval", parameters: [isVote, dstAddr, recordIDs])
    }

    func voteOrApprovalWithAmount(privateKey: Data, value: BigUInt, isVote: Bool, dstAddr: EthereumAddress) async throws -> String {
        return try await contract.call(privateKey: privateKey, value: value, method: "voteOrApprovalWithAmount", parameters: [isVote, dstAddr])
    }

    func removeVoteOrApproval(privateKey: Data, recordIDs: [BigUInt]) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "removeVoteOrApproval", parameters: [recordIDs])
    }

    func proxyVote(privateKey: Data, snAddr: EthereumAddress) async throws -> String {
        return try await contract.call(privateKey: privateKey, method: "proxyVote", parameters: [snAddr])
    }

    func getAmount4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getAmount4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getVoteNum4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getVoteNum4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getSNNum4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getSNNum4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getSNs4Voter(_ voterAddr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> SNVoteRetInfo {
        return try await contract.queryStruct("getSNs4Voter", parameters: [voterAddr, start, count], outType: SNVoteRetInfo.self)
    }

    func getProxyNum4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getProxyNum4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getProxies4Voter(_ voterAddr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> SNVoteRetInfo {
        return try await contract.queryStruct("getProxies4Voter", parameters: [voterAddr, start, count], outType: SNVoteRetInfo.self)
    }

    func getVotedIDNum4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getVotedIDNum4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getVotedIDs4Voter(_ voterAddr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getVotedIDs4Voter", parameters: [voterAddr, start, count], outType: [BigUInt].self)
    }

    func getProxiedIDNum4Voter(_ voterAddr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getProxiedIDNum4Voter", parameters: [voterAddr], outType: BigUInt.self)
    }

    func getProxiedIDs4Voter(_ voterAddr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getProxiedIDs4Voter", parameters: [voterAddr, start, count], outType: [BigUInt].self)
    }

    func getTotalAmount(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getTotalAmount", parameters: [addr], outType: BigUInt.self)
    }

    func getTotalVoteNum(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getTotalVoteNum", parameters: [addr], outType: BigUInt.self)
    }

    func getVoterNum(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getVoterNum", parameters: [addr], outType: BigUInt.self)
    }

    func getVoters(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> SNVoteRetInfo {
        return try await contract.queryStruct("getVoters", parameters: [addr, start, count], outType: SNVoteRetInfo.self)
    }

    func getIDNum(_ addr: EthereumAddress) async throws -> BigUInt {
        return try await contract.query("getIDNum", parameters: [addr], outType: BigUInt.self)
    }

    func getIDs(_ addr: EthereumAddress, _ start: BigUInt, _ count: BigUInt) async throws -> [BigUInt] {
        return try await contract.query("getIDs", parameters: [addr, start, count], outType: [BigUInt].self)
    }
}
