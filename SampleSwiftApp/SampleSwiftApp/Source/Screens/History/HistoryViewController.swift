//
//  HistoryViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/21.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController {
    var presentationModel: HistoryPresentationModel!

    @IBOutlet private weak var noHistoryContainerView: UIView!
    @IBOutlet private weak var historyTableContainerView: UIView!

    private var noHistoryViewController: NoHistoryViewController {
        return children.first { $0 is NoHistoryViewController } as! NoHistoryViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if presentationModel.isHistoryListShown {
            showHistoryTable()
        } else {
            hideHistoryTable()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let historyTable = segue.destination as? HistoryTableViewController {
            historyTable.presentationModel = presentationModel
            historyTable.delegate = self
        } else if let noHistory = segue.destination as? NoHistoryViewController {
            noHistory.presentationModel = presentationModel
        } else if let weatherInfo = R.segue.historyViewController.toWeather(segue: segue),
            let index = sender as? Int,
            let model = presentationModel.makeWeatherPresentationModel(historyIndex: index) {
            weatherInfo.destination.presentationModel = model
        } else {
            log?.warning("想定外の遷移")
        }
    }

    private func showHistoryTable() {
        historyTableContainerView.isHidden = false
        noHistoryContainerView.isHidden = true
    }

    private func hideHistoryTable() {
        historyTableContainerView.isHidden = true
        noHistoryContainerView.isHidden = false
        noHistoryViewController.showAvatar()
    }
}

extension HistoryViewController: HistoryTableViewControllerDelegate {
    func historyTableViewController(_ historyTableViewController: HistoryTableViewController, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: R.segue.historyViewController.toWeather, sender: indexPath.row)
    }

    func historyTableViewController(_ historyTableViewController: HistoryTableViewController, didRemoveRowAt indexPath: IndexPath) {
        if presentationModel.isHistoryListShown {
            showHistoryTable()
        } else {
            hideHistoryTable()
        }
    }
}
