//
//  UIImageViewExtensionss.swift
//  FireBasePrueba
//
//  Created by Tardes on 23/1/25.
//

import UIKit
import Foundation

extension UIImageView{
    func loadFrom(url: URL){
        DispatchQueue.global().async{[weak self] in
            if let data = try? Data(contentsOf:url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadFrom(url: String){
        //Metodo aligerar la llamada a la URL
        self.loadFrom(url: URL(string: url)!)
    }
}
