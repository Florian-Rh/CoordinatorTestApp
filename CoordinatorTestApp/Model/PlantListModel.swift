import Foundation

class PlantListModel {
    var data: [PlantModel]? = nil
    let plantService: PlantService
    
    init(plantService: PlantService) {
        self.plantService = plantService
    }
    
    func loadPlants(completion: @escaping (Bool) -> ()) {
        plantService.getPlants() { [unowned self] result in
            if result != nil {
                self.data = result?.data
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
