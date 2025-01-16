//
//  HomeViewController.swift
//  FireBasePrueba
//
//  Created by Tardes on 10/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseRemoteConfig

enum ProviderType:String{
    case basic
    case google
}

class HomeViewController: UIViewController {

    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var CountryPicker: UIPickerView!
    @IBOutlet weak var GenderPicker: UIPickerView!
    
    @IBOutlet weak var favoriteAnimalLabel: UITextField!
    
    
    @IBOutlet weak var ErrorButton: UIButton!
    var email:String = ""
    var provider:ProviderType = ProviderType.basic
    
    //UserInfo
    let countrys = ["Spain","Venezuela","Morroco","Italy","Brasil","Honduras","England"]
    var selectedCountry = "None"
    let gender = ["Male","Female","None","Combat Helicopter","Brasil"]
    var selectedGender = "None"
    var favoriteAnimal = "None"
    
    
    override func viewDidLoad() {
        UserLabel.text = email
        PasswordLabel.text = provider.rawValue
        CountryPicker.delegate = self
        CountryPicker.dataSource = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Remote Config
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate{(status , error) in
            if status != .error{
                let showErrorButton = remoteConfig.configValue(forKey: "show_error_button").boolValue
                let errorButtonText = remoteConfig.configValue(forKey: "error_button_text").stringValue
                
                //El pintado de la app se tiene que realizar en este hilo
                DispatchQueue.main.async {
                    self.ErrorButton.setTitle(errorButtonText, for: .normal)
                    self.ErrorButton.isHidden = !showErrorButton
                }
                
            }}
    }
    
    //MARK: FavoriteAnimalSet
    
    @IBAction func FavoriteAnimalSet(_ sender: Any) {
        
        favoriteAnimal = favoriteAnimalLabel.text!
        
    }
    
    
    //MARK: FatalError && CloseSession
    
    @IBAction func CloseSession(_ sender: Any) {
        
        switch provider{
            
        case .basic, .google:
            do{
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            }catch{
                
            }
        }
    }
    
    @IBAction func FatalErrorPressed(_ sender: Any) {
        
        fatalError()
        
    }
    
    //MARK: SaveData && DataBase
    
    @IBAction func OnSaveData(_ sender: Any) {
        
        
        
        
    }
    

}




//MARK: PickerViewData && Delegate

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == CountryPicker)
        {
            return countrys.count
        }
        else
        {
            return gender.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView == CountryPicker)
        {
            return countrys[row]
        }
        else
        {
            return gender[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == CountryPicker)
        {
            selectedCountry = countrys[row]
        }
        else
        {
            selectedGender = gender[row]
        }
        
    }
}
