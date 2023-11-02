import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    @IBAction func startButtonPressed() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func recordButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RecordsViewController") as! RecordsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

