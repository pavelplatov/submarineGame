import UIKit

class GameViewController: UIViewController {
    private let minY: CGFloat = 390
    private let maxY: CGFloat = 750
    var score = 0
    var timer: Timer?
    var score1: Int = 0
    var score2: Int = 0
    var score3: Int = 0
    
@IBOutlet var scoreLabel: UILabel!
@IBOutlet var backGround: UIImageView!
@IBOutlet var boatTwo: UIImageView!
@IBOutlet var boatOne: UIImageView!
@IBOutlet var sharkOne: UIImageView!
@IBOutlet var sharkTwo: UIImageView!
@IBOutlet var submarine: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(increaseScore), userInfo: nil, repeats: true)

        let submarineImage = UIImage(named: "submarine")
        self.submarine.image = submarineImage
        let boatOneImage = UIImage(named: "boat1")
        self.boatOne.image = boatOneImage
        let boatTwoImage = UIImage(named: "boat2")
        self.boatTwo.image = boatTwoImage
        let sharkOneImage = UIImage(named: "shark1")
        self.sharkOne.image = sharkOneImage
        let sharkTwoImage = UIImage(named: "shark2")
        self.sharkTwo.image = sharkTwoImage
        let backGroundImage = UIImage(named: "background")
        self.backGround.image = backGroundImage

        animateSharkOne()
        animateSharkTwo()
        animateBoatOne()
        animateBoatTwo()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        if score > score1 {
               score3 = score2
               score2 = score1
               score1 = score
           } else if score > score2 {
               score3 = score2
               score2 = score
           } else if score > score3 {
               score3 = score
           }
        
    }

    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        if let submarinePresentation = submarine.layer.presentation(),
           let boatOnePresentation = boatOne.layer.presentation(),
           let boatTwoPresentation = boatTwo.layer.presentation(),
           let sharkOnePresentation = sharkOne.layer.presentation(),
           let sharkTwoPresentation = sharkTwo.layer.presentation(),
           (submarinePresentation.frame.intersects(boatOnePresentation.frame)
            || submarinePresentation.frame.intersects(boatTwoPresentation.frame)
            || submarinePresentation.frame.intersects(sharkOnePresentation.frame)
            || submarinePresentation.frame.intersects(sharkTwoPresentation.frame)) {
            endGame()
        } else {
            if sender.state == .changed {
                let translation = sender.translation(in: self.view)
                let newY = submarine.frame.origin.y + translation.y
                if newY >= minY && newY <= maxY {
                    submarine.frame.origin.y = newY
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
        }
    }

    private func animateSharkOne() {
        let animationDuration: TimeInterval = 5.0
        self.sharkOne.frame.origin = CGPoint(x: 400, y: 500)
        UIView.animate(withDuration: animationDuration) {
            self.sharkOne.frame.origin.x -= 600
        } completion: { _ in
            self.animateSharkOne()
        }
    }

    private func animateSharkTwo() {
        let animationDuration: TimeInterval = 3.5
        sharkTwo.frame.origin = CGPoint(x: 400, y: 670)
        UIView.animate(withDuration: animationDuration) {
            self.sharkTwo.frame.origin.x -= 600
        } completion: { _ in
            self.animateSharkTwo()
        }
    }

    private func animateBoatOne() {
        let animationDuration: TimeInterval = 7.0
        boatOne.frame.origin = CGPoint(x: 400, y: 370)
        UIView.animate(withDuration: animationDuration) {
            self.boatOne.frame.origin.x -= 600
        } completion: { _ in
            self.animateBoatOne()
        }
    }

    private func animateBoatTwo() {
        let animationDuration: TimeInterval = 5.0
        boatTwo.frame.origin = CGPoint(x: 450, y: 380)
        UIView.animate(withDuration: animationDuration) {
            self.boatTwo.frame.origin.x -= 600
        } completion: { _ in
            self.animateBoatTwo()
        }
    }

    private func endGame() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RecordsViewController") as! RecordsViewController
          controller.topScores = [score1, score2, score3]
          
          self.navigationController?.pushViewController(controller, animated: true)
      }
    
    deinit {
        timer?.invalidate()
    }
   
}

