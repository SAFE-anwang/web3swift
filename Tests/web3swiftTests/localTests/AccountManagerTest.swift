import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class AccountManagerTest: LocalTestCase {
    func testDeposit() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        // 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2: privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.accountmanager.deposit(privateKey: privateKey, value: 1000000000000000000, to: EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!, lockDay: 0)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testWithdraw() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.accountmanager.withdraw(privateKey: privateKey)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testWithdrawByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.accountmanager.withdrawByID(privateKey: privateKey, ids: [8])
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testTransfer() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.accountmanager.transfer(privateKey: privateKey, to: EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!, amount: 100000000000000000, lockDay: 1)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testAddLockDay() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await web3.safe4.accountmanager.addLockDay(privateKey: privateKey, id: 7, day: 1)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetTotalAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getTotalAmount(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetTotalIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getTotalIDs(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetAvailableAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getAvailableAmount(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetAvailableIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getAvailableIDs(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetLockedAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getLockedAmount(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetLockedIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getLockedIDs(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetUsedAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getUsedAmount(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetUsedIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getUsedIDs(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetRecord0() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getRecord0(EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetRecordByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getRecordByID(7)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetRecordUseInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let ret = try await web3.safe4.accountmanager.getRecordUseInfo(1)
        print(ret)
        XCTAssertTrue(ret.unfreezeHeight > 0)
    }
}
