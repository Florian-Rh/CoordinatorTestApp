import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var viewStates: [ViewModel]
    
    private let webRequestService: WebRequestService
    private let loginService: LoginService
    private let plantService: PlantService
    
    
    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
        self.viewStates = []
        self.webRequestService = WebRequestService()
        self.loginService = LoginService()
        self.plantService = PlantService(webRequestService: self.webRequestService,
                                         loginService: self.loginService)
    }
    
    func start() {
        navigationController.delegate = self
        if loginService.isLoggedIn {
            plantList()
        } else {
            loginView()
        }
    }
    
    func loginView() {
        if let loginVc = createInstance(of: "LoginViewController") as? LoginViewController {
            var viewModel: ViewModel?
            if let previousViewState = viewStates.first(where: { $0 is LoginViewModel }) {
                viewModel = previousViewState
            } else {
                let loginModel = LoginModel(loginService: self.loginService)
                viewModel = LoginViewModel(model: loginModel)
                viewStates.append(viewModel!)
            }
            if let loginViewModel = viewModel as? LoginViewModel {
                loginVc.inject(coordinator: self, loginViewModel: loginViewModel)
            }
            self.navigationController.pushViewController(loginVc, animated: true)
        }
    }
    
    func plantList() {
        if let plantListVc = createInstance(of: "PlantListTableViewController") as? PlantListTableViewController {
            var viewModel: ViewModel?
            if let previousViewState = viewStates.first(where: { $0 is PlantListViewModel }) {
                viewModel = previousViewState
            } else {
                let plantListModel = PlantListModel(plantService: self.plantService)
                viewModel = PlantListViewModel(model: plantListModel)
                viewStates.append(viewModel!)
            }
            if let plantListViewModel = viewModel as? PlantListViewModel {
                plantListVc.inject(coordinator: self, viewModel: plantListViewModel)
            }
            self.navigationController.pushViewController(plantListVc, animated: true)
        }
    }
    
    func plantDetails(for plantViewModel: PlantViewModel) {
        if let plantVc = createInstance(of: "PlantViewController") as? PlantViewController {
            self.navigationController.pushViewController(plantVc, animated: true)
            plantVc.inject(coordinator: self, viewModel: plantViewModel)
        }
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
    
    internal func createInstance(of viewControllerID: String, from storyboardId : String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardId, bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: viewControllerID)
        return vc
    }
}
