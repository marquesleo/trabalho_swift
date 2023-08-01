//
//  MoviesDetailsController.swift
//  final_project
//
//  Created by Jackson on 16/08/22.
//

import Foundation
import UIKit


class MovieDetailsController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    var viewModel: MovieDetailsViewModel?
    var movieId: String
    //var imageView: UIImageView = UIImageView()
    
    
    lazy var imageView: UIImageView = {
        let view:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis         = .vertical
        view.distribution = .fillEqually
        view.spacing      = 20
        
        return view
    }()
    
    
    lazy var mainTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = movie?.title
        
        return view
    }()
    
    lazy var overview: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = .white
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.lineBreakMode = .byWordWrapping
        
        view.text = movie?.overview
        
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)
        
        return view
    }()
    
    private func fetchImage(imageURL: String) {
             
             guard let url = URL(string:  imageURL) else {
                 // Tratamento de erro caso a URL seja inválida
                 return
             }
             URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                 if let error = error {
                     // Tratamento de erro caso ocorra um erro na requisição
                     print("Erro ao carregar imagem: \(error.localizedDescription)")
                     return
                 }
                 DispatchQueue.main.async {
                     if let data = data, let dataImage = UIImage(data: data) {
                         self.imageView.image = dataImage
                     } else {
                         // Tratamento de erro caso os dados da imagem sejam inválidos
                         print("Erro ao carregar imagem: dados inválidos")
                     }
                 }
             }.resume()
         }
     
    lazy var voteAverage: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = String(movie?.voteAverage ?? 0.0)
        
        return view
    }()
    
    
    lazy var voteCount: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = String(movie?.voteCount ?? 0)
        
        return view
    }()
    
    lazy var genero: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = "Gênero"
        
        return view
    }()
    
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        
        view.style = .large
        view.color = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.startAnimating()
        
        return view
        
    }()
    
    var movie: MovieDetails? {
        return viewModel?.movie
    }
    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .black
       
        
        
        
       /* containerView.addArrangedSubview(mainTitle)
        containerView.addArrangedSubview(voteAverage)
        containerView.addArrangedSubview(voteCount)
        containerView.addArrangedSubview(imageView)
        containerView.addArrangedSubview(overview)*/
        view.addSubview(mainTitle)
        view.addSubview(voteAverage)
        view.addSubview(voteCount)
        view.addSubview(imageView)
        view.addSubview(overview)
        view.addSubview(genero)
        view.addSubview(stackView)
       
        
        setupConstraints()
        bindSetup()
      
    }
    
    func setupConstraints() {
        mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        mainTitle.textAlignment = .center
        
        voteAverage.topAnchor.constraint(equalTo: mainTitle.topAnchor, constant: 40).isActive = true
        voteAverage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        voteAverage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        voteCount.topAnchor.constraint(equalTo: voteAverage.topAnchor, constant: 40).isActive = true
        voteCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        voteCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        var margin: CGFloat = 10
        imageView.topAnchor.constraint(equalTo: voteCount.topAnchor, constant: 40).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -margin).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin).isActive = true
        
        margin = 16
        overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        overview.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin).isActive = true
        
       genero.translatesAutoresizingMaskIntoConstraints = false
        genero.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        genero.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        genero.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: margin).isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        stackView.topAnchor.constraint(equalTo: genero.bottomAnchor, constant: margin).isActive = true
     
        
    }
    
    func bindSetup() {
        viewModel = MovieDetailsViewModel(model: MovieDetailsModel())
       
        viewModel?.updateMovieDetails = updateScreen
        viewModel?.showLoading = showLoading
        viewModel?.hideLoading = hideLoading
        viewModel?.fetchMovie(movieId: movieId)
        
       
        
    }
    
    
    
    
    func updateScreen() {
        DispatchQueue.main.async { [weak self] in
            self?.fetchImage(imageURL: String(self?.viewModel?.movie?.getImagem() ?? ""))
            self?.mainTitle.text = (self?.viewModel?.movie?.title ?? "")
            self?.voteAverage.text = "Pontuação Média: \(String(self?.viewModel?.movie?.voteAverage ?? 0.0))"
            self?.voteCount.text = "Total de votos: \(String(self?.viewModel?.movie?.voteCount ?? 0))"
            self?.overview.text = (String(self?.viewModel?.movie?.overview ?? ""))
            self?.genero.text = (String("Gênero"))
            
            let qtd:Int = self?.viewModel?.movie?.genres?.count ?? 0
            for i in 0...qtd-1{
                let label = UILabel()
                label.text = self?.viewModel?.movie?.genres?[i].name ?? ""
                label.textColor = .white
                label.font = UIFont.boldSystemFont(ofSize: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                self?.stackView.addArrangedSubview(label)
                
            }
        }
    }
    
    func showLoading() {
        view.addSubview(spinner)
        
        spinner.heightAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.spinner.removeFromSuperview()
        }
    }
}
