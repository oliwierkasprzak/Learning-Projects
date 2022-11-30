//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Oliwier Kasprzak on 25/11/2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    public var titles: [Movies] = [Movies]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    public let searchResultsCollectionView: UICollectionView = {
            
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collection
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let titles = titles[indexPath.row]
        
        APICaller.shared.getMovie(with: titles.original_name ?? "") { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titles.original_title ?? "", youtubeView: videoElement, titleOverview: titles.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    


}
