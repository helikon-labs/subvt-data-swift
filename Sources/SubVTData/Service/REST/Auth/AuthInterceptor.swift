import Alamofire
import Foundation
import secp256k1

/**
 Alamofire request interceptor.
 Injects the public key, nonce and signature (ECDSA over secp256k1) headers.
 */
final class AuthInterceptor: Alamofire.RequestInterceptor {
    private let storage: AuthStorage
    
    init(storage: AuthStorage) {
        self.storage = storage
    }
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard urlRequest.url!.relativePath.hasPrefix("/secure") else {
            return completion(.success(urlRequest))
        }
        let method = urlRequest.method!.rawValue.uppercased()
        let path = urlRequest.url!.relativePath
        let body: String
        if let bodyData = urlRequest.httpBody {
            body = String(decoding: bodyData, as: UTF8.self)
        } else {
            body = ""
        }
        let nonce = Int64(Date().timeIntervalSince1970 * 1000)
        let bytesToSign = (method + path + body + "\(nonce)").data(using: .utf8)!
        let digest = SHA256.hash(data: bytesToSign)
        do {
            let signature = try storage.privateKey.ecdsa.signature(for: digest)
            let signatureDer = try signature.derRepresentation
            let signatureHex = signatureDer.map({
                String(format: "%02hhX", $0)
            }).joined()
            let publicKeyHex = storage.publicKey.rawRepresentation.map {
                String(format: "%02hhX", $0)
            }.joined()
            var urlRequest = urlRequest
            urlRequest.setValue(publicKeyHex, forHTTPHeaderField: "SubVT-Public-Key")
            urlRequest.setValue("\(nonce)", forHTTPHeaderField: "SubVT-Nonce")
            urlRequest.setValue(signatureHex, forHTTPHeaderField: "SubVT-Signature")
            completion(.success(urlRequest))
        } catch {
            completion(.failure(error))
        }
    }
}
