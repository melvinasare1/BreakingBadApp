//
//  HomePageViewController.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

class HomePageViewController: UIViewController {

    private lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        return collectionView
    }()

    private let viewModel: HomePageViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Character>!

    enum Section { case main }

    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        configureCollectionViewDataSource()
        updateCollectionView(on: viewModel.characters)
    }
}

private extension HomePageViewController {
    func setup() {
        view.backgroundColor = .white

        view.addSubview(characterCollectionView)

        let filterButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(filterButtonPressed))
        navigationItem.rightBarButtonItem = filterButton

        viewModel.fetchCharacterData { [weak self] characterData in
            guard let self = self else { return }
            self.updateCollectionView(on: self.viewModel.characters)
        }
    }

    @objc func filterButtonPressed() {
        print("Filter Pressed")
    }
}

extension HomePageViewController: UICollectionViewDelegate {

    func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: characterCollectionView, cellProvider: { (collectionView, indexPath, characters) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomePageCollectionViewCell
            cell?.configure(with: characters)
            return cell
        })
    }

    func updateCollectionView(on followers: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
