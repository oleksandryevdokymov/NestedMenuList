//
//  ViewController.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 15.06.2021.
//

import UIKit
import IGListKit
import Combine

class ViewController: UIViewController {
    
    private var viewModel: MenuViewModel = MenuViewModel()
    private var disposables = Set<AnyCancellable>()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .white
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    deinit {
        disposables.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func handleDidSelectMenuCell(with menuItem: OutlineItem) {
        print("Did select: \(menuItem.title)")
        // TODO: - Navigation
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        vc.title = menuItem.title
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: vc, action: #selector(onClose))
        present(navController, animated: true, completion: nil)
    }
    
    func handleDidSelectMenuDiscloseButton(with menuItem: OutlineItem) {
        print("Did select disclose item: \(menuItem.title)")
    }
    
    private func makeSectionController(for object: Any) -> ListSectionController {
        if object is OutlineViewModel {
            let menuSectionController = MenuSectionController()
            menuSectionController.publisher.sink { [weak self] selectionType in
                guard let self = self else { return }
                switch selectionType {
                case .cell(let menuItem):
                    self.handleDidSelectMenuCell(with: menuItem)
                case .discloseButton(let menuItem):
                    self.handleDidSelectMenuDiscloseButton(with: menuItem)
                }
            }
            .store(in: &disposables)
            return menuSectionController
        } else if object is SettingsViewModel {
            return SettingsSectionController()
        } else {
            return ListSectionController()
        }
    }
}

// MARK: - ListAdapterDataSource
extension ViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return makeSectionController(for: object)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension UIViewController {
    @objc func onClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
