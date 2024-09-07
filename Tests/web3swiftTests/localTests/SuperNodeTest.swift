import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SuperNodeTest: LocalTestCase {
    func testRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let value = BigUInt("5000000000000000000000")
        let name = "supernode-5"
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.165:30303"
        let description = "supernode5 for test"
        let txid = try await web3.safe4.supernode.register(privateKey: privateKey, value: value, isUnion: false, addr: addr, lockDay: 720, name: name, enode: enode, description: description, creatorIncentive: 10, partnerIncentive: 50, voterIncentive: 40)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testAppendRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let value = BigUInt("500000000000000000000")
        let addr = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let txid = try await web3.safe4.supernode.appendRegister(privateKey: privateKey, value: value, addr: addr, lockDay: 360)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testTurnRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let txid = try await web3.safe4.supernode.turnRegister(privateKey: privateKey, addr: addr, lockID: 13)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let newAddr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let txid = try await web3.safe4.supernode.changeAddress(privateKey: privateKey, addr: addr, newAddr: newAddr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let name = "sn-5"
        let txid = try await web3.safe4.supernode.changeName(privateKey: privateKey, addr: addr, name: name)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.5:30303"
        let txid = try await web3.safe4.supernode.changeEnode(privateKey: privateKey, addr: addr, enode: enode)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2, privateKey: 0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let description = "sn-5 for test"
        let txid = try await web3.safe4.supernode.changeDescription(privateKey: privateKey, addr: addr, description: description)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getInfo(EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetInfoByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getInfoByID(5)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAll() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getAll(0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetAddrNum4Creator() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getAddrNum4Creator(EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAddrs4Creator() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getAddrs4Creator(EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetTops() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getTops()
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetTops4Creator() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getTops4Creator(EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetOfficials() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.getOfficials()
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testExist() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let ret = try await web3.safe4.supernode.exist(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.existID(5)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.supernode.existName("sn-5")
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.5:30303"
        let ret = try await web3.safe4.supernode.existEnode(enode)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistLockID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let ret = try await web3.safe4.supernode.existLockID(addr, 12)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistFounder() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let founder = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let ret = try await web3.safe4.supernode.existFounder(addr, founder)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testIsValid() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let ret = try await web3.safe4.supernode.isValid(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testIsFormal() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0x4d244c17d2a957f4a150408f8f4d19382ae8e2c8")!
        let ret = try await web3.safe4.supernode.isFormal(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd6ebea69f2d81b9ca259c0b6ed3d9ad6aa206ef1")!
        let ret = try await web3.safe4.supernode.existNodeAddress(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.5:30303"
        let ret = try await web3.safe4.supernode.existNodeEnode(enode)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeFounder() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let ret = try await web3.safe4.supernode.existNodeFounder(addr)
        print(ret)
        XCTAssertTrue(ret)
    }
}
