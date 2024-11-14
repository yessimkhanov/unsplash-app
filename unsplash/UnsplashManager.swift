//
//  UnsplashManager.swift
//  unsplash
//
//  Created by Nursultan Turekulov on 13.11.2024.
//

import Foundation
import UIKit
struct UnsplashManager{
    var url = "https://api.unsplash.com/photos/?client_id=Bhi4ov0XhWWA511WslFP9teWgOPuD3Fgif0AR-e1fkc"
    var delegate : UnsplashManagerDelegate?
    func performRequest(){
        if let url = URL(string: self.url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error)
                }
                if let safeData = data {
                    if let data = self.parseJSON(safeData){
                        self.delegate?.updateArray(unsplashManager: self, data: data)
                    }
                }
                
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data) -> [UnsplashData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([UnsplashData].self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
protocol UnsplashManagerDelegate {
    func updateArray(unsplashManager: UnsplashManager, data: [UnsplashData]);
}
