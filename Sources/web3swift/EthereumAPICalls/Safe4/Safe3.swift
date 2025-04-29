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
        var lockedNums: [BigUInt] = []
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
                lockedNums.append(try await getLockedNum(safe3Addr))
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
                lockedNums.append(try await getLockedNum(safe3Addr))
            }
        }

        var txids: [String] = []
        if (availablePubKeys.count != 0) {
            var i = 0
            while i < availablePubKeys.count / 20 {
                txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemAvailable", parameters: [Array(availablePubKeys[i*20..<(i+1)*20]), Array(availableSigs[i*20..<(i+1)*20]), targetAddr]))
                i += 1
            }
            if (availablePubKeys.count % 20 != 0) {
                txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemAvailable", parameters: [Array(availablePubKeys[i*20..<availablePubKeys.count]), Array(availableSigs[i*20..<availableSigs.count]), targetAddr]))
            }
        }
        if (lockedPubKeys.count != 0) {
            while true {
                var totalLockedNum: BigUInt = 0
                var tempPubkeys: [Data] = []
                var tempSigs: [Data] = []
                var i = 0
                while i < lockedNums.count {
                    totalLockedNum += lockedNums[i]
                    if (totalLockedNum == 0) {
                        i += 1
                        continue
                    }
                    if (totalLockedNum >= 100) {
                        tempPubkeys.append(lockedPubKeys[i])
                        tempSigs.append(lockedSigs[i])
                        txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemLocked", parameters: [tempPubkeys, tempSigs, targetAddr]))
                        if (totalLockedNum == 100) {
                            lockedNums[i] = 0
                        } else {
                            lockedNums[i] = totalLockedNum - 100
                        }
                        break
                    } else {
                        lockedNums[i] = 0
                        tempPubkeys.append(lockedPubKeys[i])
                        tempSigs.append(lockedSigs[i])
                        if (tempPubkeys.count == 20) {
                            txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemLocked", parameters: [tempPubkeys, tempSigs, targetAddr]))
                            break
                        }
                        i += 1
                    }
                }
                if (totalLockedNum == 0) {
                    break
                }
                if (i == lockedNums.count) {
                    txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemLocked", parameters: [tempPubkeys, tempSigs, targetAddr]))
                    break
                }
            }
        }
        return txids
    }

    func batchRedeemMasterNode(callerPrivateKey: Data, privateKeys: [Data], enodes: [String], targetAddr: EthereumAddress) async throws -> [String] {
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

        var txids: [String] = []
        if (pubKeys.count != 0) {
            var i = 0
            while i < pubKeys.count / 20 {
                txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemMasterNode", parameters: [Array(pubKeys[i*20..<(i+1)*20]), Array(sigs[i*20..<(i+1)*20]), Array(enodes[i*20..<(i+1)*20]), targetAddr]))
                i += 1
            }
            if (pubKeys.count % 20 != 0) {
                txids.append(try await contract.call(privateKey: callerPrivateKey, method: "batchRedeemMasterNode", parameters: [Array(pubKeys[i*20..<pubKeys.count]), Array(sigs[i*20..<sigs.count]), Array(enodes[i*20..<enodes.count]), targetAddr]))
            }
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
