import UIKit

class PlantViewController: UIViewController {

    weak var coordinator : MainCoordinator?
    private var viewModel : PlantViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(coordinator: MainCoordinator?, viewModel: PlantViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }

}
