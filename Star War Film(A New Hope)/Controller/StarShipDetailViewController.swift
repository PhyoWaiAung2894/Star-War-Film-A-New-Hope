import UIKit

class StarShipDetailViewController: UIViewController {
        
    var starship_name : String?
    var starship_model: String?
    var starship_manufacture: String?
    var starship_cost: String?
    var starship_lenght: String?
    var starship_maxatmospherespeed: String?
    var starship_crew: String?
    var starship_passsenger: String?
    var starship_cargocapacity: String?
    var starship_consumable: String?
    var starship_hyperdriveratiing: String?
    var starship_mglt: String?
    var starship_class: String?
    
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var manufactureLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    @IBOutlet var maxspeedLabel: UILabel!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var crewLabel: UILabel!
    @IBOutlet var passengerLabel: UILabel!
    @IBOutlet var cargoLabel: UILabel!
    @IBOutlet var consumableLabel: UILabel!
    @IBOutlet var HyperLabel: UILabel!
    @IBOutlet var mgltLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = starship_name
        navigationItem.largeTitleDisplayMode = .never
        
        
        modelLabel.text = starship_model
        manufactureLabel.text = starship_manufacture
        costLabel.text = starship_cost
        lengthLabel.text = starship_lenght
        maxspeedLabel.text = starship_maxatmospherespeed
        classLabel.text = starship_class
        crewLabel.text = starship_crew
        passengerLabel.text = starship_passsenger
        cargoLabel.text = starship_cargocapacity
        consumableLabel.text = starship_consumable
        HyperLabel.text = starship_hyperdriveratiing
        mgltLabel.text = starship_mglt
        
    }
    

    
}
