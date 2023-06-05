//
//  TableViewController.swift
//  CPFListControllerApp
//
//  Created by Aaron on 2021/11/11.
//

import UIKit
import CPFListController

class TableViewController: UIViewController {
    private let tableListController = TableListController<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.frame = view.bounds
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
                cell.textLabel?.text = "\(indexPath.section)-\(indexPath.item)" + item
            }
            .register(cell: UITableViewCell.self, for: "test2") { (cell, indexPath, item) in
                cell.contentView.backgroundColor = .green
                cell.textLabel?.text = "\(indexPath.section)-\(indexPath.item)" + item
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
            .rowHeight { (indexPath, _) -> CGFloat in
                return indexPath.item % 2 == 0 ? 100 : 40
            }
            .headerHeight { (section) -> CGFloat in
                return section % 2 == 0 ? 10 : 30
            }
            .footerHeight { (section) -> CGFloat in
                return section % 2 == 0 ? 100 : 60
            }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableListController.cpf
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
        }
    }
}
