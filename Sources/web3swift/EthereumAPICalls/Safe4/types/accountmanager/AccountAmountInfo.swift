import BigInt

public struct AccountAmountInfo: Safe4T {
    public var amount: BigUInt
    public var num: BigUInt

    public init(amount: BigUInt, num: BigUInt) {
        self.amount = amount
        self.num = num
    }

    public init?(_ result: [String: Any]) {
        if(result.count != 3) {
            return nil
        }
        guard let amount = result["0"] as? BigUInt else { return nil }
        guard let num = result["1"] as? BigUInt else { return nil }
        self.init(amount: amount, num: num)
    }
}