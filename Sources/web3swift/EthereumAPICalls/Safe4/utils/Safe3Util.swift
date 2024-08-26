import Foundation
import Web3Core

public class Safe3Util {
    public static func getUncompressedPublicKey(_ privateKey: Data) -> Data {
        return Utilities.privateToPublic(privateKey)!
    }

    public static func getCompressedPublicKey(_ privateKey: Data) -> Data {
        return Utilities.privateToPublic(privateKey, compressed: true)!
    }

    public static func getSafe3Addr(_ publicKey: Data) -> String {
        let keyID = getKeyID(publicKey)
        let arr = keyID.withUnsafeBytes { Array($0) }
        return arr.base58EncodedString
    }

    public static func getKeyID(_ publicKey: Data) -> Data {
        // print("1. public key: " + publicKey.toHexString())

        var hash = publicKey.sha256()
        // print("2. SHA256 of 1: " + hash.toHexString())

        let r = try! RIPEMD160.hash(message: hash)
        // print("3. ripemd160: " + r.toHexString())

        var temp = Data()
        temp.append(UInt8(0x4c))
        temp.append(r)
        // print("4. Add network bytes to 3: " + temp.toHexString());

        hash = temp.sha256()
        // print("5. SHA256 of 4: " + hash.toHexString())
        hash = hash.sha256()
        // print("6. SHA256 of 5: " + hash.toHexString())

        var keyID = Data()
        keyID.append(temp)
        keyID.append(hash[0..<4])
        // print("7. keyID: " + keyID.toHexString())
        return keyID
    }

    public static func sha256(_ message: String) -> Data {
        let d = message.data(using: .utf8)!
        return d.sha256()
    }
}
