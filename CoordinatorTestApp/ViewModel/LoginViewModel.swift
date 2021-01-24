import Foundation

struct LoginViewModel: ViewModel {
    let model: LoginModel
    var token: String?
    var remember: Bool = true
    var note: String {
        if remember {
            return "Besuche https://trefle.io/profile wenn du noch kein Token hast. Dein Token wird in der Keychain dieses Geräts gespeichert."
        }
        return "Besuche https://trefle.io/profile wenn du noch kein Token hast."
    }
    
    
    func logIn(token: String?, completion: @escaping (Bool) -> ()) {
        model.logIn(token: token) { success in
            completion(success)
        }
    }
}
