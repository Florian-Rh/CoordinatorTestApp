import UIKit

class LoginViewController: UIViewController {

    weak var coordinator : MainCoordinator?
    private var loginViewModel : LoginViewModel?
    @IBOutlet weak var tokenTextfield: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var rememberMeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noteTextView.text = loginViewModel?.note
    }
    
    func inject(coordinator: MainCoordinator, loginViewModel: LoginViewModel) {
        self.coordinator = coordinator
        self.loginViewModel = loginViewModel
    }
    
    @IBAction func loginButton_TouchUp(_ sender: Any) {
        loginViewModel?.logIn(token: tokenTextfield.text) { success in
            if success {
                self.coordinator?.plantList()
            }
        }
    }
    
    @IBAction func rememberMe_Changed(_ sender: Any) {
        loginViewModel?.remember = rememberMeSwitch.isOn
        self.noteTextView.text = loginViewModel?.note
    }
}
