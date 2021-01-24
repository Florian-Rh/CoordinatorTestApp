import UIKit

class PlantListTableViewController: UITableViewController {

    weak var coordinator : MainCoordinator?
    private var viewModel : PlantListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadPlants() { success in
            if success {
                self.tableView.reloadData()
            }
        }
    }

    func inject(coordinator: MainCoordinator?, viewModel: PlantListViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.plants.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        if let plant = self.viewModel?.plants[indexPath.row] {
            cell.textLabel?.text = plant.name
        }
        return cell
    }
    
}
