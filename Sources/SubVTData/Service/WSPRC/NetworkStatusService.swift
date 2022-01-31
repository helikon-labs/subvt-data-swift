/**
 Network status RPC pub/sub service.
 */
public class NetworkStatusService: RPCSubscriptionService<NetworkStatusUpdate> {
    init() {
        super.init(
            host: Settings.shared.apiHost,
            port: Settings.shared.networkStatusServicePort,
            subscribeMethod: "subscribe_networkStatus",
            unsubscribeMethod: "unsubscribe_networkStatus"
        )
    }
}
