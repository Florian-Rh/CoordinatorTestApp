import Foundation

class PlantService {
    let webRequestService: WebRequestService
    let loginService: LoginService
    private let rootApi: String = "https://trefle.io/api/v1/"
    private var plantsApi: String {
        return "\(self.rootApi)/plants?token=\(self.loginService.getAccessToken())"
    }
    
    init(webRequestService: WebRequestService, loginService: LoginService) {
        self.webRequestService = webRequestService
        self.loginService = loginService
    }
    
    
    func getPlants(completion: @escaping (PlantListModel?) -> ()){
        webRequestService.httpRequest(urlAndParameters: plantsApi) { success, data in
            guard let data = data,
                  let plantList = try? JSONSerialization.jsonObject(with: data, options: []) as? PlantListModel
            else {
                completion(nil)
                return
            }
            completion(plantList)
        }
    }
    
    func getPlant(withId id: Int) -> PlantModel? {
        fatalError("not implemented")
    }
}
