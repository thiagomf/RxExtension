import Foundation
import RxSwift
import SwiftyJSON

class ApiController {
    
    static let shared = ApiController()
    
    private let apiKey = "k6a7bXvvCHiy3cP4Yq9YAtWUTEVLX2tN"
    
    func search(text: String) -> Observable<[Datum]> {
        let url = URL(string: "http://api.giphy.com/v1/gifs/search")!
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let searchQueryItem = URLQueryItem(name: "q", value: text)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        urlComponents.queryItems = [searchQueryItem, keyQueryItem]
        
        request.url = urlComponents.url!
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx
                .decodable(request: request, type: GifResponse.self)
                .map { $0.data }
    }
}
