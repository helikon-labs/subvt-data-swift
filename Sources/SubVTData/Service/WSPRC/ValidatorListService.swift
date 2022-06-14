/**
 Active/inactive validator list RPC pub/sub service.
 */
public class ValidatorListService: RPCSubscriptionService<ValidatorListUpdate> {
    public init(active: Bool) {
        super.init(
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
        super.init(
            host: rpcHost,
            port: rpcPort,
            subscribeMethod: "subscribe_validatorList",
            unsubscribeMethod: "unsubscribe_validatorList"
        )
    }
}
