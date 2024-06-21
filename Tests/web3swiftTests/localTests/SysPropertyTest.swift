import XCTest

@testable import Web3Core
@testable import web3swift

class SysPropertyTest: LocalTestCase {
    func testApplyUpdate() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        // sn: 0x556b5868919008607ef24f4eb2bde6feda3e42f2, privateKey: 0x73fc4be2c4a1d44f41c09ef138717a7994726461c9c256f25b36c3f3b570d9dd
        let privateKey = Data(hex: "0x73fc4be2c4a1d44f41c09ef138717a7994726461c9c256f25b36c3f3b570d9dd")
        let txid = try await web3.safe4.sysproperty.applyUpdate(privateKey: privateKey, name: "block_space", value: 2, reason: "this is a test")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testVote4Update() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        // sn: 0x918b8ed234e235a2ea5756fd5d9c80850ba3bb6d, privateKey: 0xfb5ae9ce44b96a5cb71f405806ec90493f18641776b44e9f267bed17c45a7874
        // sn: 0xd57574369a6c90a5622f17fbed30c891b9d70c3b, privateKey: 0x5bd818c9dd4d05351e9c7ff830d9ee7d556181a6473c84363ff7edb1dfc7e34f
        let privateKey = Data(hex: "0xfb5ae9ce44b96a5cb71f405806ec90493f18641776b44e9f267bed17c45a7874")
        let txid = try await web3.safe4.sysproperty.vote4Update(privateKey: privateKey, name: "block_space", voteResult: 1)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getInfo("block_space")
        print(ret)
        XCTAssertTrue(ret.name.lengthOfBytes(using: .utf8) > 0)
    }

    func testGetUnconfirmedInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getUnconfirmedInfo("block_space")
        print(ret)
        XCTAssertTrue(ret.name.lengthOfBytes(using: .utf8) > 0)
    }

    func testGetValue() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getValue("block_space")
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAll() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getAll(0, 10)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetUnconfirmedNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getUnconfirmedNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAllUnconfirmed() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.getAllUnconfirmed(0, 10)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testExist() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.exist("block_space")
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistUnconfirmed() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.sysproperty.existUnconfirmed("block_space")
        print(ret)
        XCTAssertTrue(ret)
    }
}
