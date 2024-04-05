//
//  SignInAppleHelper.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/5/23.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit

struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}

struct SignInWithAppleResult {
    let token: String
    let nonce: String
    let name: String?
    let email: String?
}

@MainActor
final class SignInAppleHelper: NSObject {
    
    private var currentNonce: String?
    private var completionHandler: ((Result<SignInWithAppleResult, Error>) -> Void)? = nil
    
    func startSignInWithAppleFlow() async throws -> SignInWithAppleResult {
        try await withCheckedThrowingContinuation { continuation in
            self.startSignInWithAppleFlow { result in
                switch result {
                case .success(let signInAppleResult):
                    continuation.resume(returning: signInAppleResult)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    func startSignInWithAppleFlow(completion: @escaping (Result<SignInWithAppleResult, Error>) -> Void) {
        guard let topVC = Utilities.shared.topViewController() else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let nonce = randomNonceString()
        currentNonce = nonce
        completionHandler = completion
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = topVC
        authorizationController.performRequests()
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

    
}

extension SignInAppleHelper: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let appleIDToken = appleIDCredential.identityToken,
            let idTokenString = String(data: appleIDToken, encoding: .utf8),
            let nonce = currentNonce else {
            completionHandler?(.failure(URLError(.badServerResponse)))
            return
        }
        let name = appleIDCredential.fullName?.givenName
        let email = appleIDCredential.email

        let tokens = SignInWithAppleResult(token: idTokenString, nonce: nonce, name: name, email: email)
        completionHandler?(.success(tokens))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
        completionHandler?(.failure(URLError(.cannotFindHost)))
    }

}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}




//MARK: - The old way

//class AppleLoginViewModel: ObservableObject {
//
//    @Published var nonce = ""
//
//    func authenticate(credential: ASAuthorizationAppleIDCredential) {
//
//        //getting token...
//        guard let token = credential.identityToken else {
//            print("error with firebase")
//            return
//        }
//
//        //Token String...
//        guard let tokenString = String(data: token, encoding: .utf8) else {
//            print("❌🪵error with Token")
//            return
//        }
//
//        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
//
//        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
//
//            if let error = err {
//                print(error.localizedDescription)
//                return
//            }
//
//            //user successfully logged into Firebase...
//            print("🍏🪵 Apple Log-In Success")
//            let authUser = AuthUser(user: result!.user)
//            let user = UserModel(id: authUser.uid, email: authUser.email ?? "")
//            Task {
//                do {
//                    try await UserManager.shared.createNewUser(user: user)
////                    try await CurrentUserViewModel().loadCurrentUser(authUser: authUser)
//
//                } catch {
//                    print("❌Error: Couldn't create User")
//                }
//            }
//
//
//        }
//    }
//}
//
//
////Helpers for Apple login with firebase...
//func randomNonceString(length: Int = 32) -> String {
//  precondition(length > 0)
//  let charset: [Character] =
//    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//  var result = ""
//  var remainingLength = length
//
//  while remainingLength > 0 {
//    let randoms: [UInt8] = (0 ..< 16).map { _ in
//      var random: UInt8 = 0
//      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//      if errorCode != errSecSuccess {
//        fatalError(
//          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
//        )
//      }
//      return random
//    }
//
//    randoms.forEach { random in
//      if remainingLength == 0 {
//        return
//      }
//
//      if random < charset.count {
//        result.append(charset[Int(random)])
//        remainingLength -= 1
//      }
//    }
//  }
//
//  return result
//}
//
//
////cryptoKit
////@available(iOS 13, *)
//func sha256(_ input: String) -> String {
//  let inputData = Data(input.utf8)
//  let hashedData = SHA256.hash(data: inputData)
//  let hashString = hashedData.compactMap {
//    String(format: "%02x", $0)
//  }.joined()
//
//  return hashString
//}
//
//
