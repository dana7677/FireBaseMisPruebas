//
//  NasaMarsRoverProvider.swift
//  FireBasePrueba
//
//  Created by Tardes on 23/1/25.
//

import Foundation

class NasaMarsRoverProvider{
    
    
    static func findPhotoMarsRovers(name: String) async throws -> [DataPhotos] {
            let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=WS14dOGy8hq3Ij9h74Ue3vwhtrstmLbd0yiOk374")!
            
            // https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=\(name)&camera=fhaz&api_key=DEMO_KEY
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(SuperHeroeResponse.self, from: data)
            
        return result.photos
        }
        
}
