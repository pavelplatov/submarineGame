import Foundation

protocol GameViewControllerDelegate: AnyObject {
    func gameViewController(_ viewController: GameViewController, didUpdateTopScores scores: [Int])
}
