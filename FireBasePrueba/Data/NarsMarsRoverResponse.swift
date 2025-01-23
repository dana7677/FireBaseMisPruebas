//
//  NarsMarsRoverResponse.swift
//  FireBasePrueba
//
//  Created by Tardes on 23/1/25.
//

import Foundation

struct SuperHeroeResponse:Codable {
    
    let photos: [DataPhotos]
    
}

struct DataPhotos:Codable{
    
    let id: Int
    let sol: Int
    let camera: camera
    let img_src: String
    let earth_date: String
    let rover: rover
    
}

struct  camera:Codable{
    
    let id:Int
    let name:String
    let rover_id:Int
    let full_name:String

}

struct  rover:Codable{
    
    let id:Int
    let name:String
    let landing_date:String
    let launch_date:String
    let status:String
    
}


