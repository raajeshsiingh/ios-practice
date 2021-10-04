import UIKit
class ViewController: UIViewController {
    //MARK :- Outlets
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var viewSegmentControl: UISegmentedControl!
    @IBOutlet weak var submitInfoButton: UIButton!
    //MARK :- Variables
    let genderArray = ["Male", "Female", "Binary"]
    var genderPickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var comps = DateComponents()
    let calendar = Calendar(identifier: .gregorian)
    //MARK :- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideEverything()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextField.inputView = genderPickerView
        createDatePicker()
        comps.year = 105
        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        comps.year = -18
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = minDate
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        dobTextField.delegate = self
        genderTextField.delegate = self
        phoneNoTextField.delegate = self
        emailTextField.delegate = self
        firstNameTextField.tag = 0
        lastNameTextField.tag = 1
        emailTextField.tag = 2
        phoneNoTextField.tag = 3
        datePicker.preferredDatePickerStyle = .wheels
    }
    //function to resign phoneNoTextField as first responder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNoTextField.resignFirstResponder()
    }
    //selecting photo
    @IBAction func selectPhoto(_ sender: UIButton) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = false
        self.present(imageController, animated: true, completion: nil)
    }
    //submit information
    @IBAction func submitInfo(_ sender: Any) {
        firstNameLabel.text = firstNameTextField.text
        lastNameLabel.text = lastNameTextField.text
        phoneNoLabel.text = phoneNoTextField.text
        emailLabel.text = emailTextField.text
        genderLabel.text = genderTextField.text
        dobLabel.text = dobTextField.text
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNoTextField.text = ""
        emailTextField.text = ""
        genderTextField.text = ""
        dobTextField.text = ""
    }
    //segmentcontrol
    @IBAction func viewChange(_ sender: Any) {
        if viewSegmentControl.selectedSegmentIndex == 0{
            hideEverything()
            photoImageView.isHidden = false
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            phoneNoTextField.isHidden = false
            emailTextField.isHidden = false
            genderTextField.isHidden = false
            dobTextField.isHidden = false
            selectPhotoButton.isHidden = false
            submitInfoButton.isHidden = false
            firstNameTextField.becomeFirstResponder()
        } else {
            hideEverything()
            firstNameLabel.isHidden = false
            phoneNoLabel.isHidden = false
            lastNameLabel.isHidden = false
            emailLabel.isHidden = false
            genderLabel.isHidden = false
            dobLabel.isHidden = false
        }
    }
    //creating datepicker
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //adding barbutton
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([btnDone], animated: true)
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    //selector function called for done button
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = .none
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    //hiding all ui component
    func hideEverything(){
        photoImageView.isHidden = true
        firstNameTextField.isHidden = true
        lastNameTextField.isHidden = true
        phoneNoTextField.isHidden = true
        emailTextField.isHidden = true
        genderTextField.isHidden = true
        dobTextField.isHidden = true
        selectPhotoButton.isHidden = true
        submitInfoButton.isHidden = true
        firstNameLabel.isHidden = true
        phoneNoLabel.isHidden = true
        lastNameLabel.isHidden = true
        emailLabel.isHidden = true
        genderLabel.isHidden = true
        dobLabel.isHidden = true
    }
}
//MARK :- delegate methods for picking image
extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //picking image from gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            //setting ui design for imageview
            photoImageView.image = image
            photoImageView.layer.borderWidth = 1
            photoImageView.layer.masksToBounds = false
            photoImageView.layer.borderColor = UIColor.black.cgColor
            photoImageView.layer.cornerRadius = photoImageView.frame.height/2
            photoImageView.clipsToBounds = true
            selectPhotoButton.setTitle("CHANGE PHOTO", for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
//MARK :- delegate methods for pickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return genderArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return genderArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        genderTextField.text = genderArray[row]
        genderTextField.resignFirstResponder()
    }
}
//MARK :- delegate methods for textfields
extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        if textField == firstNameTextField || textField == lastNameTextField{
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil) || (newString.length > maxLength) {
                    return false
                }
            }catch {
                print("ERROR")
            }
        }else if textField == emailTextField{
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9@.].*", options: [])
                if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil){
                    return false
                }
            }catch {
                print("ERROR")
            }
        }else if textField == dobTextField || textField == genderTextField{
            return false
        }else if textField == phoneNoTextField{
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            do {
                let regex = try NSRegularExpression(pattern: ".*[^0-9].*", options: [])
                if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil) || (newString.length > maxLength) {
                    return false
                }
            }catch {
                print("ERROR")
            }
        }
        return true
    }
    //when return key pressed on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
