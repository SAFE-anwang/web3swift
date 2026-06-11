import XCTest

@testable import Web3Core
@testable import web3swift

class DAppManagerTest: LocalTestCase {
    func testRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let name = "test3";
        let contractAddr = EthereumAddress("0x882318EAf2B9E44649019ffB731989b02d16eAFc")!
        let runUrl = "https://test3.dapp.com";
        let description = "This is adapp for testing";
        let txid = try await web3.safe4.dapp.register(privateKey: privateKey, name: name, contractAddr: contractAddr, runUrl: runUrl, description: description, gitUrl: "", officialUrl: "", officialEmail: "")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.dapp.setName(privateKey: privateKey, id: 3, name: "test_3")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetContractAddr() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let contractAddr = EthereumAddress("0x1f60e443916cc8ecdcdfa6b487443a575314dccf")!
        let txid = try await web3.safe4.dapp.setContractAddr(privateKey: privateKey, id: 3, contractAddr: contractAddr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetRunUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let runUrl = "https://test_3.dapp.com"
        let txid = try await web3.safe4.dapp.setRunUrl(privateKey: privateKey, id: 3, runUrl: runUrl)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetGitUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let gitUrl = "https://www.github.com/dapp/test_3"
        let txid = try await web3.safe4.dapp.setGitUrl(privateKey: privateKey, id: 3, gitUrl: gitUrl)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetOfficialUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let officialUrl = "https://www.dapp.com"
        let txid = try await web3.safe4.dapp.setOfficialUrl(privateKey: privateKey, id: 3, officialUrl: officialUrl)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetOfficialEmail() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let officialEmail = "test_3@dapp.com"
        let txid = try await web3.safe4.dapp.setOfficialEmail(privateKey: privateKey, id: 3, officialEmail: officialEmail)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetOfficialAccount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let account = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let txid = try await web3.safe4.dapp.setOfficialAccount(privateKey: privateKey, id: 3, account: account)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let description = "This is a dapp for test!!!";
        let txid = try await web3.safe4.dapp.setDescription(privateKey: privateKey, id: 3, description: description)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetKeyword() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let keyword = "test|game";
        let txid = try await web3.safe4.dapp.setKeyword(privateKey: privateKey, id: 3, keyword: keyword)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let logoUrl = URL(fileURLWithPath: "/Users/lmb/Desktop/104.png")
        do {
            let logo = try Data(contentsOf: logoUrl)
            let txid = try await web3.safe4.dapp.setLogo(privateKey: privateKey, id: 3, logo: logo)
            print(txid)
            XCTAssertNotEqual(txid, nil)
        } catch {
            throw Web3Error.processingError(desc: "unknown logo")
        }
    }

    func testRemove() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.dapp.remove(privateKey: privateKey, id: 3)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testMarkFraud() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.dapp.markFraud(privateKey: privateKey, id: 3, flag: true)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.getInfo(3)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetInfoByName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.getInfoByName("test_3")
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetInfoByContractAddr() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let contractAddr = EthereumAddress("0x1f60e443916cc8ecdcdfa6b487443a575314dccf")!
        let ret = try await web3.safe4.dapp.getInfoByContractAddr(contractAddr)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetInfoByRunUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let runUrl = "https://test_3.dapp.com"
        let ret = try await web3.safe4.dapp.getInfoByRunUrl(runUrl)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let logo = try await web3.safe4.dapp.getLogo(3)
        print(logo.toHexString())
        XCTAssertNotEqual(logo, nil)
    }

    func testGetNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.getNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.getIDs(0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetMineNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let account = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let ret = try await web3.safe4.dapp.getMineNum(account)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetMineIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let account = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let ret = try await web3.safe4.dapp.getMineIDs(account, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testExistID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.existID(3)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.existName("test_3")
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistContractAddr() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let contractAddr = EthereumAddress("0x1f60e443916cc8ecdcdfa6b487443a575314dccf")!
        let ret = try await web3.safe4.dapp.existContractAddr(contractAddr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistRunUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let runUrl = "https://test_3.dapp.com"
        let ret = try await web3.safe4.dapp.existRunUrl(runUrl)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testIsMarkedFraud() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let account = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let ret = try await web3.safe4.dapp.isMarkedFraud(account, 3)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testIsFrozen() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.dapp.isFrozen(3)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testGetLogoPayAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let payAmount = try await web3.safe4.dapp.getLogoPayAmount()
        print(payAmount)
        XCTAssertNotEqual(payAmount, nil)
    }

    func testGetLogoPayAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let payAddress = try await web3.safe4.dapp.getLogoPayAddress()
        print(payAddress)
        XCTAssertNotEqual(payAddress, nil)
    }
}
