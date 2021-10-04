//
//  ViewController.swift
//  Assignment6Rajesh
//
//  Created by Admin on 28/07/21.
//

import UIKit

var permanentInfo: [[String]] = []
var photos: [UIImage] = []

var finAge: Int = 0
var x: Int = 0


class ViewController: UIViewController{
    
    var fullName: String = ""
    var dob: String = ""
    var address: String = ""
    var photo: UIImage! = UIImage(named: "profile.png")

    var information: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "HOME"
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(rightBarButtonAction(sender: )))
        
        information.append(fullName)
        information.append(dob)
        information.append(address)
        photos.append(photo)
        permanentInfo.append(information)
        if(x == 1){
            permanentInfo.removeFirst()
            photos.removeFirst()
        }
        self.tableView.reloadData()
        }
    
    @objc func rightBarButtonAction(sender: UINavigationItem){
        let second: SecondViewController = self.storyboard?.instantiateViewController(identifier: "second") as! SecondViewController
        x = x + 1
        self.navigationController?.pushViewController(second, animated: true)
    }

}

class SecondViewController: UIViewController{
    
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var secondImageView: UIImageView!
    
    var fullName: String = ""
    var age: String = ""
    var address: String = ""
    var photo: UIImage! = UIImage(named: "profile.png")
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //making image round
        secondImageView.layer.borderWidth = 1
        secondImageView.layer.masksToBounds = false
        secondImageView.layer.borderColor = UIColor.black.cgColor
        secondImageView.layer.cornerRadius = secondImageView.frame.height/2
        secondImageView.clipsToBounds = true
        
        fullNameTextField.delegate = self
        dobTextField.delegate = self
        addressTextField.delegate = self
        
        fullNameTextField.delegate = self
        addressTextField.delegate = self
        
        fullNameTextField.becomeFirstResponder()
        
        createDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        
        fullNameTextField.text = fullName
        dobTextField.text = age
        addressTextField.text = address
        secondImageView.image = photo
        
    }

    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([btnDone], animated: true)
        
        dobTextField.inputAccessoryView = toolbar
        
        dobTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    
    @objc func donePressed(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = .none
        dobTextField.text = formatter.string(from: datePicker.date)
        finAge = abs(Int((datePicker.date.timeIntervalSinceNow)/(86400)/365))
        
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        let first: ViewController = self.storyboard?.instantiateViewController(identifier: "first") as! ViewController

        first.fullName = fullNameTextField.text!
    first.dob = dobTextField.text!
    first.address = addressTextField.text!
        first.photo = secondImageView.image

    self.navigationController?.pushViewController(first, animated: true)

 }
    
    @IBAction func selectImage(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = false
        self.present(imageController, animated: true, completion: nil)
    }
}

class ThirdViewController: UIViewController{
    
    @IBOutlet weak var thirdImageView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    var fullName: String = ""
    var age: String = ""
    var address: String = ""
    var photo: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdImageView.image = photo
        fullNameLabel.text = fullName
        ageLabel.text = age
        addressLabel.text = address
        
        thirdImageView.layer.borderWidth = 1
        thirdImageView.layer.masksToBounds = false
        thirdImageView.layer.borderColor = UIColor.black.cgColor
        thirdImageView.layer.cornerRadius = thirdImageView.frame.height/2
        thirdImageView.clipsToBounds = true
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, optionButton{
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 190
        }
    
        func numberOfSections(in tableView: UITableView) -> Int {
    
            return 1
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return permanentInfo.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if x == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell{
                    cell.cellFullName.removeFromSuperview()
                    cell.cellDOB.removeFromSuperview()
                    cell.cellAddress.removeFromSuperview()
                    cell.optionsButton.removeFromSuperview()
                    cell.cellImageView.removeFromSuperview()
                    
                    return cell
                
                }
            }
           if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            
            cell.cellFullName.text = permanentInfo[indexPath.row][0]
            cell.cellDOB.text = permanentInfo[indexPath.row][1]
            cell.cellAddress.text = permanentInfo[indexPath.row][2]
            cell.cellImageView.image = photos[indexPath.row] as UIImage

              cell.layer.borderWidth = 3.0
                cell.layer.borderColor = UIColor.black.cgColor
            cell.delegate = self
            return cell
        }
           else {
                fatalError("not able to find the cell")
           }
            
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let third: ThirdViewController = self.storyboard?.instantiateViewController(identifier: "third") as! ThirdViewController
        third.fullName = permanentInfo[indexPath.row][0]
        third.address = permanentInfo[indexPath.row][2]
        third.photo = photo
        third.age =  "\(finAge)"
        
        self.navigationController?.pushViewController(third, animated: true)
        
    }
    
    
    func optionButtonTapped(cell: TableViewCell) {
        let alertView = UIAlertController(title: "Action", message: "Choose an action", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {[self] action in
            
            let indexPath = tableView.indexPath(for: cell)
            
            let second: SecondViewController = self.storyboard?.instantiateViewController(identifier: "second") as! SecondViewController
            
                second.fullName = permanentInfo[indexPath!.row][0]
                second.age = permanentInfo[indexPath!.row][1]
                second.address = permanentInfo[indexPath!.row][2]
                second.photo = photos[indexPath!.row]
                    
            if(permanentInfo.count > 1){
                permanentInfo.remove(at: indexPath!.row)
            }
            
                tableView.reloadData()
            
        self.navigationController?.pushViewController(second, animated: true)

        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { [self] action in
            if let indexPath = tableView.indexPath(for: cell){
                permanentInfo.remove(at: indexPath.row)
                tableView.reloadData()
            }
        })

            
    
        let declineAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        alertView.addAction(declineAction)
        alertView.addAction(editAction)
        alertView.addAction(deleteAction)
        
        self.present(alertView, animated: true)
        }
    }


extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            secondImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        
        if textField == fullNameTextField{
            
            let maxLength = 20
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil) || (newString.length > maxLength) {
                return false
            }
        }

        catch {
            print("ERROR")
        }
    }
    return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Try to find next responder
          if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
             nextField.becomeFirstResponder()
          } else {
             // Not found, so remove keyboard.
             textField.resignFirstResponder()
          }
          // Do not add a line break
          return false
       }
}
