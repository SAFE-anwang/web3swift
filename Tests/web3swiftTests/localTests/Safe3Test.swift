import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class Safe3Test: LocalTestCase {
    func testRedeemSafe() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        // compressed-addr: Xy3pSqGgGHfS6suRbUFk2mYaBD8oTYApAZ, privateKey: 0x18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725
        // uncompressed-addr: XanKmaz3PS6CCMFyh4o9BLM5bWyowyrnGR, privateKey: 0x18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725
        let privateKey = Data(hex: "0x105EC40324284F2C8A5ED58553A07D4B633511A1D90DBC4ED3FB789A7B61D658")
        let ret = try await web3.safe4.safe3.redeemSafe3(privateKey: privateKey)
        print(ret)
        XCTAssertTrue(ret.count > 0)
    }

    func testRedeemMasterNode() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        // compressed-addr: Xy3pSqGgGHfS6suRbUFk2mYaBD8oTYApAZ, privateKey: 0x18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725
        // uncompressed-addr: XanKmaz3PS6CCMFyh4o9BLM5bWyowyrnGR, privateKey: 0x18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725
        let privateKey = Data(hex: "0x105EC40324284F2C8A5ED58553A07D4B633511A1D90DBC4ED3FB789A7B61D658")
        let txids = try await web3.safe4.safe3.redeemMasterNode(privateKey: privateKey, enode: "enode://NodeInfo@127.0.0.1:8545")
        print(txids)
        XCTAssertTrue(txids.count > 0)
    }

    func testGetAllAvailableNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let num = try await web3.safe4.safe3.getAllAvailableNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetAvailableInfos() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let infos = try await web3.safe4.safe3.getAvailableInfos(0, 10)
        print(infos)
        XCTAssertTrue(infos.count > 0)
    }

    func testGetAvailableInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let info = try await web3.safe4.safe3.getAvailableInfo("XuPmDoaNb6rbNywefkTbESHXiYqNpYvaPU")
        print(info)
        XCTAssertTrue(info.safe3Addr.count > 0)
    }

    func testGetAllLockedNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let num = try await web3.safe4.safe3.getAllLockedNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedAddrNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let num = try await web3.safe4.safe3.getLockedAddrNum()
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedAddrs() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let safe3Addrs = try await web3.safe4.safe3.getLockedAddrs(0, 10)
        print(safe3Addrs)
        XCTAssertTrue(safe3Addrs.count > 0)
    }

    func testGetLockedNum() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let num = try await web3.safe4.safe3.getLockedNum("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9")
        print(num)
        XCTAssertTrue(num > 0)
    }

    func testGetLockedInfo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let infos = try await web3.safe4.safe3.getLockedInfo("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9", 0, 10)
        print(infos)
        XCTAssertTrue(infos.count > 0)
    }

    func testExistAvailableNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let flag = try await web3.safe4.safe3.existAvailableNeedToRedeem("XuPmDoaNb6rbNywefkTbESHXiYqNpYvaPU")
        print(flag)
        XCTAssertTrue(flag)
    }

    func testExistLockedNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let flag = try await web3.safe4.safe3.existLockedNeedToRedeem("XuP9HFUwY37bAQ2cVsVv3T2BFBine6CbT9")
        print(flag)
        XCTAssertTrue(flag)
    }

    func testExistMasterNodeNeedToRedeem() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666667))
        let flag = try await web3.safe4.safe3.existMasterNodeNeedToRedeem("Xm7bqZeKBooWuQxb2EWjJxN2qjQVgN4AuU")
        print(flag)
        XCTAssertTrue(flag)
    }
}
