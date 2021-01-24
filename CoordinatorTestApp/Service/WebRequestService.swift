import Foundation

class WebRequestService {
    
    func httpRequest(urlAndParameters : String, method : String = "GET", payload : Data? = nil, completionMethod : @escaping (Bool, Data?) -> ()){
        if let url = URL(string: urlAndParameters) {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if payload != nil {
                request.httpBody = payload
            }
            let urlDataTask = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completionMethod(true, data)
                }
                completionMethod(false, nil)
            }
            urlDataTask.resume()
        }
    }
    
}
