//
//  NoHistoryViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/21.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
import WebKit

final class NoHistoryViewController: UIViewController {
    var presentationModel: HistoryPresentationModel!

    @IBOutlet private weak var avatarWebView: WKWebView!
    @IBOutlet private weak var avatarErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        avatarErrorLabel.isHidden = true
    }

    func showAvatar() {
        log?.info("アバター取得")
        presentationModel.getAvatar { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.avatarWebView.load(imageData, mimeType: "image/svg+xml",
                                        characterEncodingName: "utf-8",
                                        baseURL: URL(string: "http://localhost")!)
            case .failure(let error):
                self.avatarErrorLabel.isHidden = false
                log?.error(error.localizedDescription)
            }
        }
    }
}
