//
//  ProfileViewController.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 14/03/2021.
//

import PanModal
import SDWebImage

class ProfileViewController: UIViewController {

    private lazy var avatarImageView: CustomAvatarImageView = {
        let imageView = CustomAvatarImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var characterNameLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.configure(textAlignment: .center, fontSize: 24, fontColor: .darkGray, fontWeight: .heavy)
        return label
    }()

    private var characterNickNameLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 18, fontColor: .darkGray, fontWeight: .ultraLight)
        return label
    }()

    private var occupationLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 24, fontColor: .darkGray, fontWeight: .regular)
        
        return label
    }()

    private var statusLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 24, fontColor: .darkGray, fontWeight: .heavy)
        return label
    }()

    private var seasonLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 24, fontColor: .darkGray, fontWeight: .heavy)
        return label
    }()

//    private let stackView: UIStackView = {
//        let view = UIStackView()
//        view.alignment = .center
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.axis = .vertical
//        return view
//    }()

    private var viewModel: ProfileViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCharacterData() {
        avatarImageView.sd_setImage(with: URL(string: viewModel.characterData.img))
        characterNameLabel.text = viewModel.characterData.name
        characterNickNameLabel.text = viewModel.characterData.nickname
        occupationLabel.text = viewModel.characterData.occupation.joined(separator: ", ")
        seasonLabel.text = "\(viewModel.characterData.appearance)"
    }
}

extension ProfileViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(450)
    }

    var showDragIndicator: Bool {
        return false
    }

    var anchorModalToLongForm: Bool {
        return false
    }
}

private extension ProfileViewController {
    func setup() {
        view.backgroundColor = .white

        view.addSubview(avatarImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(occupationLabel)
        view.addSubview(statusLabel)
        view.addSubview(characterNickNameLabel)
        view.addSubview(seasonLabel)

        configureCharacterData()

        let padding: CGFloat = 20

        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        characterNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true

        occupationLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 15).isActive = true
        occupationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        occupationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        seasonLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 15).isActive = true
        seasonLabel.leadingAnchor.constraint(equalTo: occupationLabel.leadingAnchor).isActive = true
        seasonLabel.trailingAnchor.constraint(equalTo: occupationLabel.trailingAnchor).isActive = true

//
//        characterNickNameLabel.leadingAnchor.constraint(equalTo: characterNameLabel.trailingAnchor, constant: 8).isActive = true
//        characterNickNameLabel.centerYAnchor.constraint(equalTo: characterNameLabel.centerYAnchor).isActive = true
//        characterNickNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true


    }
}
