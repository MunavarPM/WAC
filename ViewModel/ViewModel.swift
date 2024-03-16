//
//  ViewModel.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//

import Foundation


class TodoViewModel: ObservableObject {

    @Published var banners: [Banner] = []
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var dataLoaded: Bool = false
    @Published var singleBanner: BannerSingle? = nil
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                print(type(of: data))
                let decodedData = try JSONDecoder().decode([Section].self, from: data)
                DispatchQueue.main.async {
                    for section in decodedData {
                        if let contents = section.contents {
                            switch section.type {
                            case "banner_slider":
                                self.banners = contents.compactMap { Banner(content: $0) }
                                print(self.banners.count)
                            case "products":
                                self.products = contents.compactMap { Product(content: $0) }
                                print(self.products.count)
                            case "catagories":
                                self.categories = contents.compactMap { Category(content: $0) }
                                print(self.categories.count)
                            default:
                                break
                            }
                        } else {
                            self.singleBanner = BannerSingle(title: section.title, image_url: section.image_url ?? "image_urlNil")
                        }
                    }
                    self.dataLoaded = true
                }
                
            } catch {
                print("Error decoding JSON: \(error)\n\n")
                print("Data: \(String(data: data, encoding: .utf8) ?? "Unable to print data")")
            }
        }
        .resume()
    }
}
