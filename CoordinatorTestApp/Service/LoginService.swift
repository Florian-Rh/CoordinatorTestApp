import Foundation

class LoginService {
    private var accessToken: String?
    
    var isLoggedIn: Bool {
        return accessToken != nil
    }
    
    func getAccessToken() -> String {
        return accessToken ?? "<unavailable>"
    }
    
    func logIn(token: String?, completion: @escaping (Bool) -> ()){
        if token != nil && token?.count ?? 0 > 0 {
            self.accessToken = token
            completion(true)
        } else {
            completion(false)
        }

    }
    
    func logOut() {
        self.accessToken = nil
    }
}

