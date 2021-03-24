//
//  HomePageViewController.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit
import DropDown

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

    private lazy var dropDown: DropDown = {
        let dropDown = DropDown()
        let grayColor =  UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 0.5)
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.dismissMode = .onTap
        dropDown.width = 200
        dropDown.cornerRadius = 16
        dropDown.selectionBackgroundColor = .systemGreen
        dropDown.dimmedBackgroundColor = grayColor

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if index == 1 {
                self.updateCollectionView(on: self.viewModel.characters)
            }else if index == 0{
                self.updateCollectionView(on: self.viewModel.characters)
            }else{
                let characters = self.viewModel.characters.filter({ $0.appearance.contains(Int(item) ?? 0) })
                print(characters.count)
                self.updateCollectionView(on: characters)
            }
        }
        return dropDown
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

    private func addAnchorFotDropDown(){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.isUserInteractionEnabled = false
        dropDown.anchorView = btn
        btn.center = CGPoint(x: view.center.x - 60, y: view.center.y - 64)
        self.view.addSubview(btn)
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = BreakingBad.strings.searchCharacters
        navigationItem.searchController = searchController
    }
}

private extension HomePageViewController {
    func setup() {
        title = BreakingBad.strings.breakingBad
        
        view.backgroundColor = .white
        view.addSubview(characterCollectionView)

        configureSearchController()
        addAnchorFotDropDown()

        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonPressed))

        navigationItem.rightBarButtonItem = filterButton

        viewModel.fetchCharacterData { [weak self] characterData in
            guard let self = self else { return }
            self.updateCollectionView(on: self.viewModel.characters)
            let seasons = characterData.flatMap({ $0.appearance })
            var seasonsArr = ["All"]
            let unique = Array(Set(seasons)).sorted().map({ String($0)})
            seasonsArr.append(contentsOf: unique)
            self.dropDown.dataSource = seasonsArr
        }
    }

    @objc func filterButtonPressed() {
        dropDown.show()
    }
}

extension HomePageViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = viewModel.isSearching ? viewModel.filteredCharacters : viewModel.characters
        let currentCharacter = activeArray[indexPath.item]
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(characterData: currentCharacter))
        presentPanModal(profileViewController)
    }

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

extension HomePageViewController:  UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }

        if !filter.isEmpty {
            viewModel.isSearching = true
            viewModel.filteredCharacters = viewModel.characters.filter { $0.name.lowercased().contains(filter.lowercased()) }
            updateCollectionView(on: viewModel.filteredCharacters)
        }

        #warning("need to fix this")
        if !filter.isEmpty, viewModel.filteredCharacters.isEmpty {
            showEmptyStateView(in: self.view, isHidden: false)
        } else if !viewModel.filteredCharacters.isEmpty {
            showEmptyStateView(in: self.view, isHidden: true)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateCollectionView(on: viewModel.characters)
        viewModel.isSearching = false
    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !text.hasSpecialCharacters
    }
}
