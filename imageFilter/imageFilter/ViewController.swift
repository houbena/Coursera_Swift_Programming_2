//
//  ViewController.swift
//  imageFilter
//
//  Created by HOU YADDA on 26.11.15.
//  Copyright © 2015 houyadda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewUp: UIImageView!
    
    var origImage: RGBAImage!
    
    var rgbaImage: RGBAImage!
    
    @IBOutlet var secondaryMenu: UIView!
    
    @IBOutlet weak var buttomMenu: UIView!
    
    @IBOutlet weak var filter: UIButton!
    
    var selectedFilter: String!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var compareButton: UIButton!
    
    @IBOutlet weak var origLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        origImage = RGBAImage(image: imageView.image!)
        rgbaImage = RGBAImage(image: imageView.image!)
        compareButton.enabled = false
        origLabel.hidden = true
        editButton.enabled = compareButton.enabled
        slider.hidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if compareButton.enabled && !compareButton.selected {
            imageView.image = origImage.toUIImage()
            origLabel.hidden = false
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !compareButton.selected {
            imageView.image = rgbaImage.toUIImage()
            origLabel.hidden = true
        }
    }

    @IBAction func valueChanged(sender: UISlider) {
        applyFilter()
        
    }
    
    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
    
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        self.presentViewController(actionSheet, animated: true, completion: nil)

    }
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }

    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected){
            hideSecondaryMenu()
            sender.selected = false
        }else{
            showSecondaryMenu()
            sender.selected = true
            slider.hidden = true
        }
    }
    
    @IBAction func onEdit(sender: UIButton) {
        secondaryMenu.hidden = true
        slider.hidden = false
        filter.selected = false
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if !compareButton.selected {
            imageView.image = origImage.toUIImage()
            compareButton.selected = true
            origLabel.hidden = false
        }else{
            imageView.image = rgbaImage.toUIImage()
            compareButton.selected = false
            origLabel.hidden = true
        }
    }
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = self.view
        
        presentViewController(activityController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                imageView.image = image
            rgbaImage = RGBAImage(image: imageView.image!)
            origImage = RGBAImage(image: imageView.image!)
            compareButton.enabled = false
            editButton.enabled = compareButton.enabled
            slider.hidden = true
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSecondaryMenu(){
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(buttomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        secondaryMenu.hidden = false
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.2){
            self.secondaryMenu.alpha = 1.0
        }
        
    }
    
    func hideSecondaryMenu(){
        UIView.animateWithDuration(0.2, animations: { self.secondaryMenu.alpha = 0
            }){ completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    @IBAction func applyFilter() {
        let sliderV = slider.value
        var newV = Float(0)
        if (selectedFilter != nil) {
            switch(selectedFilter){
                case "tranX":
                    newV = (sliderV / Float(slider.maximumValue) * Float(rgbaImage.width))
                    applyTrans(Int(newV))
                case "distort":
                    newV = sliderV*10
                    applyDistort(Int(newV))
                case "maxC":
                    newV = sliderV*10
                    applyMaxCol(Int(newV))
                case "contrast":
                    newV = 0.5 + sliderV
                    applyContrast(newV)
                case "brightness":
                    newV = 1 + sliderV/2
                    applyBrightness(newV)
                default: break
            }
            print (newV)

            updateImage()
        }
    }

    
    @IBAction func transX(sender: UIButton) {
        selectedFilter = "tranX"
        applyTrans(1)
        updateImage()
    }
    
    @IBAction func distort(sender: UIButton) {
        selectedFilter = "distort"
        applyDistort(1)
        updateImage()
    }
    
    @IBAction func maxCol(sender: UIButton) {
        selectedFilter = "maxC"
        applyMaxCol(13)
        updateImage()
    }
    
    @IBAction func contrast(sender: UIButton) {
        selectedFilter = "contrast"
        applyContrast(2)
        updateImage()
    }
    
    @IBAction func brightness(sender: UIButton) {
        selectedFilter = "brightness"
        applyBrightness(2)
        updateImage()
    }
    
    
    
    func updateImage(){
        imageViewUp.image = imageView.image
        imageViewUp.alpha = 1
        imageView.image = rgbaImage.toUIImage()
        
        UIView.animateWithDuration(0.4, animations: {self.imageViewUp.alpha = 0})
        
        compareButton.enabled = true
        editButton.enabled = compareButton.enabled
        slider.hidden = false

    }
    
    func applyTrans(effect: Int){
        for y in 0..<rgbaImage!.height{
            for x in 0..<rgbaImage!.width{
                let index = y * rgbaImage!.width + x
                let pixel = origImage?.pixels[index]
                
                var pixel1 = pixel
                
                if index < ((rgbaImage?.width)! * (rgbaImage?.height)!)-effect {
                    pixel1 = origImage?.pixels[index+effect]
                    rgbaImage?.pixels[index] = pixel1!
                    
                }else {
                    rgbaImage?.pixels[index] = pixel!
                    
                }
            }
        }
    }
    
    func applyDistort(effect: Int){
        for y in 0..<rgbaImage!.height{
            for x in 0..<rgbaImage!.width{
                let index = y * rgbaImage!.width + x
                let pixel = origImage?.pixels[index]
                var pixel1 = pixel

                if y%2 == 0 && index < rgbaImage!.width*rgbaImage!.height-effect{
                    pixel1 = origImage?.pixels[index+effect]
                    rgbaImage?.pixels[index] = pixel1!
                }else {
                    rgbaImage?.pixels[index] = pixel!
                }
            }
        }
    }
    
    func applyMaxCol(effect: Int){
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                var pixel = origImage.pixels[index]

                if pixel.red < UInt8(effect) {
                    pixel.red = 0
                }else{
                    pixel.red = 255 // UInt8(Int((pixel?.red)!))
                }

                if pixel.green < UInt8(effect) {
                    pixel.green = 0
                }else{
                    pixel.green = 255 // UInt8(Int((pixel?.red)!))
                }

                if pixel.blue < UInt8(effect) {
                    pixel.blue = 0
                }else{
                    pixel.blue = 255 // UInt8(Int((pixel?.red)!))
                }

                rgbaImage.pixels[index] = pixel
            }
        }
    }
    
    func applyContrast(effect : Float){
        for y in 0..<rgbaImage!.height{
            for x in 0..<rgbaImage!.width{
                let index = y * rgbaImage!.width + x
                var pixel = origImage?.pixels[index]

                let deltaRed = Int(pixel!.red)-100
                let deltaGreen = Int(pixel!.green)-100
                let deltaBlue = Int(pixel!.blue)-100

                pixel!.red = UInt8(max(min(255, (100 + Float(deltaRed) * effect)),0))
                pixel!.green = UInt8(max(min(255, (100 + Float(deltaGreen) * effect)),0))
                pixel!.blue = UInt8(max(min(255, (100 + Float(deltaBlue) * effect)),0))

                rgbaImage?.pixels[index] = pixel!
            }
        }
    }
    
    func applyBrightness(effect : Float){
        for y in 0..<rgbaImage!.height{
            for x in 0..<rgbaImage!.width{
                let index = y * rgbaImage!.width + x
                var pixel = origImage?.pixels[index]

                pixel!.red = UInt8(min(255, Float(pixel!.red) * effect))
                pixel!.green = UInt8(min(255, Float(pixel!.green) * effect))
                pixel!.blue = UInt8(min(255, Float(pixel!.blue) * effect))

                rgbaImage?.pixels[index] = pixel!

            }
        }
    }
}

