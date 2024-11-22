//
//  FormTablE.swift
//  HumanAppsTask
//
//  Created by MAC on 11/15/24.
//

import UIKit

class FormTableViewController: UIViewController {
    //MARK: - Public properties
    var tableView: UITableView
    
    var widthInset:CGFloat = 0 {
        didSet {
            updateLayout(with: self.view.frame.size)
        }
    }
    
    var separatorInset: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var form: Form
    
    //MARK: - Live cycle
    init(
        form: Form = .init(sections: []),
        style: UITableView.Style = .insetGrouped,
        separatorStyle: UITableViewCell.SeparatorStyle = .singleLine) {
        self.tableView = UITableView(frame: .zero, style: style)
        self.form = form
        super.init(nibName: nil, bundle: nil)
        tableView.separatorStyle = separatorStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableView()
        updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
       coordinator.animate(alongsideTransition: { (contex) in
          self.updateLayout(with: size)
       }, completion: nil)
    }
    
    //MARK: - private methods
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.delaysContentTouches = false
        tableView.backgroundColor = .white
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size).insetBy(dx: widthInset, dy: 0)
    }
}
//MARK: - UITableViewDataSource
extension FormTableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        form.sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        form.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSection = form.sections[indexPath.section]
        let cellItem = cellSection.items[indexPath.row]
        let cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellItem.identifier) {
            //использую существующую ячейку
            cell = reuseCell
        } else {
            //создаю новую ячейку
            cell = cellItem.makeCell()
            cell.separatorInset = separatorInset
        }
        cellItem.configureCell(cell)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FormTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        form.sections[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = form.sections[section]
        
        
        if let headerItem = section.headerItem {
            return createHeaderFooter(with: headerItem)
        } else {
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = form.sections[section]
        
        if let footerItem = section.footerItem {
            return createHeaderFooter(with: footerItem)
        } else {
            return nil
        }
    }
    
    private func createHeaderFooter(with item: HeaderFooterItem) -> UIView {
        let headerFooterView: UIView
        if let headerFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.identifier) {
            headerFooterView = headerFooter
        } else {
            headerFooterView = item.makeHeaderFooter()
        }
        item.configureHeaderFooter(headerFooterView)
        return headerFooterView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let touchAction = form.sections[indexPath.section].items[indexPath.row].touchAction {
            touchAction()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
