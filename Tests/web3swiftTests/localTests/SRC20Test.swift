import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SRC20Test: LocalTestCase {
    func testDeploy() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3)
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let ret = try await src20.deploy(privateKey: privateKey, name: "LMB104", symbol: "LMB104", totalSupply: BigUInt("10000000000000000000000000000"))
        print("contract address: " + ret[0])
        print("deploy txid: " + ret[1])
        XCTAssertEqual(ret.count, 2)
    }

    func testTransfer() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let to = EthereumAddress("0x4c207825db1c46Dd836123E58ecaE85de7025879")!
        let amount = BigUInt("100000000000000000000")
        let txid = try await src20.transfer(privateKey: privateKey, to: to, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let name = try await src20.name()
        print(name)
        XCTAssertNotEqual(name, nil)
    }

    func testSymbol() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let symbol = try await src20.symbol()
        print(symbol)
        XCTAssertNotEqual(symbol, nil)
    }

    func testDecimals() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let decimals = try await src20.decimals()
        print(decimals)
        XCTAssertNotEqual(decimals, nil)
    }

    func testTotalSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let totalSupply = try await src20.totalSupply()
        print(totalSupply)
        XCTAssertNotEqual(totalSupply, nil)
    }

    func testOwner() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let owner = try await src20.owner()
        print(owner)
        XCTAssertNotEqual(owner, nil)
    }

    func testBalanceOf() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let account = EthereumAddress("0x4c207825db1c46Dd836123E58ecaE85de7025879")!
        let balance = try await src20.balanceOf(account: account)
        print(balance)
        XCTAssertNotEqual(balance, nil)
    }

    func testSetOrgName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src20.setOrgName(privateKey: privateKey, orgName: "lmb")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
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

    func testSetDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src20.setDescription(privateKey: privateKey, description: "LMB104 is a test token")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetOfficialUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src20.setOfficialUrl(privateKey: privateKey, officialUrl: "https://www.lmb.com")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetWhitePaperUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src20.setWhitePaperUrl(privateKey: privateKey, whitePaperUrl: "https://www.lmb.com/whitepaper.pdf")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testOrgName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let orgName = try await src20.orgName()
        print(orgName)
        XCTAssertNotEqual(orgName, nil)
    }

    func testLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let logo = try await src20.logo()
        print(logo.toHexString())
        XCTAssertNotEqual(logo, nil)
    }

    func testDescritpion() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let description = try await src20.description()
        print(description)
        XCTAssertNotEqual(description, nil)
    }

    func testOfficialUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let officialUrl = try await src20.officialUrl()
        print(officialUrl)
        XCTAssertNotEqual(officialUrl, nil)
    }

    func testWhitePaperUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let whitePaperUrl = try await src20.whitePaperUrl()
        print(whitePaperUrl)
        XCTAssertNotEqual(whitePaperUrl, nil)
    }

    func testVersion() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src20 = SRC20(web3: web3, contractAddr: "0x63A66E12E449F3499e6530CCc6f506870e5b26e5")
        let version = try await src20.version()
        print(version)
        XCTAssertNotEqual(version, nil)
    }
}
