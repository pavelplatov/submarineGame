import UIKit

class RecordsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var score1Label: UILabel!
    @IBOutlet var score2Label: UILabel!
    @IBOutlet var score3Label: UILabel!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    var topScores: [Int] = [0, 0, 0]
    var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViews = [image1, image2, image3]
        
        score1Label.text = "Score: \(topScores[0])"
        score2Label.text = "Score: \(topScores[1])"
        score3Label.text = "Score: \(topScores[2])"
        
        for (index, imageView) in imageViews.enumerated() {
            if let loadedImage = loadImage(forKey: "Image\(index + 1)") {
                imageView.image = loadedImage
            }
        }
    }
    
    func saveImage(image: UIImage, forKey key: String) {
        if let imageData = image.pngData() {
            UserDefaults.standard.set(imageData, forKey: key)
        }
    }
    
    func loadImage(forKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: key), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func selectImage(for index: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.view.tag = index
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            if let tag = picker.view?.tag, tag >= 0, tag < imageViews.count {
                imageViews[tag].image = pickedImage
                saveImage(image: pickedImage, forKey: "Image\(tag + 1)")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoFor1Record(_ sender: Any) {
        selectImage(for: 0)
    }
    
    @IBAction func addPhotoFor2Record(_ sender: Any) {
        selectImage(for: 1)
    }
    
    @IBAction func addPhotoFor3Record(_ sender: Any) {
        selectImage(for: 2)
    }
}
