//
//  HistoryTableViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/21.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

protocol HistoryTableViewControllerDelegate: AnyObject {
    func historyTableViewController(_ historyTableViewController: HistoryTableViewController, didSelectRowAt indexPath: IndexPath)
    func historyTableViewController(_ historyTableViewController: HistoryTableViewController, didRemoveRowAt indexPath: IndexPath)
}

final class HistoryTableViewController: UITableViewController {
    var presentationModel: HistoryPresentationModel!
    weak var delegate: HistoryTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentationModel.numberOfHistories
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyCell, for: indexPath)!
        cell.textLabel?.text = presentationModel.history(at: indexPath.row).name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            assertionFailure("削除以外の編集はないはず")
            return
        }
        presentationModel.removeHistory(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        delegate?.historyTableViewController(self, didRemoveRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.historyTableViewController(self, didSelectRowAt: indexPath)
    }
}
