
import UIKit
import Alamofire
import MBProgressHUD

class FilmViewController: UITableViewController {
    
    var filmModle : StarWarFilmModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Star War Film"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle:nil), forCellReuseIdentifier: "ResuableCell")
        
        getFilms()
        
    }
    
    func getFilms(){
        
        let filmURL = "https://swapi.dev/api/films/"
        
        AF.request(filmURL, method: .get).responseDecodable(of: StarWarFilmModel.self){ response in
            switch response.result {
            case .success(let data):
                self.filmModle = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmModle?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResuableCell") as! FilmTableViewCell
        if let film = filmModle?.results[indexPath.row] {
            
            cell.titleLabel.text = film.title
            cell.releaseDateLabel.text = film.release_date
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if let film = filmModle?.results[indexPath.row] {
                destinationVC.directorName = film.director
                destinationVC.openingCrawl = film.opening_crawl
                destinationVC.StarShip = film.starships
            }
        }
    }
}
