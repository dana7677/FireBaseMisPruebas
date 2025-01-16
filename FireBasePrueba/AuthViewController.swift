//
//  AuthViewController.swift
//  FireBasePrueba
//
//  Created by Tardes on 10/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import GoogleSignIn
import FirebaseRemoteConfig

class AuthViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var CreateButton: UIButton!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBAction func SignByGooglePress(_ sender: Any) {
        
        // Configure Google SignIn with Firebase
                // Start the sign in flow!
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                    guard error == nil else {
                        return
                    }

                    guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                        return
                    }

                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

                    Auth.auth().signIn(with: credential) { result, error in
                        guard error == nil else {
                            return
                        }
                        
                        // At this point, our user is signed in
                        self.performSegue(withIdentifier: "goToHome", sender: nil)
                    }
                }
        
    }
    
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        let username = UserEmail.text!
                Auth.auth().sendPasswordReset(withEmail: username) { error in
                    if (error != nil) {
                        print(error!.localizedDescription)
                    }
                }
                let alert = UIAlertController(title: "Recuperar contraseña", message: "Te hemos enviado un correo a \(username) para recuperar tu contraseña.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
    }
    
    
    @IBAction func CreatePressed(_ sender: UIButton) {
        
        if let email = UserEmail.text,let password =
            UserPassword.text{
            
            Auth.auth().createUser(withEmail: email, password: password){
                (result,error)in
                if let result = result , error == nil{
                    self.performSegue(withIdentifier: "goToHome", sender: nil)
                    
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando al usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true,completion: nil)
                }
                
            }
            
        }
    }
    @IBAction func LoginPressed(_ sender: Any) {
        
        if let email = UserEmail.text,let password =
            UserPassword.text{
            
            Auth.auth().signIn(withEmail: email, password: password){
                (result,error)in
                if let result = result , error == nil{
                    //self.navigationController?
                        //.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    self.performSegue(withIdentifier: "goToHome", sender: nil)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando al usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true,completion: nil)
                }
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToHome") {
                let homeViewController = segue.destination as! HomeViewController
                homeViewController.email = UserEmail.text!
            homeViewController.provider = ProviderType.basic
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Authenticaton"
        
        Analytics.logEvent("InitScreen", parameters: ["Message":"Integracion de FireBase Completa"])
        
        //Remote Config
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60 //Tiempo que se tarda en hacer el cambio, de serie son 12 horas
        
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(["show_error_button":NSNumber(true),"error_button_text":NSString("Forzar error")])
        
    }


}

