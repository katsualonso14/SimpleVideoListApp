
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetButton()
    }

    func SetButton(){
        let button = UIButton(type: .system)
        button.setTitle("test", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        view.addSubview(button)
    }

}

