//
//  MainPageCollectionViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell, sentDataToUI{
    
    func onDataUpdate() {
        DispatchQueue.main.async { [self] in
            bestSellerCLV.listMonAn = monAnUtils.listBestSeller
            FavouriteCLV.listMonAn = monAnUtils.listFavouriting
            RecommendCLV.listMonAn = monAnUtils.listRecommend
            bestSellerCLV.collectionView.reloadData()
            FavouriteCLV.collectionView.reloadData()
            RecommendCLV.collectionView.reloadData()
        }
    }
    
    
    
    var monAnUtils = MonAnUtils()
    
    
    let screenHeight = UIScreen.main.bounds.height
    var MainPage: MainPageViewController?
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    
        
    lazy var bestSellerCLV : CustomProductCollectionView = {
        
        let vc = CustomProductCollectionView()
        
        vc.MainPage = MainPage
        
        return vc
        
    }()
    
    
    lazy var FavouriteCLV : CustomProductCollectionView = {
        
        let vc = CustomProductCollectionView()
        
        vc.MainPage = MainPage
        
        return vc
        
    }()
    
    lazy var RecommendCLV : CustomProductCollectionView = {
        
        let vc = CustomProductCollectionView()
        
        vc.MainPage = MainPage
        
        return vc
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        //protocol get mon an data
        monAnUtils.delegate = self
        
        monAnUtils.getMonAnBestSellerFromFirebase()
        monAnUtils.getMonAnRecommendFromFirebase()
        monAnUtils.getMonAnFavouriteFromFirebase()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func setupViewBestSeller(){
        
        let coverView = UIView()
        
        self.contentView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.height.equalTo(screenHeight / 2.75)
        }
        
        
        coverView.addSubview(bestSellerCLV)
        bestSellerCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(coverView.snp.top).offset((screenHeight / 2.75)*0.2)
        }
        
        
        let viewHeader = UIView()
        contentView.addSubview(viewHeader)
        viewHeader.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(bestSellerCLV.snp.top)
        }
        
        
        
        let headerLb = UILabel()
        viewHeader.addSubview(headerLb)
        headerLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        headerLb.text = "Best Selling"
        headerLb.font = .boldSystemFont(ofSize: 25)
        
        let seeAll = UIButton()
        viewHeader.addSubview(seeAll)
        seeAll.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        seeAll.setAttributedTitle(NSAttributedString(string: "See all", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]), for: .normal)
        
        seeAll.addTarget(self, action: #selector(seeAllBestSellerAct), for: .touchUpInside)
        
    }
    
    
    func setupViewFavourite(){
        
        let coverView = UIView()
        
        self.contentView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.height.equalTo(screenHeight / 2.75)
        }
        
        coverView.addSubview(FavouriteCLV)
        FavouriteCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(coverView.snp.top).offset((screenHeight / 2.75)*0.2)
        }
        
        let viewHeader = UIView()
        contentView.addSubview(viewHeader)
        viewHeader.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(FavouriteCLV.snp.top)
        }
        
        
        
        let headerLb = UILabel()
        viewHeader.addSubview(headerLb)
        headerLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        headerLb.text = "Favouriting"
        headerLb.font = .boldSystemFont(ofSize: 25)
        
        let seeAll = UIButton()
        viewHeader.addSubview(seeAll)
        seeAll.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        seeAll.setAttributedTitle(NSAttributedString(string: "See all", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]), for: .normal)
        
        seeAll.addTarget(self, action: #selector(seeAllFavouriteAct), for: .touchUpInside)
        
    }
    
    
    func setupRecommend(){
        
        let coverView = UIView()
        
        self.contentView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.height.equalTo(screenHeight / 2.75)
        }
        
        coverView.addSubview(RecommendCLV)
        RecommendCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(coverView.snp.top).offset((screenHeight / 2.75)*0.2)
        }
        
        let viewHeader = UIView()
        contentView.addSubview(viewHeader)
        viewHeader.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(RecommendCLV.snp.top)
        }
        
        
        
        let headerLb = UILabel()
        viewHeader.addSubview(headerLb)
        headerLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        headerLb.text = "Recommend"
        headerLb.font = .boldSystemFont(ofSize: 25)
        
        let seeAll = UIButton()
        viewHeader.addSubview(seeAll)
        seeAll.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        seeAll.setAttributedTitle(NSAttributedString(string: "See all", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]), for: .normal)
        
        seeAll.addTarget(self, action: #selector(seeAllRecommendAct), for: .touchUpInside)
    }
    
    
    @objc func seeAllFavouriteAct(){
        
        let vc = CustomSeeAllViewController()
        vc.listMonAn = monAnUtils.listFavouriting
        vc.navTitle = "Favouriting"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        MainPage!.present(navVC, animated: true, completion: nil)
        
    }
    
    @objc func seeAllRecommendAct(){
        
        let vc = CustomSeeAllViewController()
        vc.listMonAn = monAnUtils.listRecommend
        vc.navTitle = "Recommend"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        MainPage!.present(navVC, animated: true, completion: nil)
    }
    
    @objc func seeAllBestSellerAct(){
        
        let vc = CustomSeeAllViewController()
        vc.listMonAn = monAnUtils.listBestSeller
        vc.navTitle = "Best Selling"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        MainPage!.present(navVC, animated: true, completion: nil)
        
    }
    
    
}

