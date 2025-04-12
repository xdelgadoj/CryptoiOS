import Foundation

@Observable
final class AssetListViewModel {
    
    var errorMessage: String?
    var assets: [Asset] = []
    
    func fetchAssets() async {
        let urlSession = URLSession.shared
        
        guard let url = URL(string: "https://b0b5e320-592e-47bc-8edf-c7f7b9e03407.mock.pstmn.io/v3/assets") else {
            errorMessage = "Invalid URL"
            return
        }
                
        do {
            let (data, _) = try await urlSession.data(for: URLRequest(url: url))
            let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
            self.assets = assetsResponse.data
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
}
