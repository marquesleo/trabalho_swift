//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesListController: UIViewController, Coordinating, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    var coordinator: Coordinator?
    var collectionView: UICollectionView!
    var viewModel: MoviesViewModelType!
    
    // BIND GET SETUP
    private var data: [Movies] {
        return viewModel.model.movies
    }
    
    // MARK: - Initialize
    
   
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor  = .black
        // Register a custom UICollectionViewCell class for the collection view
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupContraints()
        
        bindSetup()
        
        // BIND ASK DATA
        viewModel.getMovies()
    }
      
    // MARK: - Private Functions
    
    private func bindSetup() {
        viewModel = MoviesViewModel(model: MoviesModel(), service: MoviesService())
        viewModel.reloadTable = self.reloadTable
    }
    
    private func setupContraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
    
    private func didTapCell(position: IndexPath) {
        let id = String(data[position.row].id)
        
        // WITHOUT COORDINATOR
        // self.present(MovieDetailsController(movieId: id), animated: true)
        coordinator?.navigate(to: .moviesDetails, data: id)
    }
    
    // MARK: - Public Functions
    
    // BIND VIEW - REACTIVE RELOAD FROM VIEW MODEL
    func reloadTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
   
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    // MARK: - Data source methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // Dequeue a reusable cell using the reuse identifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
          
             // Configure the cell with
            let url: URL? = URL(string:self.data[indexPath.row].getImagem())
            if let unwrappedURL = url {
            // Use unwrappedURL within this block
                 
            getData(from:unwrappedURL)
                { data, response, error in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? unwrappedURL.lastPathComponent)
                        print("Download Finished")
                        // always update the UI from the main thread
                        DispatchQueue.main.async() { [weak self] in
                        cell.imageView.image = UIImage(data: data)
                        }
                }
                
            }
            return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Return the size of each item in the collection view
            let itemWidth = collectionView.bounds.width / 2 - 10
            let itemHeight = itemWidth * 1.5
            return CGSize(width: itemWidth, height: itemHeight)
        }
      
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Return the number of items in your data source
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
    }*/
}


class MyCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    //@IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Initialize and configure the image view
        imageView = UIImageView(frame: contentView.bounds)
        imageView.layer.cornerRadius = imageView.frame.width / 3
        imageView.clipsToBounds = true
      
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
