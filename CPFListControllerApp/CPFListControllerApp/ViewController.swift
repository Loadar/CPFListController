//
//  ViewController.swift
//  CPFListControllerApp
//
//  Created by Aaron on 2021/5/15.
//

import UIKit
import CPFChain
import CPFWaterfallFlowLayout

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionButton = UIButton(type: .custom)
        view.addSubview(collectionButton)
        collectionButton.frame = CGRect(x: 40, y: 100, width: UIScreen.main.bounds.width - 80, height: 60)
        collectionButton.setTitleColor(.black, for: .normal)
        collectionButton.setTitle("Collection", for: .normal)
        collectionButton.addTarget(self, action: #selector(toCollection), for: .touchUpInside)
        
        let tableButton = UIButton(type: .custom)
        view.addSubview(tableButton)
        tableButton.frame = CGRect(x: 40, y: 200, width: UIScreen.main.bounds.width - 80, height: 60)
        tableButton.setTitleColor(.black, for: .normal)
        tableButton.setTitle("Table", for: .normal)
        tableButton.addTarget(self, action: #selector(toTable), for: .touchUpInside)

    }
    
    
    @objc func toCollection() {
        present(CollectionViewController(), animated: true, completion: nil)
    }
    
    @objc func toTable() {
        present(TableViewController(), animated: true, completion: nil)
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
