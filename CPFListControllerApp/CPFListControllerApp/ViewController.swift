//
//  ViewController.swift
//  CPFListControllerApp
//
//  Created by Aaron on 2021/5/15.
//

import UIKit
import CPFChain

class ViewController: UIViewController {
    
    private let listController = CollectionListController<String>([.base, .selectable, .supplementary, .layout, .scrollable])
    private let tableListController = TableListController<String>([.base, .selectable, .supplementary, .layout, .scrollable])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.headerReferenceSize = CGSize(width: 100, height: 40)
            layout.footerReferenceSize = CGSize(width: 100, height: 60)
            return .init(frame: .zero, collectionViewLayout: layout)
        }()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.frame.size.height = view.bounds.height / 2
        collectionView.backgroundColor = .white
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "test")
        
        listController.cpf
            .itemShouldHighlight({ (indexPath, item) -> Bool in
                print("itemShouldHighlight:", indexPath, item)
                return true
            })
            .itemDidHighlight({ (indexPath, item) in
                print("itemDidHighlight:", indexPath, item)
            })
            .itemShouldSelect({ (indexPath, item) -> Bool in
                print("itemShouldSelect:", indexPath, item)
                return true
            })
            .itemShouldDeselect({ (indexPath, item) -> Bool in
                print("itemShouldDeselect:", indexPath, item)
                return true
            })
            .itemDidSelected { (indexPath, item) in
                print("itemDidSelected:", indexPath, item)
            }
            .itemDidDeselected { (indexPath, item) in
                print("itemDidDeselected:", indexPath, item)
            }
            .itemDidUnHighlight { (indexPath, item) in
                print("itemDidUnHighlight:", indexPath, item)
            }
        
        listController.cpf
            .headerIdentifier { (indexPath) -> String in
                return indexPath.section % 2 == 0 ? "test" : "test2"
            }
            .footerIdentifier { (indexPath) -> String in
                return indexPath.section % 2 == 0 ? "test" : "test2"
            }
            .register(type: .header, view: TestHeader.self, for: "test") { (header, indexPath) in
                header.label.text = "** header \(indexPath.section) **"
            }
            .register(type: .header, view: TestHeader.self, for: "test2") { (header, indexPath) in
                header.label.text = "## header \(indexPath.section) ##"
            }
            .register(type: .footer, view: TestHeader.self, for: "test") { (footer, indexPath) in
                footer.label.text = "** footer \(indexPath.section) **"
            }
            .register(type: .footer, view: TestHeader.self, for: "test2") { (footer, indexPath) in
                footer.label.text = "## footer \(indexPath.section) ##"
            }


        listController.cpf
            .cellIdentifier { (indexPath, _) in
                
                if indexPath.item % 5 == 0 {
                    return String(describing: UICollectionViewCell.self)
                }
                
                return indexPath.item % 2 == 0 ? "test" : "test2"
            }
            .register(cell: TestCell.self, for: "test") { (cell, indexPath, item) in
                cell.contentView.backgroundColor = .red
                cell.label.text = "\(indexPath.item)" + item
            }
            .register(cell: TestCell.self, for: "test2") { (cell, indexPath, item) in
                cell.contentView.backgroundColor = .green
                cell.label.text = "\(indexPath.item)" + item
            }
            .register(cell: UICollectionViewCell.self) { (cell, _, _) in
                cell.backgroundColor = .blue
            }
            
        listController.cpf
            .link(collectionView)
            .sectionCount { 5 }
            .itemList { _ in ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"] }
            .cellSize { (indexPath) -> CGSize in
                return CGSize(width: 100 * CGFloat(indexPath.item % 5) / CGFloat(5), height: 100)
            }
            .sectionInsets { (section) -> UIEdgeInsets in
                let value: CGFloat = CGFloat(section) * 10
                return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
            }
            .lineSpacing { (section) -> CGFloat in
                return CGFloat(section) * 20
            }
            .interitemSpacing { (section) -> CGFloat in
                return section % 2 == 0 ? 0 : 30
            }
            .headerSize { (section) -> CGSize in
                return CGSize(width: 100, height: CGFloat(section + 1) * 20)
            }
            .footerSize { (section) -> CGSize in
                return CGSize(width: 60, height: section % 2 == 0 ? 100 : 50)
            }
        listController.cpf
            .scrolled { (scrollView) in
                //print("\(scrollView) scrolling")
            }
            .willBeginDecelerating { (_) in
                print("collection willBeginDecelerating")
            }
            .didEndDecelerating { (_) in
                print("collection didEndDecelerating")
            }
            .willBeginDragging { (_) in
                print("collection willBeginDragging")
            }
            .willEndDragging { (_, _, _) in
                print("collection willEndDragging")
            }
            .willEndDragging { (_, _, _)  in
                print("collection willEndDragging")
            }
            .didEndScrollingAnimation { (_) in
                print("collection didEndScrollingAnimation")
            }
            .shouldScrollToTop { (_) in
                print("collection shouldScrollToTop")
                return true
            }
            .didScrollToTop { (_) in
                print("collection didScrollToTop")
            }
            .didZoom { (_) in
                print("collection didZoom")
            }
            .viewForZooming { (_) in
                print("collection viewForZooming")
                return nil
            }
            .willBeginZooming { (_, _) in
                print("collection willBeginZooming")
            }
            .didEndZooming { (_, _, _) in
                print("collection didEndZooming")
            }
            .adjustedContentInsetChanged { (_) in
                print("collection adjustedContentInsetChanged")
            }

        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.frame.origin.y += view.bounds.height / 2
        tableView.frame.size.height = view.bounds.height / 2
        tableView.backgroundColor = .white
        
        tableView.sectionHeaderHeight = 40
        tableView.sectionFooterHeight = 40

        tableListController.cpf
            .itemShouldHighlight({ (indexPath, item) -> Bool in
                print("table itemShouldHighlight:", indexPath, item)
                return true
            })
            .itemDidHighlight({ (indexPath, item) in
                print("table itemDidHighlight:", indexPath, item)
            })
            .itemShouldSelect({ (indexPath, item) -> Bool in
                print("table itemShouldSelect:", indexPath, item)
                return true
            })
            .itemShouldDeselect({ (indexPath, item) -> Bool in
                print("table itemShouldDeselect:", indexPath, item)
                return true
            })
            .itemDidSelected { (indexPath, item) in
                print("table itemDidSelected:", indexPath, item)
            }
            .itemDidDeselected { (indexPath, item) in
                print("table itemDidDeselected:", indexPath, item)
            }
            .itemDidUnHighlight { (indexPath, item) in
                print("table itemDidUnHighlight:", indexPath, item)
            }
            .link(tableView)
            .sectionCount { 10 }
            .itemList { _ in ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"] }
            .cellIdentifier { (indexPath, _) in
                return indexPath.item % 2 == 0 ? "test" : "test2"
            }
            .register(cell: UITableViewCell.self, for: "test") { (cell, indexPath, item) in
                cell.contentView.backgroundColor = .red
                cell.textLabel?.text = "\(indexPath.item)" + item
            }
            .register(cell: UITableViewCell.self, for: "test2") { (cell, indexPath, item) in
                cell.contentView.backgroundColor = .green
                cell.textLabel?.text = "\(indexPath.item)" + item
            }
        
        
        tableListController.cpf
            .headerIdentifier { (indexPath) -> String in
                return indexPath.section % 2 == 0 ? "test" : "test2"
            }
            .footerIdentifier{ (indexPath) -> String in
                return indexPath.section % 2 == 0 ? "test" : "test2"
            }
            .register(type: .header, view: TestTableHeader.self, for: "test") { (header, indexPath) in
                header.label.text = "** header test ** \(indexPath.section)"
            }
            .register(type: .header, view: TestTableHeader.self, for: "test2") { (header, indexPath) in
                header.label.text = "## header test2 ## \(indexPath.section)"
            }
            .register(type: .footer, view: TestTableHeader.self, for: "test") { (footer, indexPath) in
                footer.label.text = "** footer test ** \(indexPath.section)"
            }
            .register(type: .footer, view: TestTableHeader.self, for: "test2") { (footer, indexPath) in
                footer.label.text = "## footer test2 ## \(indexPath.section)"
            }
            .rowHeight { (indexPath) -> CGFloat in
                return indexPath.item % 2 == 0 ? 50 : 20
            }
            .headerHeight { (section) -> CGFloat in
                return section % 2 == 0 ? 10 : 30
            }
            .footerHeight { (section) -> CGFloat in
                return section % 2 == 0 ? 100 : 60
            }


        tableListController.cpf
            .scrolled { (scrollView) in
                //print("\(scrollView) scrolling")
            }
            .willBeginDecelerating { (_) in
                print("table willBeginDecelerating")
            }
            .didEndDecelerating { (_) in
                print("table didEndDecelerating")
            }
            .willBeginDragging { (_) in
                print("table willBeginDragging")
            }
            .willEndDragging { (_, _, _) in
                print("table willEndDragging")
            }
            .willEndDragging { (_, _, _)  in
                print("table willEndDragging")
            }
            .didEndScrollingAnimation { (_) in
                print("table didEndScrollingAnimation")
            }
            .shouldScrollToTop { (_) in
                print("table shouldScrollToTop")
                return true
            }
            .didScrollToTop { (_) in
                print("table didScrollToTop")
            }
            .didZoom { (_) in
                print("table didZoom")
            }
            .viewForZooming { (_) in
                print("table viewForZooming")
                return nil
            }
            .willBeginZooming { (_, _) in
                print("table willBeginZooming")
            }
            .didEndZooming { (_, _, _) in
                print("table didEndZooming")
            }
            .adjustedContentInsetChanged { (_) in
                print("table adjustedContentInsetChanged")
            }

    }
}

class TestCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubview(label)
        label.frame = contentView.bounds
        label.textColor = .white
        label.textAlignment = .center
    }
}

class TestHeader: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        self.addSubview(label)
        label.backgroundColor = .gray
        label.frame = self.bounds
        label.textColor = .purple
        label.textAlignment = .center
    }

}

class TestTableHeader: UITableViewHeaderFooterView {
    let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubview(label)
        contentView.backgroundColor = .gray
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        label.textColor = .purple
        label.textAlignment = .center
    }
}
