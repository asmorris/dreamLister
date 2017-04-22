//
//  ItemDetailsVC.swift
//  dreamLister
//
//  Created by Luke Morrison on 2017-04-21.
//  Copyright © 2017 Andrew Morrison. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePkr: UIPickerView!
    @IBOutlet weak var titleFld: CustomTextField!
    @IBOutlet weak var priceFld: CustomTextField!
    @IBOutlet weak var detailsFld: CustomTextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePkr: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem   = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePkr.delegate = self
        storePkr.dataSource = self
        
        imagePkr = UIImagePickerController()
        imagePkr.delegate = self
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        
//        let store2 = Store(context: context)
//        store2.name = "Tesla"
//        
//        let store3 = Store(context: context)
//        store3.name = "Bose"
//        
//        let store4 = Store(context: context)
//        store4.name = "Samsung"
//        
//        let store5 = Store(context: context)
//        store5.name = "Apple"
//        
//        let store6 = Store(context: context)
//        store6.name = "Pure Kitchen"
//        
//        ad.saveContext()
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when seelected
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePkr.reloadAllComponents()
        } catch {
            //handle error
        }
    }
    
    @IBAction func saveItemBtn(_ sender: Any) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleFld.text  {
            item.title = title
        }
        
        if let price = priceFld.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsFld.text {
            item.details = details
        }
        
        item.toStore = stores[storePkr.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        
        present(imagePkr, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = image
        }
        
        imagePkr.dismiss(animated: true, completion: nil)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleFld.text = item.title
            priceFld.text = "\(item.price)"
            detailsFld.text = item.details
            
            thumbImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePkr.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
        
    }
}
