import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SNVoteTest: LocalTestCase {
    func testVoteOrApproval() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // addr: 0xd52114c4071b5bfbd06a657a3db538bfd559a481, privateKey: 0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let dstAddr = EthereumAddress("0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8")!
        let txid = try await web3.safe4.snvote.voteOrApproval(privateKey: privateKey, isVote: false, dstAddr: dstAddr, recordIDs: [0])
        // let dstAddr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        // let txid = try await web3.safe4.snvote.voteOrApproval(privateKey: privateKey, isVote: true, dstAddr: dstAddr, recordIDs: [7,8])
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testVoteOrApprovalWithAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // addr: 0xd52114c4071b5bfbd06a657a3db538bfd559a481, privateKey: 0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let dstAddr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let txid = try await web3.safe4.snvote.voteOrApprovalWithAmount(privateKey: privateKey, value: BigUInt(1e17), isVote: true, dstAddr: dstAddr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testRemoveVoteOrApproval() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // addr: 0xd52114c4071b5bfbd06a657a3db538bfd559a481, privateKey: 0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84
        let privateKey = Data(hex: "0xe171bcc091332eaa8fd76f529f880bd210b3187354706599b033df8155a94d84")
        let txid = try await web3.safe4.snvote.removeVoteOrApproval(privateKey: privateKey, recordIDs: [7])
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testProxyVote() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        // mn: 0x64ae0d18085d0c3ec202a208e96bc2fc24e4a7e8, privateKey: 0x02b0f66ceddcf16601dfc462ee3dfcc9adca7bf76b872fc23ca88d0b82f2550f
        let privateKey = Data(hex: "0x02b0f66ceddcf16601dfc462ee3dfcc9adca7bf76b872fc23ca88d0b82f2550f")
        let snAddr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let txid = try await web3.safe4.snvote.proxyVote(privateKey: privateKey, snAddr: snAddr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testGetAmount4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getAmount4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetVoteNum4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getVoteNum4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetSNNum4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getSNNum4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetSNs4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getSNs4Voter(voterAddr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.addrs.count > 0)
    }

    func testGetProxyNum4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getProxyNum4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetProxies4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getProxies4Voter(voterAddr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.addrs.count > 0)
    }

    func testGetVotedIDNum4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getVotedIDNum4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetVotedIDs4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getVotedIDs4Voter(voterAddr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetProxiedIDNum4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getProxiedIDNum4Voter(voterAddr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetProxiedIDs4Voter() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let voterAddr = EthereumAddress("0xd52114c4071b5bfbd06a657a3db538bfd559a481")!
        let ret = try await web3.safe4.snvote.getProxiedIDs4Voter(voterAddr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetTotalAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getTotalAmount(addr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetTotalVoteNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getTotalVoteNum(addr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetVoterNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getVoterNum(addr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetVoters() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getVoters(addr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.addrs.count > 0)
    }

    func testGetIDNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getIDNum(addr)
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetIDs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let addr = EthereumAddress("0xd57574369a6c90a5622f17fbed30c891b9d70c3b")!
        let ret = try await web3.safe4.snvote.getIDs(addr, 0, 100)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testGetAllAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.snvote.getAllAmount()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAllVoteNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.snvote.getAllVoteNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAllProxiedAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.snvote.getAllProxiedAmount()
        print(ret)
        XCTAssertTrue(ret > 0)
    }

    func testGetAllProxiedVoteNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let ret = try await web3.safe4.snvote.getAllProxiedVoteNum()
        print(ret)
        XCTAssertTrue(ret > 0)
    }
}
