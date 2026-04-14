//
//  ImageViews.swift
//

import UIKit

class ImageViews: BlastController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageRow: BlastRow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "ImageViews"
        
        // Register XIBs
        self.registerCells([XIBCellOneImageView, XIBCellTwoImageViews, XIBCellThreeImageViews])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("One (tap to change)")
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneImageView)
        row.image1.image(UIImage(named: "Image1")!)
        row.cellTapped = { [weak self] in
            self?.showImageSourcePicker()
        }
        self.imageRow = row
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Two")
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellTwoImageViews)
        row.image1.image(UIImage(named: "Image1")!)
        row.image2.image(UIImage(named: "Image2")!)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Three")
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellThreeImageViews)
        row.image1.image(UIImage(named: "Image1")!)
        row.image2.image(UIImage(named: "Image2")!)
        row.image3.image(UIImage(named: "Image3")!)
        section.addRow(row)
    }
    
    // MARK: - Image Picker
    
    func showImageSourcePicker() {
        let alert = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .camera)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.presentImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            imageRow?.image1.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
