
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, SelectEmployeeTypeTableViewControllerDelegate {
    
    var employee: Employee?
    
    var employeeType : EmployeeType?
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        updateEmployeeType()
        
    }
    

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet weak var employeeBirthdayPicker: UIDatePicker!
     @IBOutlet var employeeTypeLabel: UILabel!
    
    var isEditingBirthdayShown: Bool = false{
        didSet{
            tableView.beginUpdates()
            tableView.endUpdates()
            
        }
    }
    
    let employeeBirthdayPickerCellIndexPath = 2
    let employeeBirthdayCellIndexPath = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDateView()
        updateView()
        updateEmployeeType()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == employeeBirthdayPickerCellIndexPath{
            if isEditingBirthdayShown{
                return 216
            } else {
                return 0
            }
           } else {
            return 44
        }
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == employeeBirthdayCellIndexPath{
            isEditingBirthdayShown = true
            updateDateView()
            tableView.reloadData()
        } else {
            isEditingBirthdayShown = false
            tableView.reloadData()
            updateDateView()
        }
    }
    
    func updateEmployeeType(){
        if let employeeType = employeeType{
            employeeTypeLabel.text = employeeType.description()
            employeeTypeLabel.textColor = .black
            
        } else {
            employeeTypeLabel.text = " Non set "
        }
    }
    
    
    func updateDateView(){
        if isEditingBirthdayShown{
            employeeBirthdayPicker.isHidden = false
        } else {
            employeeBirthdayPicker.isHidden = true
        }
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
        dobLabel.text = dateFormatter.string(from: employeeBirthdayPicker.date)
        dobLabel.textColor = .black
    }

    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employeeBirthdayPicker.date)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
        
         
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text {
            if let employeeTypeConfirmed = employeeType{
            employee = Employee(name: name, dateOfBirth: employeeBirthdayPicker.date, employeeType: employeeTypeConfirmed)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
            
            }else {
                print("Add a new employee")
               
                
            }
        
    }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    @IBAction func birthdayPickerValueChanged(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    

}
