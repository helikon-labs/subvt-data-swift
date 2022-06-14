/**
 Network status RPC pub/sub service.
 */
public class NetworkStatusService: RPCSubscriptionService<NetworkStatusUpdate> {
    public init() {
        super.init(
            host: Settings.shared.rpcHost,
            port: Settings.shared.networkStatusServicePort,
            subscribeMethod: "subscribe_networkStatus",
            unsubscribeMethod: "unsubscribe_networkStatus"
        )
    }
    
    public init(
        rpcHost: String,
        rpcPort: UInt16
    ) {
        super.init(
            host: rpcHost,
            port: rpcPort,
            subscribeMethod: "subscribe_networkStatus",
            unsubscribeMethod: "unsubscribe_networkStatus"
        )
    }
}
