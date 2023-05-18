//
//  ShopingDataWIthFilter.swift
//  ButtonClickActionCollection
//
//  Created by Demo 01 on 13/05/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit


class MenFashion {
    var productName:String
    var productImage:String
    var productType:String
    
    init(pName:String,pImage:String,pType:String) {
        productName = pName
        productImage = pImage
        productType = pType
    }
}





class ShopingDataWIthFilter: UIViewController {

    @IBOutlet var myCollection:UICollectionView!
    var productList = [MenFashion]()
    var searchData = [MenFashion]()
    var search = false
    var scopeButtonPressed = false
    let seacrhController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        fillData()
    }
    
    private func configureSearchController()
    {
        seacrhController.loadViewIfNeeded()
        seacrhController.searchResultsUpdater = self
        seacrhController.searchBar.delegate = self
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.searchBar.enablesReturnKeyAutomatically = false
        seacrhController.searchBar.returnKeyType = UIReturnKeyType.done
        seacrhController.searchBar.scopeButtonTitles = ["All","Kurta","Perfume","Mobile","Sarre"]
        definesPresentationContext = true
        seacrhController.searchBar.placeholder = "Search Product By Name"
        self.navigationItem.searchController = seacrhController
        self.navigationItem.hidesSearchBarWhenScrolling=false
        
    }
    
    
    
    
    
    private func fillData()
        {
            productList = [MenFashion(pName: "Mens-Kurta", pImage: "kurta1", pType: "Kurta"),
             MenFashion(pName: "Mens-Kurta", pImage: "kurta2", pType: "Kurta1"),
           MenFashion(pName: "Mens-Kurta", pImage: "kurta3", pType: "Kurta"),
        MenFashion(pName: "Mens-Kurta", pImage: "kurta4", pType: "Kurta"),
       
         MenFashion(pName: "Mens-Perfume", pImage: "perfume1", pType: "Perfume"),
         MenFashion(pName: "Mens-Perfume", pImage: "perfume2", pType: "Perfume"),
        MenFashion(pName: "Mens-Perfume", pImage: "perfume2", pType: "Perfume"),
        MenFashion(pName: "Mens-Perfume", pImage: "perfume2", pType: "Perfume"),
        
             MenFashion(pName: "Vivo", pImage: "vivo", pType: "Mobile"),
              MenFashion(pName: "APple", pImage: "apple", pType: "Mobile"),
            MenFashion(pName: "Samsuang", pImage: "sum", pType: "Mobile"),
        MenFashion(pName: "OnePlus", pImage: "one", pType: "Mobile"),
        
    MenFashion(pName: "Saree", pImage: "saree1", pType: "Sarre"),
    MenFashion(pName: "Saree", pImage: "saree2", pType: "Sarre"),
    MenFashion(pName: "Saree", pImage: "saree3", pType: "Sarre"),
    MenFashion(pName: "Saree", pImage: "saree4", pType: "Saree"),
            ]
    }

    
}


extension ShopingDataWIthFilter:UICollectionViewDelegate,UICollectionViewDataSource,UISearchResultsUpdating,UISearchBarDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search || scopeButtonPressed
        {
            return searchData.count
        }
        else{
          return  productList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! productCell
        if search || scopeButtonPressed
        {
            cell.image.image = UIImage(named: searchData[indexPath.row].productImage)
            cell.lblName.text = searchData[indexPath.row].productName
        }
        else{
            cell.image.image = UIImage(named: productList[indexPath.row].productImage)
            cell.lblName.text = productList[indexPath.row].productName
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        let searchText = searchController.searchBar.text!
        if searchText.isEmpty{
            search = true
            searchData.removeAll()
            for product in productList
            {
                if product.productName.lowercased().contains(searchText.lowercased()) &&
                (product.productType==scopeButton||scopeButton=="All")
                {
                    searchData.append(product)
                }
            }
        }
        else
        {
            if scopeButtonPressed
            {
                searchData.removeAll()
                let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
                for product in productList
                {
                    if (product.productType==scopeButton||scopeButton=="All")
                    {
                        searchData.append(product)
                    }
                }
                search = false
                myCollection.reloadData()
            }
            else
            {
                search = false
                searchData.removeAll()
                searchData = productList
            }
        }
        myCollection.reloadData()
    }
    
    func searchBarCancelButton() {
        search = false
        searchData.removeAll()
        myCollection.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        seacrhController.searchBar.text = ""
        scopeButtonPressed = true
        let scopeButton = seacrhController.searchBar.scopeButtonTitles![seacrhController.searchBar.selectedScopeButtonIndex]
        searchData.removeAll()
        for product in productList
        {
            if (product.productType==scopeButton||scopeButton=="All")
            {
                searchData.append(product)
            }
        }
        myCollection.reloadData()
        
    }
}
