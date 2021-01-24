import Foundation

struct PlantViewModel: ViewModel {
    let model: PlantModel
    let name: String

    init(model: PlantModel) {
        self.model = model
        self.name = model.common_name
    }
}
