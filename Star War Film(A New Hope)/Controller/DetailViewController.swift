import UIKit
import Alamofire
import MBProgressHUD

class DetailViewController: UIViewController {

    var StarShipList = [StarShipModel]()
    var directorName: String?
    var openingCrawl: String?
    var StarShip: [String]?
    var filmName: String?
    
    var dispatchGroup = DispatchGroup()
    
    @IBOutlet var director_Name: UILabel!
        
    @IBOutlet var shortDescription: UITextView!
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        navigationItem.title = filmName
        navigationItem.largeTitleDisplayMode = .never
        
        director_Name.text = "Director \(directorName ?? "None")"
        shortDescription.text = openingCrawl
      
        fetchStarShipList()
        
      }
    
    func fetchStarShipList(){
        
        MBProgressHUD.showAdded(to: self.tableview, animated: true)
        if let StarShipList = StarShip {
            for starship in StarShipList {
                dispatchGroup.enter()
                
                AF.request(starship as URLConvertible, method: .get).responseDecodable(of: StarShipModel.self) { response in
                    switch response.result {
                    case .success(let starshipdetail):
                        self.StarShipList.append(starshipdetail)
                        self.dispatchGroup.leave()
                    case .failure(let error):
                        print("Error fetching starship data from API URl \(error)")
                        self.dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.tableview, animated: true)
                self.tableview.reloadData()
            }
        }
    }
}

//MARK: - TableView DataSource


extension DetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StarShipList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCellView", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = StarShipList[indexPath.row].name
        cell.accessoryType = .detailButton
        
        return cell
    }
}

//MARK: - TableView Delegate

extension DetailViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToStarShipDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! StarShipDetailViewController
        
        if let indexPath = tableview.indexPathForSelectedRow {
            
             let starship = StarShipList[indexPath.row]
                
                vc.starship_name = starship.name
                vc.starship_model = starship.model
                vc.starship_manufacture = starship.manufacturer
                vc.starship_cost = starship.cost_in_credits
                vc.starship_lenght = starship.length
                vc.starship_maxatmospherespeed = starship.max_atmosphering_speed
                vc.starship_crew = starship.crew
                vc.starship_passsenger = starship.passengers
                vc.starship_cargocapacity = starship.cargo_capacity
                vc.starship_consumable = starship.consumables
                vc.starship_hyperdriveratiing = starship.hyperdrive_rating
                vc.starship_mglt = starship.MGLT
                vc.starship_class = starship.starship_class
            
        }
    }
    
  

}
