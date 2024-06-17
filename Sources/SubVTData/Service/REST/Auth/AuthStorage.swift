import Foundation
import KeychainAccess
import secp256k1

/**
 Private key type alias.
 */
typealias PrivateKey = secp256k1.Signing.PrivateKey
/**
 Public key type alias.
 */
typealias PublicKey = secp256k1.Signing.PublicKey

/**
 Authentication storage protocol.
 */
protocol AuthStorage: AnyObject {
    var privateKey: PrivateKey { get }
    var publicKey: PublicKey { get }
}

/**
 Keychain authentication storage.
 */
public class KeychainStorage: AuthStorage {
    public static let shared: KeychainStorage = KeychainStorage()
    var privateKey: PrivateKey
    var publicKey: PublicKey
    private let keychain = Keychain(service: "io.helikon.subvt.data")
    private let privateKeyKey = "private_key"
    
    /**
     Generates and stores the private key if it doesn't exist yet.
     */
    private init() {
        do {
            if let privateKeyData = keychain[data: privateKeyKey] {
                self.privateKey = try PrivateKey(dataRepresentation: privateKeyData)
                self.publicKey = self.privateKey.publicKey
            } else {
                self.privateKey = try PrivateKey.init()
                self.publicKey = self.privateKey.publicKey
                self.keychain[data: privateKeyKey] = self.privateKey.dataRepresentation
            }
        } catch {
            fatalError("Cannot initialize keychain: \(error.localizedDescription)")
        }
    }
    
    public func setPrivateKey(data: Data) {
        self.keychain[data: privateKeyKey] = data
        self.privateKey = try! PrivateKey(dataRepresentation: data)
        self.publicKey = self.privateKey.publicKey
    }
    
    public func getPrivateKeyData() -> Data {
        return self.privateKey.dataRepresentation
    }
    
    func resetUser() {
        do {
            self.privateKey = try PrivateKey.init()
            self.publicKey = self.privateKey.publicKey
            self.keychain[data: privateKeyKey] = self.privateKey.dataRepresentation
        } catch {
            fatalError("Cannot initialize keychain: \(error.localizedDescription)")
        }
    }
}
