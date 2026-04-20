import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SRC20LockFactoryTest: LocalTestCase {
    func testLock() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")! // SRC20: ABCD, contract-addr: 0x6b3914aF517A56D47A9997397325B7F37414A49c, total: 10000, creator: 0x4c207825db1c46Dd836123E58ecaE85de7025879
        let to = EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!
        let amount = BigUInt("100000000000000000") // 0.1 ABCD
        let txid = try await factory.lock(privateKey: privateKey, token: token, to: to, amount: amount, lockDay: 1) // lock 0.1 ABCD to 0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testBatchLock() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let to = EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!
        let amount = BigUInt("900000000000000000") // 0.9 ABCD
        let txid = try await factory.batchLock(privateKey: privateKey, token: token, to: to, amount: amount, times: 5, spaceDay: 1, startDay: 0) // batch lock 0.9 ABC to 0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testWithdrawByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let txid = try await factory.withdrawByID(privateKey: privateKey, token: token, ids: [1,2,3,4,5])
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetTotalIDNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getTotalIDNum(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetTotalIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getTotalIDs(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetAvailableIDNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getAvailableIDNum(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAvailableIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getAvailableIDs(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetLockedIDNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getLockedIDNum(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetLockedIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getLockedIDs(token, EthereumAddress("0xa5CEc2B8CdA30dA3F3170b4505CB44226b6c9Dd2")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetRecordByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getRecordByID(token, 6)
        print(ret)
        XCTAssertTrue(ret.amount > 0)
    }

    func testGetLock() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let token = EthereumAddress("0x6b3914aF517A56D47A9997397325B7F37414A49c")!
        let ret = try await factory.getLock(token)
        print(ret)
        XCTAssertNotEqual(ret, nil)
    }

    func testGetTOken() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let factory = SRC20LockFactory(web3: web3, contractAddr: "0x4f203092FB68732D8484c099a72dDc5a195f26f9")
        let lock = EthereumAddress("0x729b4db4a04b35c82e7c577d7ac471264bccf955")!
        let ret = try await factory.getToken(lock)
        print(ret)
        XCTAssertNotEqual(ret, nil)
    }
}