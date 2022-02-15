//
//  TestTableViewController.swift
//  BottomSheetDemo
//
//  Created by Sergey Nazarov on 15.02.2022.
//  Copyright © 2022 Joom. All rights reserved.
//

import UIKit
import BottomSheet

class TestTableViewController: UIViewController {
    
    let tableView = UITableView()
    
    private var _scrollView: UIScrollView? {
        // если вернуть здесь nil то delegate didSelectRowAt срабатывает
        // или если не подписывать vc под ScrollableBottomSheetPresentedController
        // но в этом случае естественно не работает закрытие если тянуть за scroll
        tableView as UIScrollView
    }
    
    private var currentHeight: CGFloat {
        didSet {
            updatePreferredContentSize()
        }
    }
    
    init(initialHeight: CGFloat) {
        currentHeight = initialHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        updatePreferredContentSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.setNeedsLayout()
    }
    
    func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updatePreferredContentSize() {
        _scrollView?.contentSize = CGSize(width: UIScreen.main.bounds.width, height: currentHeight)
        preferredContentSize = _scrollView?.contentSize ?? CGSize(width: UIScreen.main.bounds.width, height: currentHeight)
    }
}

extension TestTableViewController: UITableViewDelegate,
                                   UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row \(indexPath.row)")
    }
}

extension TestTableViewController: ScrollableBottomSheetPresentedController {
    var scrollView: UIScrollView? {
        _scrollView
    }
}
