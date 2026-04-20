import XCTest

@testable import BigInt
@testable import Web3Core
@testable import web3swift

class SRC721BurnableTest: LocalTestCase {
    func testDeploy() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3)
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let ret = try await src721.deploy(privateKey: privateKey, name: "Ketty2", symbol: "Ketty2", baseURI: "https://www.test.com", maxSupply: BigUInt("10000"), mintPrice: BigUInt("100000000000000000"))
        print("contract address: " + ret[0])
        print("deploy txid: " + ret[1])
        XCTAssertEqual(ret.count, 2)
    }

    func testBurn() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let tokenId = BigUInt(1)
        let txid = try await src721.burn(privateKey: privateKey, tokenId: tokenId)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testAdminMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let to = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let amount = BigUInt(100)
        let txid = try await src721.adminMint(privateKey: privateKey, to: to, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x1b0610af92bfb76fdb2e63b61aeaf5f4e19e62c841c8390abb36efed10142077")
        let mintPrice = try await src721.mintPrice()
        let to = EthereumAddress("0x5E5e15A6BC5F699a246F59101f86307eDa9859fA")!
        let amount = BigUInt(2)
        let txid = try await src721.mint(privateKey: privateKey, value: mintPrice * amount, to: to, amount: amount)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testWithdraw() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src721.withdraw(privateKey: privateKey)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testApprove() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let to = EthereumAddress("0x5E5e15A6BC5F699a246F59101f86307eDa9859fA")!
        let tokenId = BigUInt(1)
        let txid = try await src721.approve(privateKey: privateKey, to: to, tokenId: tokenId)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSafeTransferFrom() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let from = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let to = EthereumAddress("0x5E5e15A6BC5F699a246F59101f86307eDa9859fA")!
        let tokenId = BigUInt(0)
        let txid = try await src721.safeTransferFrom(privateKey: privateKey, from: from, to: to, tokenId: tokenId)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetBaseURI() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let baseURI = "http://www.ketty.com"
        let txid = try await src721.setBaseURI(privateKey: privateKey, baseURI: baseURI)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetMintPrice() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let mintPrice = BigUInt("500000000000000000")
        let txid = try await src721.setMintPrice(privateKey: privateKey, mintPrice: mintPrice)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetMaxSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let maxSupply = BigUInt("50000")
        let txid = try await src721.setMaxSupply(privateKey: privateKey, maxSupply: maxSupply)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetAllowList() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")

        var addresses: [EthereumAddress] = []
        addresses.append(EthereumAddress("0x5E5e15A6BC5F699a246F59101f86307eDa9859fA")!)
        addresses.append(EthereumAddress("0x44d798A6226794ef51839Fc661EBd46A96dd1Ba9")!)

        var amounts: [BigUInt] = []
        amounts.append(BigUInt(5))
        amounts.append(BigUInt(100))

        let txid = try await src721.setAllowList(privateKey: privateKey, addresses: addresses, amounts: amounts)
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testOwner() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let owner = try await src721.owner()
        print("NFT contract owner: ", owner)
        XCTAssertNotEqual(owner, nil)
    }

    func testName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let name = try await src721.name()
        print(name)
        XCTAssertNotEqual(name, nil)
    }

    func testSymbol() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let symbol = try await src721.symbol()
        print(symbol)
        XCTAssertNotEqual(symbol, nil)
    }

    func testBaseURI() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let baseURI = try await src721.baseURI()
        print(baseURI)
        XCTAssertNotEqual(baseURI, nil)
    }

    func testMintPrice() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let mintPrice = try await src721.mintPrice()
        print(mintPrice)
        XCTAssertNotEqual(mintPrice, nil)
    }

    func testMaxSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let maxSupply = try await src721.maxSupply()
        print(maxSupply)
        XCTAssertNotEqual(maxSupply, nil)
    }

    func testTotalSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let totalSupply = try await src721.totalSupply()
        print(totalSupply)
        XCTAssertNotEqual(totalSupply, nil)
    }

    func testRemainSupply() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let remainSupply = try await src721.remainSupply()
        print(remainSupply)
        XCTAssertNotEqual(remainSupply, nil)
    }

    func testBalanceOf() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let addr = EthereumAddress("0x5E5e15A6BC5F699a246F59101f86307eDa9859fA")!
        let balance = try await src721.balanceOf(addr: addr)
        print(balance)
        XCTAssertNotEqual(balance, nil)
    }

    func testOwnerOf() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let tokenId = BigUInt(0)
        let owner = try await src721.ownerOf(tokenId: tokenId)
        print(owner)
        XCTAssertNotEqual(owner, nil)
    }

    func testTokenByIndex() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let index = BigUInt(0)
        let tokenId = try await src721.tokenByIndex(index: index)
        print(tokenId)
        XCTAssertNotEqual(tokenId, nil)
    }

    func testTokenOfOwnerByIndex() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let owner = EthereumAddress("0xa5cec2b8cda30da3f3170b4505cb44226b6c9dd2")!
        let index = BigUInt(10)
        let tokenId = try await src721.tokenOfOwnerByIndex(owner: owner, index: index)
        print(tokenId)
        XCTAssertNotEqual(tokenId, nil)
    }

    func testAmountAllowToMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let addr = EthereumAddress("0x44d798A6226794ef51839Fc661EBd46A96dd1Ba9")!
        let amount = try await src721.amountAllowToMint(addr: addr)
        print(amount)
        XCTAssertNotEqual(amount, nil)
    }

    func testCanMint() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let addr = EthereumAddress("0x44d798A6226794ef51839Fc661EBd46A96dd1Ba9")!
        let flag = try await src721.canMint(addr: addr)
        print(flag)
        XCTAssertNotEqual(flag, nil)
    }

    func testGetApproved() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let tokenId = BigUInt(1)
        let addr = try await src721.getApproved(tokenId: tokenId)
        print(addr)
        XCTAssertNotEqual(addr, nil)
    }

    func testTokenURI() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let tokenId = BigUInt(10)
        let tokenURI = try await src721.tokenURI(tokenId: tokenId)
        print(tokenURI)
        XCTAssertNotEqual(tokenURI, nil)
    }

    func testSetOrgName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src721.setOrgName(privateKey: privateKey, orgName: "Ketty")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let logoUrl = URL(fileURLWithPath: "/Users/lmb/Desktop/104.png")
        do {
            let logo = try Data(contentsOf: logoUrl)
            let txid = try await src721.setLogo(privateKey: privateKey, logo: logo)
            print(txid)
            XCTAssertNotEqual(txid, nil)
        } catch {
            throw Web3Error.processingError(desc: "unknown logo")
        }
    }

    func testSetDescription() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src721.setDescription(privateKey: privateKey, description: "Ketty2 is a nft token for testing")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetOfficialUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src721.setOfficialUrl(privateKey: privateKey, officialUrl: "https://www.ketty.com")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testSetWhitePaperUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let privateKey = Data(hex: "0x7b281a9ba16001feb62a5929526ef8f69d6550c6acdc3f0579c69199c0b6a010")
        let txid = try await src721.setWhitePaperUrl(privateKey: privateKey, whitePaperUrl: "https://www.ketty.com/whitepaper.pdf")
        print(txid)
        XCTAssertNotEqual(txid, nil)
    }

    func testOrgName() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let orgName = try await src721.orgName()
        print(orgName)
        XCTAssertNotEqual(orgName, nil)
    }

    func testLogo() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let logo = try await src721.logo()
        print(logo.toHexString())
        XCTAssertNotEqual(logo, nil)
    }

    func testDescritpion() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let description = try await src721.description()
        print(description)
        XCTAssertNotEqual(description, nil)
    }

    func testOfficialUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let officialUrl = try await src721.officialUrl()
        print(officialUrl)
        XCTAssertNotEqual(officialUrl, nil)
    }

    func testWhitePaperUrl() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let whitePaperUrl = try await src721.whitePaperUrl()
        print(whitePaperUrl)
        XCTAssertNotEqual(whitePaperUrl, nil)
    }

    func testVersion() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let version = try await src721.version()
        print(version)
        XCTAssertNotEqual(version, nil)
    }

    func testGetLogoPayAmount() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let payAmount = try await src721.getLogoPayAmount()
        print(payAmount)
        XCTAssertNotEqual(payAmount, nil)
    }

    func testGetLogoPayAddress() async throws {
        let web3 = try await Web3.new(LocalTestCase.url, network: Networks.fromInt(6666666))
        let src721 = SRC721Burnable(web3: web3, contractAddr: "0x73c4779DdC6F08461437Ac458ab3e1A2B02210eC")
        let payAddress = try await src721.getLogoPayAddress()
        print(payAddress)
        XCTAssertNotEqual(payAddress, nil)
    }
}
