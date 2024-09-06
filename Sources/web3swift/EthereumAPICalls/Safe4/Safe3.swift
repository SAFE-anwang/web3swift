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
    func batchRedeemSafe3(callerPrivateKey: Data, privateKeys: [Data], targetAddr: EthereumAddress) async throws -> [String] {
        var publicKey: Data
        var safe3Addr: String
        var sig: Data
        var availablePubKeys: [Data] = []
        var availableSigs: [Data] = []
        var lockedPubKeys: [Data] = []
        var lockedSigs: [Data] = []
        for privateKey in privateKeys {
            publicKey = Safe3Util.getCompressedPublicKey(privateKey)
            safe3Addr = Safe3Util.getSafe3Addr(publicKey)
            var buf: Data = Data()
            buf.append(safe3Addr.data(using: .utf8)!)
            buf.append(targetAddr.addressData)
            sig = contract.signMessage(buf.sha256(), privateKey)
            if ((try await existAvailableNeedToRedeem(safe3Addr))) {
                availablePubKeys.append(publicKey)
                availableSigs.append(sig)
            }
            if ((try await existLockedNeedToRedeem(safe3Addr))) {
                lockedPubKeys.append(publicKey)
                lockedSigs.append(sig)
            }

            publicKey = Safe3Util.getUncompressedPublicKey(privateKey)
            safe3Addr = Safe3Util.getSafe3Addr(publicKey)
            buf.removeAll()
            buf.append(safe3Addr.data(using: .utf8)!)
            buf.append(targetAddr.addressData)
            sig = contract.signMessage(buf.sha256(), privateKey)
            if ((try await existAvailableNeedToRedeem(safe3Addr))) {
                availablePubKeys.append(publicKey)
                availableSigs.append(sig)
            }
            if ((try await existLockedNeedToRedeem(safe3Addr))) {
                lockedPubKeys.append(publicKey)
                lockedSigs.append(sig)
            }
        }

        var txids: [String] = []
        if (availablePubKeys.count != 0) {
            txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemAvailable", parameters: [availablePubKeys, availableSigs, targetAddr]))
        }
        if (lockedPubKeys.count != 0) {
            txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemLocked", parameters: [lockedPubKeys, lockedSigs, targetAddr]))
        }
        return txids
    }

    func batchRedeemMasterNode(callerPrivateKey: Data, privateKeys: [Data], enodes: [String], targetAddr: EthereumAddress) async throws -> String {
        var publicKey: Data
        var safe3Addr: String
        var sig: Data
        var pubKeys: [Data] = []
        var sigs: [Data] = []
        for privateKey in privateKeys {
            publicKey = Safe3Util.getCompressedPublicKey(privateKey)
            safe3Addr = Safe3Util.getSafe3Addr(publicKey)
            var buf: Data = Data()
            buf.append(safe3Addr.data(using: .utf8)!)
            buf.append(targetAddr.addressData)
            sig = contract.signMessage(buf.sha256(), privateKey)
            if ((try await existMasterNodeNeedToRedeem(safe3Addr))) {
                pubKeys.append(publicKey)
                sigs.append(sig)
            }

            publicKey = Safe3Util.getUncompressedPublicKey(privateKey)
            safe3Addr = Safe3Util.getSafe3Addr(publicKey)
            buf.removeAll()
            buf.append(safe3Addr.data(using: .utf8)!)
            buf.append(targetAddr.addressData)
            sig = contract.signMessage(buf.sha256(), privateKey)
            if ((try await existMasterNodeNeedToRedeem(safe3Addr))) {
                pubKeys.append(publicKey)
                sigs.append(sig)
            }
        }

        if (pubKeys.count != 0) {
            return try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemMasterNode", parameters: [pubKeys, sigs, enodes, targetAddr])
        }
        return ""
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
