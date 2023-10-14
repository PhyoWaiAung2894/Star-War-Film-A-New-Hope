
import UIKit
import Alamofire
import MBProgressHUD

class FilmViewController: UITableViewController {
    
    var films = [Film]()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Star War Film"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle:nil), forCellReuseIdentifier: "ResuableCell")
        
        getFilms()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    func getFilms(){
        let totalFilmsUrl: [URL] = Utils.getTotalFilmUrls()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        for filmURL in totalFilmsUrl {
            dispatchGroup.enter()
            AF.request(filmURL, method: .get).responseDecodable(of: Film.self) { response in
                switch response.result {
                case .success(let film):
                    self.films.append(film)
                    self.dispatchGroup.leave();
                case .failure(let error):
                    print("Error fetching film data from API URL \(error)")
                    self.dispatchGroup.leave();
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
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
