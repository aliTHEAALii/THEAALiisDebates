//
//  EditUserInfoVM.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 3/2/24.
//

import Foundation

@MainActor
final class EditUserInfoViewModel: ObservableObject {
    
    func signOut() throws {
        Task {
            do {
                try AuthenticationManager.shared.signOut()
                print("😎 SignOut Success 😎")
            } catch {
                print("❌ Error: SignOut Failed ❌")
            }
        }
    }
    
    //TODO: Add to EditUserInfoSheet!
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            print("❌ Error: couldn't get email to reset password ❌")
            throw(URLError(.fileDoesNotExist))
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
        print("😎 Deleted Account Successfully 😎")
    }
}
