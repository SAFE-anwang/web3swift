import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SRC20MintableTest: LocalTestCase {
    func testDeploy() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Mintable(web3: web3)
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let ret = try await src20.deploy(privateKey: privateKey, name: "LMB204", symbol: "LMB204", totalSupply: BigUInt("10000000000000000000000000000"))
        print("contract address: " + ret[0])
        print("deploy txid: " + ret[1])
        XCTAssertEqual(ret.count, 2)
    }

    func testMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Mintable(web3: web3, contractAddr: "0xaBD508A67C851d2599bb85e15DcefbAb65764D95")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let to = EthereumAddress("0xAC110c0f70867F77D9d230e377043F52480A0B7d")!
        let amount = BigUInt("10000000000000000000000000000")
        let txid = try await src20.mint(privateKey: privateKey, to: to, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testTotalSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Mintable(web3: web3, contractAddr: "0xaBD508A67C851d2599bb85e15DcefbAb65764D95")
        let totalSupply = try await src20.totalSupply()
        print(totalSupply)
        XCTAssertNotEqual(totalSupply, nil)
    }

    func testSetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Mintable(web3: web3, contractAddr: "0xaBD508A67C851d2599bb85e15DcefbAb65764D95")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let logoUrl = URL(fileURLWithPath: "/Users/lmb/Desktop/104.png")
        do {
            let logo = try Data(contentsOf: logoUrl)
            let txid = try await src20.setLogo(privateKey: privateKey, logo: logo)
            print(txid)
            XCTAssertNotEqual(txid, nil)
        } catch {
            throw Web3Error.processingError(desc: "unknown logo")
        }
    }

    func testVersion() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0xaBD508A67C851d2599bb85e15DcefbAb65764D95")
        let version = try await src20.version()
        print(version)
        XCTAssertNotEqual(version, nil)
    }
}
