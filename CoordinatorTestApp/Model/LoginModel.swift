import Foundation

struct LoginModel {
    let loginService: LoginService
    
    func logIn(token: String?, completion: @escaping (Bool) -> ()) {
        loginService.logIn(token: token) { success in
            completion(success)
        }
    }
}
