//
//  CollectionViewController.swift
//  CPFListControllerApp
//
//  Created by Aaron on 2021/11/11.
//

import UIKit
import CPFWaterfallFlowLayout
import CPFChain

class CollectionViewController: UIViewController {
    private let listController = CollectionListController<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let collectionView: UICollectionView = {
            let layout = WaterfallLayout()
            layout.columnCount = 2
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.headerReferenceSize = CGSize(width: 100, height: 40)
            layout.footerReferenceSize = CGSize(width: 100, height: 60)
            return .init(frame: .zero, collectionViewLayout: layout)
        }()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        listController.cpf
            .link(collectionView)

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
//            .headerIdentifier { (indexPath) -> String in
//                return indexPath.section % 2 == 0 ? "test" : "test2"
//            }
//            .footerIdentifier { (indexPath) -> String in
//                return indexPath.section % 2 == 0 ? "test" : "test2"
//            }
//            .register(type: .header, view: TestHeader.self, for: "test") { (header, indexPath) in
//                header.label.text = "** header \(indexPath.section) **"
//            }
//            .register(type: .header, view: TestHeader.self, for: "test2") { (header, indexPath) in
//                header.label.text = "## header \(indexPath.section) ##"
//            }
//            .register(type: .footer, view: TestHeader.self, for: "test") { (footer, indexPath) in
//                footer.label.text = "** footer \(indexPath.section) **"
//            }
//            .register(type: .footer, view: TestHeader.self, for: "test2") { (footer, indexPath) in
//                footer.label.text = "## footer \(indexPath.section) ##"
//            }
//            .register(type: .header, view: UICollectionReusableView.self) { header, indexPath in
//                header.layer.borderWidth = 2
//                header.layer.borderColor = UIColor.purple.cgColor
//            }
        
        
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
            .register(type: .header, view: UICollectionReusableView.self) { header, indexPath in
                header.layer.borderWidth = 2
                header.layer.borderColor = UIColor.purple.cgColor
            }

        
        listController.cpf
//            .link(collectionView)
            .sectionCount { 5 }
            .itemList { _ in ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"] }
            .cellSize { (indexPath, _) -> CGSize in
                let width = 100 * CGFloat(indexPath.item % 5) / CGFloat(5)
                let height = CGFloat(indexPath.item % 2 == 0 ? 40 : 20)
                return CGSize(width: width, height: height)
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
//            .headerSize { (section) -> CGSize in
//                return CGSize(width: 200, height: CGFloat(section + 1) * 20)
//            }
//            .footerSize { (section) -> CGSize in
//                let height = (section % 2 == 0) ? 100 : 50
//                return CGSize(width: 160, height: height)
//            }
        
        listController.cpf
            .scrolled { (scrollView) in
                debugPrint("\(scrollView) scrolling")
            }
            .willBeginDecelerating { (_) in
                debugPrint("collection willBeginDecelerating")
            }
            .didEndDecelerating { (_) in
                debugPrint("collection didEndDecelerating")
            }
            .willBeginDragging { (_) in
                debugPrint("collection willBeginDragging")
            }
            .willEndDragging { (_, _, _) in
                debugPrint("collection willEndDragging")
            }
            .willEndDragging { (_, _, _)  in
                debugPrint("collection willEndDragging")
            }
            .didEndScrollingAnimation { (_) in
                debugPrint("collection didEndScrollingAnimation")
            }
            .shouldScrollToTop { (_) in
                debugPrint("collection shouldScrollToTop")
                return true
            }
            .didScrollToTop { (_) in
                debugPrint("collection didScrollToTop")
            }
            .didZoom { (_) in
                debugPrint("collection didZoom")
            }
            .viewForZooming { (_) in
                debugPrint("collection viewForZooming")
                return nil
            }
            .willBeginZooming { (_, _) in
                debugPrint("collection willBeginZooming")
            }
            .didEndZooming { (_, _, _) in
                debugPrint("collection didEndZooming")
            }
        
        collectionView.cpf
            .columnCount { (section) -> Int in
                return section + 1
            }
    }
}
