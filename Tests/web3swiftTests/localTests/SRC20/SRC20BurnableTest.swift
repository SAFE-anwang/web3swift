import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SRC20BurnableTest: LocalTestCase {
    func testDeploy() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Burnable(web3: web3)
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let ret = try await src20.deploy(privateKey: privateKey, name: "LMB106", symbol: "LMB106", totalSupply: BigUInt("10000000000000000000000000000"))
        print("contract address: " + ret[0])
        print("deploy txid: " + ret[1])
        XCTAssertEqual(ret.count, 2)
    }

    func testMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Burnable(web3: web3, contractAddr: "0xb77c7be366dff70b2c406d5e0355e5540a980bac")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let to = EthereumAddress("0xAC110c0f70867F77D9d230e377043F52480A0B7d")!
        let amount = BigUInt("10000000000000000000000000000")
        let txid = try await src20.mint(privateKey: privateKey, to: to, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testBurn() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Burnable(web3: web3, contractAddr: "0xb77c7be366dff70b2c406d5e0355e5540a980bac")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let amount = BigUInt("10000000000000000000000000000")
        let txid = try await src20.burn(privateKey: privateKey, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testTotalSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Burnable(web3: web3, contractAddr: "0xb77c7be366dff70b2c406d5e0355e5540a980bac")
        let totalSupply = try await src20.totalSupply()
        print(totalSupply)
        XCTAssertNotEqual(totalSupply, nil)
    }

    func testSetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20Burnable(web3: web3, contractAddr: "0xb77c7be366dff70b2c406d5e0355e5540a980bac")
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
}
