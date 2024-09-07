import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class MasterNodeTest: LocalTestCase {
    func testRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let addr = EthereumAddress("0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652")!
        let value = BigUInt("200000000000000000000")
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.173:30303"
        let description = "masternode3 for test"
        let txid = try await web3.safe4.masternode.register(privateKey: privateKey, value: value, isUnion: true, addr: addr, lockDay: 720, enode: enode, description: description, creatorIncentive: 40, partnerIncentive: 60)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testAppendRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let value = BigUInt("800000000000000000000")
        let addr = EthereumAddress("0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652")!
        let txid = try await web3.safe4.masternode.appendRegister(privateKey: privateKey, value: value, addr: addr, lockDay: 360)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testTurnRegister() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let addr = EthereumAddress("0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652")!
        let txid = try await web3.safe4.masternode.turnRegister(privateKey: privateKey, addr: addr, lockID: 10)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let addr = EthereumAddress("0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652")!
        let newAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let txid = try await web3.safe4.masternode.changeAddress(privateKey: privateKey, addr: addr, newAddr: newAddr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.3:30303"
        let txid = try await web3.safe4.masternode.changeEnode(privateKey: privateKey, addr: addr, enode: enode)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652, privateKey: 0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816
        let privateKey = Data(hex: "0x40f93c4fb6ea8bcbc5e88c3c213bc86c72e68f5404ef047d6ac3b3e3db2dd816")
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let description = "mn-3 for test"
        let txid = try await web3.safe4.masternode.changeDescription(privateKey: privateKey, addr: addr, description: description)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getInfo(EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetInfoByID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getInfoByID(3)
        print(ret)
        XCTAssertTrue(ret.id > 0)
    }

    func testGetNext() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getNext()
        print(ret)
        XCTAssertTrue(ret.address.lengthOfBytes(using: String.Encoding.utf8) > 0)
    }

    func testGetNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAll() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getAll(0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetAddrNum4Creator() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getAddrNum4Creator(EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAddrs4Creator() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getAddrs4Creator(EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetOfficials() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.getOfficials()
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testExist() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.masternode.exist(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.masternode.existID(3)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.3:30303"
        let ret = try await web3.safe4.masternode.existEnode(enode)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistLockID() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.masternode.existLockID(addr, 8)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testIsValid() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.masternode.isValid(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.masternode.existNodeAddress(addr)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeEnode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let enode = "enode://f687439863fce1ff70dc40bec0fe5ea1ad0833a2672c29590b0aa9001e1488013e42e8adc96a6a9312ed1426d6bea47026d057df57a5856970b207afac771f09@10.0.0.3:30303"
        let ret = try await web3.safe4.masternode.existNodeEnode(enode)
        print(ret)
        XCTAssertTrue(ret)
    }

    func testExistNodeFounder() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0x69a6d725f772e44f11bd6d21ec5a92fdc7eab652")!
        let ret = try await web3.safe4.masternode.existNodeFounder(addr)
        print(ret)
        XCTAssertTrue(ret)
    }
}
