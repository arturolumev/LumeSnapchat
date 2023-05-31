//
//  ViewController.swift
//  LumeSnapchat
//
//  Created by Arturo Lume on 31/05/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
            } else {
                print("Inicio de sesion exitoso")
            }
        }
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
        }
    }
}
