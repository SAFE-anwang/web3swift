import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class Safe3Test: LocalTestCase {
    func testAddSafe3() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let callerPrivateKey = Data(hex: "0x78cc1725d7e8ce249d6849b36785bb7bae695b667da24240cf29caf10c14473a")
        let safe3Addr = "XhWH1XBihbA2kBxTqKRmpL38ij2Cjms8oj"
        let txids = try await web3.safe4.safe3.addSafe3(callerPrivateKey: callerPrivateKey, safe3Addr: safe3Addr)
        print(txids)
        XCTAssertTrue(txids.count > 0)
    }

    func testResetSafe3() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let callerPrivateKey = Data(hex: "0x78cc1725d7e8ce249d6849b36785bb7bae695b667da24240cf29caf10c14473a")
        let safe3Addr = "XhWH1XBihbA2kBxTqKRmpL38ij2Cjms8oj"
        let txid = try await web3.safe4.safe3.resetSafe3(callerPrivateKey: callerPrivateKey, safe3Addr: safe3Addr)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testBatchRedeemSafe() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let callerPrivateKey = Data(hex: "0x020274d1ddb0d006eb9a3c4871091c191c46a01c3fb8f09cfd1ae9192f893712")
        var privateKeys: [Data] = []
        privateKeys.append(Data(hex: "0xfdf1182eedfb83e9d93eaee6e5b5a690cd315168ddbbef1228f3be4c2fb46d06"))
        privateKeys.append(Data(hex: "0xe94a71ba0a84651da768ba4ec433f322d4327f084797d2d0d7c1d62fdd4eb3d1"))
        privateKeys.append(Data(hex: "0xc11fce126d5c751395e5aa4e53f38419c97dfdd1de58851bc0b7289f83d518e0"))
        let targetAddr = EthereumAddress("0x9432920f31f9f81b8d0002231c111d7e5eb1e4e1")!
        let ret = try await web3.safe4.safe3.batchRedeemSafe3(callerPrivateKey: callerPrivateKey, privateKeys: privateKeys, targetAddr: targetAddr)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testBatchRedeemMasterNode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let callerPrivateKey = Data(hex: "0x020274d1ddb0d006eb9a3c4871091c191c46a01c3fb8f09cfd1ae9192f893712")
        var privateKeys: [Data] = []
        privateKeys.append(Data(hex: "0xfdf1182eedfb83e9d93eaee6e5b5a690cd315168ddbbef1228f3be4c2fb46d06"))
        privateKeys.append(Data(hex: "0xe94a71ba0a84651da768ba4ec433f322d4327f084797d2d0d7c1d62fdd4eb3d1"))
        privateKeys.append(Data(hex: "0xc11fce126d5c751395e5aa4e53f38419c97dfdd1de58851bc0b7289f83d518e0"))
        var enodes: [String] = []
        for _ in privateKeys {
            enodes.append("enode://NodeInfo@127.0.0.1:8545")
        }
        let targetAddr = EthereumAddress("0x9432920f31f9f81b8d0002231c111d7e5eb1e4e1")!
        let txid = try await web3.safe4.safe3.batchRedeemMasterNode(callerPrivateKey: callerPrivateKey, privateKeys: privateKeys, enodes: enodes, targetAddr: targetAddr)
        print(txid)
        XCTAssertTrue(txid.count > 0)
    }

    func testGetAllAvailableNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let num = try await web3.safe4.safe3.getAllAvailableNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetAvailableInfos() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let infos = try await web3.safe4.safe3.getAvailableInfos(0, 10)
        print(infos)
        XCTAssertTrue(infos.count > 0)
    }

    func testGetAvailableInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let info = try await web3.safe4.safe3.getAvailableInfo("XuPmDoaNb6rbNywefkTbESHXiYqNpYvaPU")
        print(info)
        XCTAssertTrue(info.safe3Addr.count > 0)
    }

    func testGetAllLockedNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let num = try await web3.safe4.safe3.getAllLockedNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedAddrNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let num = try await web3.safe4.safe3.getLockedAddrNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedAddrs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let safe3Addrs = try await web3.safe4.safe3.getLockedAddrs(0, 10)
        print(safe3Addrs)
        XCTAssertTrue(safe3Addrs.count > 0)
    }

    func testGetLockedNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let num = try await web3.safe4.safe3.getLockedNum("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9")
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let infos = try await web3.safe4.safe3.getLockedInfo("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9", 0, 10)
        print(infos)
        XCTAssertTrue(infos.count > 0)
    }

    func testExistAvailableNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let flag = try await web3.safe4.safe3.existAvailableNeedToRedeem("XuPmDoaNb6rbNywefkTbESHXiYqNpYvaPU")
        print(flag)
        XCTAssertTrue(flag)
    }

    func testExistLockedNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let flag = try await web3.safe4.safe3.existLockedNeedToRedeem("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9")
        print(flag)
        XCTAssertTrue(flag)
    }

    func testExistMasterNodeNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let flag = try await web3.safe4.safe3.existMasterNodeNeedToRedeem("Xm7bqZeKBooWuQxb2EWjJxN2qjQVgN4AuU")
        print(flag)
        XCTAssertTrue(flag)
    }
}
