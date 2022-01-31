/**
 Active/inactive validator list RPC pub/sub service.
 */
public class ValidatorListService: RPCSubscriptionService<ValidatorListUpdate> {
    init(active: Bool) {
        super.init(
            host: Settings.shared.apiHost,
            port: active
                ? Settings.shared.activeValidatorListServicePort
                : Settings.shared.inactiveValidatorListServicePort,
            subscribeMethod: "subscribe_validatorList",
            unsubscribeMethod: "unsubscribe_validatorList"
        )
    }
}
