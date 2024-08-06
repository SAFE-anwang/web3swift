import Foundation
import BigInt
import Web3Core

public class Safe3 {
    private var contract: Safe4Contract

    init(provider: Web3Provider, web3: Web3) {
        contract = Safe4Contract(provider: provider, web3: web3, contractAddr: Safe4ContractAddress.Safe3ContractAddr, contractABI: Safe4ContractABI.Safe3ABI)
    }
}

public extension Safe3 {
    func redeemSafe3(privateKey: Data) async throws -> [String: [String]] {
        let compressedPublicKey = Safe3Util.getCompressedPublicKey(privateKey)
        let compressedSafe3Addr = Safe3Util.getSafe3Addr(compressedPublicKey)
        let uncompressedPublicKey = Safe3Util.getUncompressedPublicKey(privateKey)
        let uncompressedSafe3Addr = Safe3Util.getSafe3Addr(uncompressedPublicKey)
        let sig4compress = contract.signMessage(Safe3Util.sha256(compressedSafe3Addr), privateKey)
        let sig4uncompress = contract.signMessage(Safe3Util.sha256(uncompressedSafe3Addr), privateKey)

        // print(compressedPublicKey.toHexString())
        // print(compressedSafe3Addr)
        // print(uncompressedPublicKey.toHexString())
        // print(uncompressedSafe3Addr)
        // print(sig4compress.toHexString())
        // print(sig4uncompress.toHexString())

        var availableTxids: [String] = []
        var lockedTxids: [String] = []

        // 1. Available Safe3
        // 1-1. compressed address
        if ((try await existAvailableNeedToRedeem(compressedSafe3Addr))) {
            availableTxids.append(try await contract.call(privateKey: privateKey, method: "redeemAvailable", parameters: [compressedPublicKey, sig4compress]))
        }
        // 1-2. uncompressed address
        if ((try await existAvailableNeedToRedeem(uncompressedSafe3Addr))) {
            availableTxids.append(try await contract.call(privateKey: privateKey, method: "redeemAvailable", parameters: [uncompressedPublicKey, sig4uncompress]))
        }

        // 2. Locked Safe3
        // 1-1. compressed address
        if ((try await existLockedNeedToRedeem(compressedSafe3Addr))) {
            lockedTxids.append(try await contract.call(privateKey: privateKey, method: "redeemLocked", parameters: [compressedPublicKey, sig4compress]))
        }
        // 1-2. uncompressed address
        if ((try await existLockedNeedToRedeem(uncompressedSafe3Addr))) {
            lockedTxids.append(try await contract.call(privateKey: privateKey, method: "redeemLocked", parameters: [uncompressedPublicKey, sig4uncompress]))
        }

        var ret: [String: [String]] = [:]
        if (availableTxids.count > 0) {
            ret["available"] = availableTxids
        }
        if (lockedTxids.count > 0) {
            ret["locked"] = lockedTxids
        }
        return ret
    }

    func redeemMasterNode(privateKey: Data, enode: String) async throws -> [String] {
        let compressedPublicKey = Safe3Util.getCompressedPublicKey(privateKey)
        let compressedSafe3Addr = Safe3Util.getSafe3Addr(compressedPublicKey)
        let uncompressedPublicKey = Safe3Util.getUncompressedPublicKey(privateKey)
        let uncompressedSafe3Addr = Safe3Util.getSafe3Addr(uncompressedPublicKey)
        let sig4compress = contract.signMessage(Safe3Util.sha256(compressedSafe3Addr), privateKey)
        let sig4uncompress = contract.signMessage(Safe3Util.sha256(uncompressedSafe3Addr), privateKey)

        // print(compressedPublicKey.toHexString())
        // print(compressedSafe3Addr)
        // print(uncompressedPublicKey.toHexString())
        // print(uncompressedSafe3Addr)
        // print(sig4compress.toHexString())
        // print(sig4uncompress.toHexString())

        var txids: [String] = []
        // 1. compressed address
        if ((try await existMasterNodeNeedToRedeem(compressedSafe3Addr))) {
            txids.append(try await contract.call(privateKey: privateKey, method: "redeemMasterNode", parameters: [compressedPublicKey, sig4compress, enode]))
        }
        // 2. uncompressed address
        if ((try await existMasterNodeNeedToRedeem(uncompressedSafe3Addr))) {
            txids.append(try await contract.call(privateKey: privateKey, method: "redeemMasterNode", parameters: [uncompressedPublicKey, sig4uncompress, enode]))
        }
        return txids
    }

    func getAllAvailableNum() async throws -> BigUInt {
        return try await contract.query("getAllAvailableNum", outType: BigUInt.self)
    }

    func getAvailableInfos(_ start: BigUInt, _ count: BigUInt) async throws -> [AvailableSafe3Info] {
        return try await contract.queryStructList("getAvailableInfos", parameters: [start, count], outType: AvailableSafe3Info.self)
    }

    func getAvailableInfo(_ safe3Addr: String) async throws -> AvailableSafe3Info {
        return try await contract.queryStruct("getAvailableInfo", parameters: [safe3Addr], outType: AvailableSafe3Info.self)
    }

    func getAllLockedNum() async throws -> BigUInt {
        return try await contract.query("getAllLockedNum", outType: BigUInt.self)
    }

    func getLockedAddrNum() async throws -> BigUInt {
        return try await contract.query("getLockedAddrNum", outType: BigUInt.self)
    }

    func getLockedAddrs(_ start: BigUInt, _ count: BigUInt) async throws -> [String] {
        return try await contract.query("getLockedAddrs", parameters: [start, count], outType: [String].self)
    }

    func getLockedNum(_ safe3Addr: String) async throws -> BigUInt {
        return try await contract.query("getLockedNum", parameters: [safe3Addr], outType: BigUInt.self)
    }

    func getLockedInfo(_ safe3Addr: String, _ start: BigUInt, _ count: BigUInt) async throws -> [LockedSafe3Info] {
        return try await contract.queryStructList("getLockedInfo", parameters: [safe3Addr, start, count], outType: LockedSafe3Info.self)
    }

    func existAvailableNeedToRedeem(_ safe3Addr: String) async throws -> Bool {
        return try await contract.query("existAvailableNeedToRedeem", parameters: [safe3Addr], outType: Bool.self)
    }

    func existLockedNeedToRedeem(_ safe3Addr: String) async throws -> Bool {
        return try await contract.query("existLockedNeedToRedeem", parameters: [safe3Addr], outType: Bool.self)
    }

    func existMasterNodeNeedToRedeem(_ safe3Addr: String) async throws -> Bool {
        return try await contract.query("existMasterNodeNeedToRedeem", parameters: [safe3Addr], outType: Bool.self)
    }
}
