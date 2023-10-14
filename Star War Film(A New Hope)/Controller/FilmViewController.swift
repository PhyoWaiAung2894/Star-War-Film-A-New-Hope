
import UIKit
import Alamofire

class FilmViewController: UITableViewController {
    
    var films = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Star War Film"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle:nil), forCellReuseIdentifier: "ResuableCell")
        
        for filmNumber in 1...5 {
            let filmURL = getFilmURL(for: filmNumber)
            
            AF.request(filmURL, method: .get).responseDecodable(of: Film.self) { response in
                switch response.result {
                case .success(let film):
                    self.films.append(film)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching film data from API URL \(error)")
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResuableCell", for: indexPath) as! FilmTableViewCell
        let film = films[indexPath.row]
        
        cell.titleLabel.text = film.title
        cell.releaseDateLabel.text = film.release_date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.directorName = films[indexPath.row].director
            vc.openingCrawl = films[indexPath.row].opening_crawl
            vc.filmName = films[indexPath.row].title
            vc.StarShip = films[indexPath.row].starships
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
