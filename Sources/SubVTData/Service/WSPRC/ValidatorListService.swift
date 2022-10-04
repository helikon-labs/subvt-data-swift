/**
 Active/inactive validator list RPC pub/sub service.
 */
public class ValidatorListService: RPCSubscriptionService<ValidatorListUpdate> {
    public init(active: Bool) {
        let scheme = (Settings.shared.scheme == "https") ? "wss" : "ws"
        super.init(
            scheme: scheme,
            host: Settings.shared.rpcHost,
            port: active
                ? Settings.shared.activeValidatorListServicePort
                : Settings.shared.inactiveValidatorListServicePort,
            subscribeMethod: "subscribe_validatorList",
            unsubscribeMethod: "unsubscribe_validatorList"
        )
    }
    
    public init(
        rpcHost: String,
        rpcPort: UInt16
    ) {
        let scheme = (Settings.shared.scheme == "https") ? "wss" : "ws"
        super.init(
            scheme: scheme,
            host: rpcHost,
            port: rpcPort,
            subscribeMethod: "subscribe_validatorList",
            unsubscribeMethod: "unsubscribe_validatorList"
        )
    }
}
