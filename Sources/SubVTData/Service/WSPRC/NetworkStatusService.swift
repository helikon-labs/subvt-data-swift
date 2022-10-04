/**
 Network status RPC pub/sub service.
 */
public class NetworkStatusService: RPCSubscriptionService<NetworkStatusUpdate> {
    public init() {
        let scheme = (Settings.shared.scheme == "https") ? "wss" : "ws"
        super.init(
            scheme: scheme,
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
        let scheme = (Settings.shared.scheme == "https") ? "wss" : "ws"
        super.init(
            scheme: scheme,
            host: rpcHost,
            port: rpcPort,
            subscribeMethod: "subscribe_networkStatus",
            unsubscribeMethod: "unsubscribe_networkStatus"
        )
    }
}
