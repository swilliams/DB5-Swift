//
//  ViewController.swift
//  DB5Demo
//

import UIKit

class ViewController: UIViewController {

    private let theme: Theme
    @IBOutlet weak var label: UILabel!

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!, theme:Theme!) {
        self.theme = theme
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }

    required init(coder aDecoder: NSCoder) {
        self.theme = Theme(fromDictionary: NSDictionary())
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = theme.colorForKey("backgroundColor")
        label.textColor = theme.colorForKey("labelTextColor")
        label.font = theme.fontForKey("labelFont")

        theme.animateWithAnimationSpecifierKey("labelAnimation", animations: { () -> Void in
            var rLabel = self.label.frame
            rLabel.origin = self.theme.pointForKey("label")
            self.label.frame = rLabel
        }) { (Bool finished) -> Void in
            NSLog("Ran an animation")
        }

    }
}

