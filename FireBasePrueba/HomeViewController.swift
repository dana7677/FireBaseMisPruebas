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
    
    private let email:String
    private let provider:ProviderType
    
    @IBOutlet weak var ErrorButton: UIButton!
    
    init(email:String, provider:ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserLabel.text = email
        PasswordLabel.text = provider.rawValue

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
