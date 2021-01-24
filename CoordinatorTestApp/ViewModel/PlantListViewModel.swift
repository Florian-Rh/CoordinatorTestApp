import Foundation

class PlantListViewModel: ViewModel {
    let model: PlantListModel
    var plants: [PlantViewModel] = []
    
    init(model: PlantListModel) {
        self.model = model
    }
    
    func loadPlants(completion: @escaping (Bool) -> ()) {
        self.model.loadPlants() { [unowned self] success in
            if success {
                self.plants = []
                if let plantModels = self.model.data {
                    for plantModel in plantModels {
                        let plantViewModel = PlantViewModel(model: plantModel)
                        self.plants.append(plantViewModel)
                    }
                }
            }
        }
    }
}
