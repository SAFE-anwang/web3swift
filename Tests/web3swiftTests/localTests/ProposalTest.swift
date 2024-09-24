import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class ProposalTest: LocalTestCase {
    func testGetBalance() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getBalance()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testCreate() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // addr: 0xd52114c4071b5bfbd06a657a3db538bfd559a481, privateKey: 0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let title = "proposal-2"
        let payAmount = BigUInt("1500000000000000000")
        let payTimes = BigUInt(2)
        let startPayTime = BigUInt(1721470283)
        let endPayTime = BigUInt(1722334283);
        let description = "proposal-2 for test";
        let txid = try await web3.safe4.proposal.create(privateKey: privateKey, title: title, payAmount: payAmount, payTimes: payTimes, startPayTime: startPayTime, endPayTime: endPayTime, description: description)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testVote() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // sn: 0x918b8ed234e235a2ea5756fd5d9c80850ba3bb6d, privateKey: 0xfb5ae9ce44b96a5cb71f405806ec90493f18641776b44e9f267bed17c45a7874
        // sn: 0xd57574369a6c90a5622f17fbed30c891b9d70c3b, privateKey: 0x5bd818c9dd4d05351e9c7ff830d9ee7d556181a6473c84363ff7edb1dfc7e34f
        // sn: 0x556b5868919008607ef24f4eb2bde6feda3e42f2, privateKey: 0x73fc4be2c4a1d44f41c09ef138717a7994726461c9c256f25b36c3f3b570d9dd
        let privateKey = Data(hex: "0x5bd818c9dd4d05351e9c7ff830d9ee7d556181a6473c84363ff7edb1dfc7e34f")
        let txid = try await web3.safe4.proposal.vote(privateKey: privateKey, id: 1, voteResult: 1)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeTitle() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let title = "proposal 2"
        let txid = try await web3.safe4.proposal.changeTitle(privateKey: privateKey, id: 1, title: title)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangePayAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.proposal.changePayAmount(privateKey: privateKey, id: 1, payAmount: BigUInt("1000000000000000000"))
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangePayTimes() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.proposal.changePayTimes(privateKey: privateKey, id: 1, payTimes: 3)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeStartPayTime() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.proposal.changeStartPayTime(privateKey: privateKey, id: 1, startPayTime: BigUInt(1719828683))
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeEndPayTime() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.proposal.changeEndPayTime(privateKey: privateKey, id: 1, endPayTime: BigUInt(1719828683))
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testChangeDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.proposal.changeDescription(privateKey: privateKey, id: 1, description: "proposal 2 for test")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getInfo(1)
        print(ret)
        XCTAssertTrue(ret.title.lengthOfBytes(using: String.Encoding.utf8) > 0)
    }

    func testGetVoterNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getVoterNum(1)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetVoteInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getVoteInfo(1, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAll() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getAll(0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetMineNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getMineNum(EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetMines() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.getMines(EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testExist() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.proposal.exist(1)
        print(ret)
        XCTAssertTrue(ret)
    }
}
