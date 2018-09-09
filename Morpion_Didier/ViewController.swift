//
//  ViewController.swift
//  Morpion_Didier
//
//  Created by didier arrigoni on 29.04.18.
//  Copyright © 2018 Didier Arrigoni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets et variables

    @IBOutlet weak var aQuiLeTour_Label: UILabel!
    @IBOutlet weak var bouton1: UIButton!
    @IBOutlet weak var bouton2: UIButton!
    @IBOutlet weak var bouton3: UIButton!
    @IBOutlet weak var bouton4: UIButton!
    @IBOutlet weak var bouton5: UIButton!
    @IBOutlet weak var bouton6: UIButton!
    @IBOutlet weak var bouton7: UIButton!
    @IBOutlet weak var bouton8: UIButton!
    @IBOutlet weak var bouton9: UIButton!

    // permet de savoir quel joueur doit jouer
    var cercle = true
    // on crée une variable afin de réinitialiser l'ensemble des boutons
    var boutons : [UIButton] = []

    // MARK: - Méthodes projet

    override func viewDidLoad() {
        super.viewDidLoad()
        // on appelle la fonction quand la vue charge
        ajusterAQuiLeTourLabel()
        boutons = [bouton1, bouton2, bouton3, bouton4, bouton5, bouton6, bouton7, bouton8, bouton9]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Méthodes Projet

    func ajusterAQuiLeTourLabel () {
        if cercle {
            aQuiLeTour_Label.text = "Au tour du joueur 1"
        }
        else {
            aQuiLeTour_Label.text = "Au tour du joueur 2"
        }
    }

    func montrerGagnant(titre: String, joueur: String) {
        let alerte = UIAlertController(title: titre, message: joueur + " a gagné !", preferredStyle: .alert)
        // on crée une action pour ce controller > l'action (la closure, une espèce de bulle dans la fonction, au moyen de self va pouvoir aller chercher la variable ailleurs dans le ViewController) ne sera efective que lorsque l'on appuie sur le OK button !
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            for bouton in self.boutons {
                bouton.setImage(#imageLiteral(resourceName: "help"), for: .normal)
            }
            self.cercle = true
            self.ajusterAQuiLeTourLabel()
        }
        // on rajoute cette action à l'alerte qui sera de type "ok"
        alerte.addAction(ok)
        // on va présenter le UIAlerteController qui est une ss-classe de UIViewController
        present(alerte, animated: true, completion: nil)
    }

    // cette fonction va permettre de réagir s'il n'y a plus de point d'interrogation dans le jeu ! Que doit'on faire ?
    func verifierSiMvmtDisponible() -> Bool {
        for bouton in boutons {
            if bouton.image(for: .normal) == #imageLiteral(resourceName: "help") {
                return true
            }
        }
        return false
    }

    func verifierSiOnAGagne () {
        if (bouton1.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton1.image(for: .normal) == bouton2.image(for: .normal) && bouton1.image(for: .normal) == bouton3.image(for: .normal)) ||
            (bouton4.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton4.image(for: .normal) == bouton5.image(for: .normal) && bouton4.image(for: .normal) == bouton6.image(for: .normal))
            ||
            (bouton7.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton7.image(for: .normal) == bouton9.image(for: .normal) && bouton7.image(for: .normal) == bouton9.image(for: .normal))
            ||
            (bouton1.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton1.image(for: .normal) == bouton4.image(for: .normal) && bouton1.image(for: .normal) == bouton7.image(for: .normal))
            ||
            (bouton2.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton2.image(for: .normal) == bouton5.image(for: .normal) && bouton2.image(for: .normal) == bouton8.image(for: .normal))
            ||
            (bouton3.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton3.image(for: .normal) == bouton6.image(for: .normal) && bouton3.image(for: .normal) == bouton9.image(for: .normal))
            ||
            (bouton1.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton1.image(for: .normal) == bouton5.image(for: .normal) && bouton1.image(for: .normal) == bouton9.image(for: .normal))
            ||
            (bouton3.image(for: .normal) != #imageLiteral(resourceName: "help") && bouton3.image(for: .normal) == bouton5.image(for: .normal) && bouton3.image(for: .normal) == bouton7.image(for: .normal)){
            // on vérifie d'abord s'il y a un gain
            if cercle {
                montrerGagnant(titre: "Gagné !", joueur: "joueur 1")
            } else {
                montrerGagnant(titre: "Gagné !", joueur: "joueur 2")
            }

            print ("C'est gagné !")
            
        } else {
            // on continue à jouer, en vérifiant d'abord s'il faut encore jouer et ensuite, qui doit jouer
            if verifierSiMvmtDisponible() {
                if cercle {
                    cercle = false
                } else {
                    cercle = true
                }
                print ("On continue à jouer.")
                ajusterAQuiLeTourLabel()
            } else {
                montrerGagnant(titre: "Perdu !", joueur: "Aucun joueur n'a gagné !")
            }
           
        }
    }
    
    
    // MARK: - Méthodes actions

    @IBAction func boutonAppuye(_ sender: Any) {
        // il faut vérifier si l'on a appuyé sur un bouton et que l'image est un point d'interrogation.
        guard let bouton = sender as? UIButton, bouton.image(for: .normal) == #imageLiteral(resourceName: "help") else {return}
        
        if cercle {
            bouton.setImage(#imageLiteral(resourceName: "Circle"), for: .normal)
        } else {
            bouton.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        }
        ajusterAQuiLeTourLabel()
        verifierSiOnAGagne()
    }
}

