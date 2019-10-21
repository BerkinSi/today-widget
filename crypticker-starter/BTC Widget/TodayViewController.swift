//
//  TodayViewController.swift
//  BTC Widget
//
//  Created by Berkin Sili on 21.10.2019.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit
import NotificationCenter
import CryptoCurrencyKit


class TodayViewController: CurrencyDataViewController, NCWidgetProviding {
    
    @IBOutlet weak var vibrancyView: UIVisualEffectView!
    
    
    var lineWidth: CGFloat = 2.0


    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        lineChartView.dataSource = self
        
        priceLabel.text = "--"
        priceChangeLabel.text = "--"
        //The line below adds more & less buttons
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        vibrancyView.effect = UIVibrancyEffect.widgetPrimary()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.priceLabel.text = "$10.000"
        self.priceChangeLabel.text = "+20"
        self.updatePriceHistoryLineChart()
        //An async call to a web service

//        fetchPrices { error in
//            if error == nil { weak self in
//                if let self = self {
//
//                }
//            }
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePriceHistoryLineChart()
    }



    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
    }

        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
        toggleLineChart()

    }
    
    private func toggleLineChart() {
        let expanded = extensionContext!.widgetActiveDisplayMode == .expanded
        if expanded {
            lineWidth = 4.0
        } else {
            lineWidth = 2.0
        }
    }

    
    override func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return lineChartView.tintColor
    }
    
    override func lineChartView(_ lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return lineWidth
    }


    
}
