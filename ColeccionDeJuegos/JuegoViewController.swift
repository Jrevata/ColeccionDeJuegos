//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Jordan Revata Cuela on 21/09/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var juegoImageView: UIImageView!
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarButon: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var juego : Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if juego != nil {
            juegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarButon.isHidden = true
        }
        
    }

    @IBAction func fotoTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        juegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(juegoImageView.image!) as Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context : context)
            juego.titulo = tituloTextField.text
            juego.imagen = UIImagePNGRepresentation(juegoImageView.image!) as Data?
            
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        navigationController?.popViewController(animated: true)
    
    }
    
    
}
