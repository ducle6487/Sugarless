//
//  TypeProductViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 06/01/2021.
//

import UIKit
import SnapKit

class TypeProductViewController: UIViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, sentDataTo, sentDataToUI , sentSearchResultToUI{
    
    // MARK: - protocol function
    
    
    func onResultUpdate() {
        print(monanUtils.searchResult)
        searchResultCLV.listMonAn = monanUtils.searchResult
        searchResultCLV.collectionView.reloadData()
    }
    
    
    func onUpdateData() {
        
        listTypeProduct = typeProductUtils.listTypeProduct
        collectionView.reloadData()
        self.removeSpinner()
    }
    
    func onDataUpdate() {
        listMonAn = monanUtils.listMonAn
    }
    
    

    // MARK: - Variable
    
    private let cellId = "typeProductCell"
    
    let listColor: [UIColor] = [.systemTeal, .systemGreen, .systemPink, .cyan, .systemOrange, .systemTeal, .brown, .red, .systemYellow, .green, .systemBlue, .systemOrange, .systemPink, .systemYellow]
    
    var listMonAn = [MonAn]()
    let typeProductUtils = TypeProductUtils()
    let monanUtils = MonAnUtils()
    var listTypeProduct = [TypeProduct]()
    var coverSearchBar = UIView()
    
    var searchBar = UISearchBar()
    var cancelSearchBt = UIButton()
    var widthButtonOn : Constraint?
    var widthButtonOff : Constraint?
    
    
    
    lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let vc = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        
        vc.showsVerticalScrollIndicator = false
        
        vc.delegate = self
        vc.dataSource = self
        
        vc.backgroundColor = .white
        
        return vc
        
    }()
    
    
    lazy var searchResultCLV: CustomAllProductCollectionView = {

        let vc = CustomAllProductCollectionView()
        vc.prevVC = self
        return vc
    }()
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showSpinner(onView: self.view)
        
        searchBar.delegate = self
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        
        collectionView.register(TypeProductCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        typeProductUtils.delegate = self
        typeProductUtils.getTypeProductFromFireBase()
        monanUtils.delegate = self
        monanUtils.getMonAnFromFirebase()
        monanUtils.delegateSearch = self
        
        setupUI()
        
    }
    
    // MARK: - setupUI
    func setupUI(){
        
        self.view.addSubview(coverSearchBar)
        coverSearchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalToSuperview().dividedBy(12)
        }
        
        
        self.coverSearchBar.addSubview(cancelSearchBt)
        cancelSearchBt.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 20))
            widthButtonOn = make.width.equalToSuperview().dividedBy(6).constraint
            widthButtonOff = make.width.equalTo(0).constraint
            
            make.centerY.equalToSuperview()
        }
        
        widthButtonOn?.deactivate()
        cancelSearchBt.isHidden = true
        cancelSearchBt.setAttributedTitle(NSAttributedString(string: "Done", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue]), for: .normal)
        cancelSearchBt.addTarget(self, action: #selector(cancelSearchAct), for: .touchUpInside)
        cancelSearchBt.contentMode = .center
        
        
        self.coverSearchBar.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 20)
            make.trailing.equalTo(cancelSearchBt.snp.leading)
            make.centerY.equalToSuperview()
        }
        
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search store"
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 20)
            make.top.equalTo(coverSearchBar.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
        self.view.addSubview(searchResultCLV)
        searchResultCLV.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(collectionView)
        }
        
        searchResultCLV.isHidden = true
        
    }
    
    
    // MARK: - Action Function

    @objc func cancelSearchAct(){
        
        searchResultCLV.isHidden = true
        collectionView.isHidden = false
        
        searchBar.text = ""
        widthButtonOn?.deactivate()
        widthButtonOff?.activate()
        cancelSearchBt.isHidden = true
        searchBar.endEditing(true)
    }
    
    
    // MARK: - searchBar Delegate Function
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text != ""{
            widthButtonOn?.activate()
            widthButtonOff?.deactivate()
            cancelSearchBt.isHidden = false
            
            searchResultCLV.isHidden = false
            collectionView.isHidden = true
            
            monanUtils.searchWithString(key: searchBar.text ?? "")
        }else{
            cancelSearchAct()
        }
        
    }
    

}

extension TypeProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTypeProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TypeProductCollectionViewCell
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = listColor[indexPath.item].cgColor
        cell.backgroundColor = listColor[indexPath.item].withAlphaComponent(0.30)
        cell.setupView(id: listTypeProduct[indexPath.item].id ?? "", name: listTypeProduct[indexPath.item].name ?? "")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * (3/7), height: collectionView.frame.height / 3.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var list = [MonAn]()
        
        for item in listMonAn{
            if item.type == listTypeProduct[indexPath.item].id{
                list.append(item)
            }
        }
        
        if list.count > 0{
            let vc = CustomSeeAllViewController()
            vc.listMonAn = list
            vc.navTitle = listTypeProduct[indexPath.item].name
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            
            self.present(navVC, animated: true, completion: nil)
        }
        
    }
    
}
