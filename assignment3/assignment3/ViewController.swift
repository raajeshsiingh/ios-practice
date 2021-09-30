import UIKit
class ViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tabSegmentControl: UISegmentedControl!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var switch5: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressBar: UIProgressView!
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.isHidden = true
        secondView.isHidden = true
        thirdView.isHidden = true
        passwordTextField.isSecureTextEntry = true
        //initializing delegates for UITextFields
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNoTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        //providing tags to UITextFields
        firstNameTextField.tag = 0
        lastNameTextField.tag = 1
        emailTextField.tag = 2
        passwordTextField.tag = 3
        phoneNoTextField.tag = 4
    }
    //submit button tapped
    @IBAction func submitInfo(_ sender: Any) {
        //setting UiLabel text to UITextField text
        firstNameLabel.text = firstNameTextField.text
        lastNameLabel.text = lastNameTextField.text
        phoneNoLabel.text = phoneNoTextField.text
        emailLabel.text = emailTextField.text
        passwordLabel.text = passwordTextField.text
        //setting UITextFields empty
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNoTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    //edit button tapped
    @IBAction func editInfo(_ sender: Any) {
        //setting UITextField text to UILabel text
        firstNameTextField.text = firstNameLabel.text
        lastNameTextField.text = lastNameLabel.text
        phoneNoTextField.text = phoneNoLabel.text
        emailTextField.text = emailLabel.text
        passwordTextField.text = passwordLabel.text
    }
    @IBAction func changeView(_ sender: Any) {
        if tabSegmentControl.selectedSegmentIndex == 0{
            //showing necessary UIElements
            firstView.isHidden = false
            secondView.isHidden = true
            thirdView.isHidden = true
            //setting as firstResponder to keyboard toggle
            firstNameTextField.becomeFirstResponder()
        }
        if tabSegmentControl.selectedSegmentIndex == 1{
            //showing necessary UIElements
            firstView.isHidden = true
            secondView.isHidden = false
            thirdView.isHidden = true
            //resigning as first responde if found any
            firstNameTextField.resignFirstResponder()
            phoneNoTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
        if tabSegmentControl.selectedSegmentIndex == 2 {
            //showing necessary UIElements
            firstView.isHidden = true
            secondView.isHidden = true
            thirdView.isHidden = false
            //resigning as first responde if found any
            firstNameTextField.resignFirstResponder()
            phoneNoTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func switch1Tap(_ sender: UISwitch){
        if sender.isOn{
            slider.value = 1.0
            progressBar.setProgress(1/5, animated: true)
        }
        else {
            slider.value = 0.0
            progressBar.setProgress(0/5, animated: true)
            switch2.isOn = false
            switch3.isOn = false
            switch4.isOn = false
            switch5.isOn = false
        }
    }
    
    @IBAction func switch2Tap(_ sender: UISwitch){
        if sender.isOn{
            slider.value = 2.0
            progressBar.setProgress(2/5, animated: true)
            switch1.isOn = true
        }
        else {
            slider.value = 1.0
            progressBar.setProgress(1/5, animated: true)
            switch3.isOn = false
            switch4.isOn = false
            switch5.isOn = false
        }
    }
    @IBAction func switch3Tap(_ sender: UISwitch){
        if sender.isOn{
            slider.value = 3.0
            progressBar.setProgress(3/5, animated: true)
            switch1.isOn = true
            switch2.isOn = true
        }
        else {
            slider.value = 2.0
            progressBar.setProgress(2/5, animated: true)
            switch4.isOn = false
            switch5.isOn = false
        }
    }
    @IBAction func switch4Tap(_ sender: UISwitch){
        if sender.isOn{
            slider.value = 4.0
            progressBar.setProgress(4/5, animated: true)
            switch1.isOn = true
            switch2.isOn = true
            switch3.isOn = true
        }
        else {
            slider.value = 3.0
            progressBar.setProgress(3/5, animated: true)
            switch5.isOn = false
        }
    }
    @IBAction func switch5Tap(_ sender: UISwitch){
        if sender.isOn{
            slider.value = 5.0
            progressBar.setProgress(5/5, animated: true)
            switch1.isOn = true
            switch2.isOn = true
            switch3.isOn = true
            switch4.isOn = true
        }
        else {
            slider.value = 4.0
            progressBar.setProgress(4/5, animated: true)
        }
    }
    //UISlider is tapped
    @IBAction func sliderTap(_ sender: UISlider) {
        //checking value of slider and setting switch & progressBar according to it
        if slider.value >= 0.0 && slider.value < 0.5{
            switch5.isOn = false
            switch4.isOn = false
            switch3.isOn = false
            switch2.isOn = false
            switch1.isOn = false
            progressBar.progress = Float((slider.value)/5)
        }
        //checking value of slider and setting switch & progressBar according to it
        if slider.value > 0.5 && slider.value < 1.5{
            switch5.isOn = false
            switch4.isOn = false
            switch3.isOn = false
            switch2.isOn = false
            switch1.isOn = true
            progressBar.progress = Float((slider.value)/5)
        }
        //checking value of slider and setting switch & progressBar according to it
        if slider.value > 1.5 && slider.value < 2.5{
            switch5.isOn = false
            switch4.isOn = false
            switch3.isOn = false
            switch2.isOn = true
            switch1.isOn = true
            progressBar.progress = Float((slider.value)/5)
        }
        //checking value of slider and setting switch & progressBar according to it
        if slider.value > 2.5 && slider.value < 3.5{
            switch5.isOn = false
            switch4.isOn = false
            switch3.isOn = true
            switch2.isOn = true
            switch1.isOn = true
            progressBar.progress = Float((slider.value)/5)
        }
        //checking value of slider and setting switch & progressBar according to it
        if slider.value > 3.5 && slider.value < 5.0{
            switch5.isOn = false
            switch4.isOn = true
            switch3.isOn = true
            switch2.isOn = true
            switch1.isOn = true
            progressBar.progress = Float((slider.value)/5)
        }
        //checking value of slider and setting switch & progressBar according to it
        if slider.value == 5.0{
            switch5.isOn = true
            switch4.isOn = true
            switch3.isOn = true
            switch2.isOn = true
            switch1.isOn = true
            progressBar.progress = Float((slider.value)/5)
        }
    }
}
//MARK:- Delegate Methods
extension ViewController: UITextFieldDelegate {
    //choosing the current responder for keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Trying to find next responder
          if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
             nextField.becomeFirstResponder()
          }
          else {
             // Not found, so remove keyboard.
             textField.resignFirstResponder()
          }
          return false
       }
    //resigning as first responder when touched somewhere other than keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          phoneNoTextField.resignFirstResponder()
      }
    //setting maximum character and type of character according to different textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        if textField == firstNameTextField || textField == lastNameTextField {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
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
        if textField == passwordTextField {
            
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength { return false }
    }
        else if textField == emailTextField {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9@.].*", options: [])
            if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil){ return false }
        }
        catch { print("ERROR") }
    }
      
        else if textField == phoneNoTextField {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        do {
            let regex = try NSRegularExpression(pattern: ".*[^0-9].*", options: [])
            if (regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil) || (newString.length > maxLength) { return false }
        }
        catch { print("ERROR") }
    }
    return true
    }
}
