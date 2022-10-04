/**
 Validator details RPC pub/sub service.
 */
public class ValidatorDetailsService: RPCSubscriptionService<ValidatorDetailsUpdate> {
    public init() {
        let scheme = (Settings.shared.scheme == "https") ? "wss" : "ws"
        super.init(
            scheme: scheme,
            host: Settings.shared.rpcHost,
            port: Settings.shared.validatorDetailsServicePort,
            subscribeMethod: "subscribe_validatorDetails",
            unsubscribeMethod: "unsubscribe_validatorDetails"
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
            subscribeMethod: "subscribe_validatorDetails",
            unsubscribeMethod: "unsubscribe_validatorDetails"
        )
    }
}
