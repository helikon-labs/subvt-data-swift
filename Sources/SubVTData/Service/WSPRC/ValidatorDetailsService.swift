/**
 Validator details RPC pub/sub service.
 */
public class ValidatorDetailsService: RPCSubscriptionService<ValidatorDetailsUpdate> {
    public init() {
        super.init(
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
        super.init(
            host: rpcHost,
            port: rpcPort,
            subscribeMethod: "subscribe_validatorDetails",
            unsubscribeMethod: "unsubscribe_validatorDetails"
        )
    }
}
