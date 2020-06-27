//
//  StartViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/21.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    var presentationModel: StartPresentationModel!

    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var weatherButton: UIButton!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weatherInfo = R.segue.startViewController.toWeather(segue: segue),
            let model = presentationModel.makeWeatherPresentationModel(weather: sender) {
            weatherInfo.destination.presentationModel = model
        } else if let historyInfo = R.segue.startViewController.toHistory(segue: segue) {
            historyInfo.destination.presentationModel = presentationModel.makeHistoryPresentationModel()
        } else {
            log?.warning("想定外の遷移")
        }
    }

    private func showIndicator() {
        indicator.startAnimating()
        weatherButton.isEnabled = false
        historyButton.isEnabled = false
    }

    private func hideIndicator() {
        indicator.stopAnimating()
        weatherButton.isEnabled = true
        historyButton.isEnabled = true
    }

    // MARK: - IBAction
    
    @IBAction private func showWeather(_ sender: Any) {
        showIndicator()
        presentationModel.getWeather { [unowned self] result in
            self.hideIndicator()
            switch result {
            case .success(let weather):
                self.performSegue(withIdentifier: R.segue.startViewController.toWeather, sender: weather)
            case .failure(let error):
                self.showAlert(message: "天気情報の取得に失敗しました")
                log?.error(error.localizedDescription)
            }
        }
    }

    @IBAction private func showHistory(_ sender: Any) {
        performSegue(withIdentifier: R.segue.startViewController.toHistory, sender: nil)
    }
}
