enum DeepLinkType {
    case home
    case coupon(code: String)
}

extension DeepLinkType {
    typealias DeeplinkMaker = (String) -> DeepLinkType?
    private static var deeplinkMakers: [DeeplinkMaker] {
        [
            makeHomeDeeplink,
            makeCouponDeeplink
        ]
    }

    static func type(of url: URL?) -> DeepLinkType? {
        guard let url = url else { return nil }
        return deeplinkMakers
            .compactMap { $0(url.path) }
            .first
    }

    private static func isValidHomeDeeplink(_ path: String) -> Bool { true }
    private static func isValidCouponDeeplink(_ path: String) -> Bool { true }

    private static func makeHomeDeeplink(from path: String) -> DeepLinkType? {
        // regra de validação de deeplink de home
        guard isValidHomeDeeplink(path) else { return nil }
        return .home
    }

    private static func makeCouponDeeplink(from path: String) -> DeepLinkType? {
        // regra de validação de deeplink de cupom
        guard isValidCouponDeeplink(path) else { return nil }
        return .coupon(code: "someParam")
    }
}
