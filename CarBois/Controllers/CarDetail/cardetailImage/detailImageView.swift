//
//  detailImageView.swift
//  CarBois
//
//  Created by Umer Yasin on 05/09/2022.
//

import UIKit
import ImageSlideshow

class detailImageView: UIViewController,ImageSlideshowDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let taskerName = UILabel()
    let subtitleLabel = UILabel()
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    lazy var titleStackView: UIStackView = {
        
        taskerName.textColor = UIColor(named: "Green")
        taskerName.font = UIFont(name: "Inter-Regular", size: 10)
        taskerName.textAlignment = .left
        taskerName.text = "All Images"
        subtitleLabel.textColor = UIColor(named: "Green")
        subtitleLabel.textAlignment = .left
        subtitleLabel.text = NSLocalizedString("Porsche 911w", comment:"")
        subtitleLabel.font = UIFont(name: "Inter-SemiBold", size: 12)

        
        let stackView = UIStackView(arrangedSubviews: [taskerName, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    
    
    @IBOutlet weak var imageViewCarorsal: ImageSlideshow!
    let localSource = [BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img2"), BundleImageSource(imageString: "img3"), BundleImageSource(imageString: "img4")]
    let pageIndicator = UIPageControl()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var numberOfLines:Int = 1
    
    @IBOutlet weak var uipageView: UIView!
    let pageControl2 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    var cardetailData:CarDetailModel?
    var sdWebImageSource = [SDWebImageSource]()

    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carTrim: UILabel!
    @IBOutlet weak var priceVsMarket: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in cardetailData?.data?.carDetails?.images ?? []{
            sdWebImageSource.append(SDWebImageSource(urlString: item.image_url ?? "")!)
        }
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        let title = UIBarButtonItem(customView: titleStackView)
        self.navigationItem.leftBarButtonItems = [setBackBtn(),title]
        self.navigationItem.leftBarButtonItem?.width = CGFloat(5)
       
        let img = resizedImage(at: UIImage(named: "sh")!, for: CGSize(width: 15, height: 15))
        let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnProfile.setImage(img, for: .normal)
        btnProfile.backgroundColor = UIColor(named: "AccentColor")
        btnProfile.layer.cornerRadius = 15.0
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(image: UIImage(named: "singleLayour"), landscapeImagePhone: UIImage(named: "singleLayour"), style: .plain, target: self, action: #selector(addTapped))]
            
        imageViewCarorsal.pageIndicator = nil
        imageViewCarorsal.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageViewCarorsal.activityIndicator = DefaultActivityIndicator()
        imageViewCarorsal.delegate = self
        imageViewCarorsal.setImageInputs(sdWebImageSource)

        
        imageCollectionView.register(UINib(nibName: "carDetailImages", bundle: nil), forCellWithReuseIdentifier: "carDetailImages")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        pageControl2.cornerRadius = 3;
        pageControl2.dotHeight = 6;
        pageControl2.dotSpace = 3;
        pageControl2.currentDotWidth = 18;
        pageControl2.otherDotWidth = 6;
        pageControl2.otherDotColor = .white
        pageControl2.currentDotColor = UIColor(named: "selectedBlackColor")
        
        
        
        pageControl2.numberOfPages = Int32(sdWebImageSource.count)
        uipageView.addSubview(pageControl2)
        pageControl2.center = CGPoint(x: uipageView.frame.width / 2, y: uipageView.frame.height / 2)
        addData()
    }
    
    @objc func share(){
        DispatchQueue.main.async {
            
           
                var link = "dev-microservices.horizonauto.com://"
                let activityController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                activityController.completionWithItemsHandler = {(nil, completed, _, error) in
                    if completed {
                        print("completed")
                    }else {
                        print("cancled")
                    }
                    
                }
                self.present(activityController, animated: true, completion: nil)

            
            
        }

    }
    
    func addData(){
        carModel.text = cardetailData?.data?.carDetails?.car_make?.make ?? "N/A"
        carTrim.text = cardetailData?.data?.carDetails?.trim_definition?.car_trim ?? "N/A"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.minimumFractionDigits = 0
        let ap = numberFormatter.string(from: NSNumber(value: cardetailData?.data?.priceVsMarket?.averagePrice ?? 0))
        if cardetailData?.data?.priceVsMarket?.direction == "decrease"{
            priceVsMarket.text = "\(ap ?? "N/A") Above"
            priceVsMarket.textColor = .red
        }else{
            priceVsMarket.text = "\(ap ?? "N/A") Below"
        }
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        pageControl2.currentPage = Int32(page)

    }
    
    func setBackBtn() -> UIBarButtonItem {
        
        backButton.frame = CGRect(x: 0, y: 100, width: 15, height: 15)
        let img = resizeImage(image: UIImage(named: "backButton")!, targetSize: CGSize(width: 25, height: 25))
        backButton.setImage(img, for: .normal)
        backButton.addTarget(self, action: #selector(popToHome), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let back = UIBarButtonItem(customView: backButton)
        
        return back
    }
    
    @objc func popToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addTapped(){
        if numberOfLines == 1 {
            numberOfLines = 2
            let img = resizedImage(at: UIImage(named: "sh")!, for: CGSize(width: 15, height: 15))
            let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btnProfile.setImage(img, for: .normal)
            btnProfile.backgroundColor = UIColor(named: "AccentColor")
            btnProfile.layer.cornerRadius = 15.0
            btnProfile.layer.masksToBounds = true
            btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
            self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(image: UIImage(named: "ColumnLayout2"), landscapeImagePhone: UIImage(named: "ColumnLayout2"), style: .plain, target: self, action: #selector(addTapped))]
        }else if numberOfLines == 2{
            numberOfLines = 3
            let img = resizedImage(at: UIImage(named: "sh")!, for: CGSize(width: 15, height: 15))
            let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btnProfile.setImage(img, for: .normal)
            btnProfile.backgroundColor = UIColor(named: "AccentColor")
            btnProfile.layer.cornerRadius = 15.0
            btnProfile.layer.masksToBounds = true
            btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
            self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(image: UIImage(named: "columnLayout"), landscapeImagePhone: UIImage(named: "columnLayout"), style: .plain, target: self, action: #selector(addTapped))]
        }else {
            numberOfLines = 1
            let img = resizedImage(at: UIImage(named: "sh")!, for: CGSize(width: 15, height: 15))
            let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btnProfile.setImage(img, for: .normal)
            btnProfile.backgroundColor = UIColor(named: "AccentColor")
            btnProfile.layer.cornerRadius = 15.0
            btnProfile.layer.masksToBounds = true
            btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
            self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(image: UIImage(named: "singleLayour"), landscapeImagePhone: UIImage(named: "singleLayour"), style: .plain, target: self, action: #selector(addTapped))]
        }
        imageCollectionView.reloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sdWebImageSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carDetailImages", for: indexPath) as! carDetailImages
        cell.vc = self
        cell.addImage(imageLink: sdWebImageSource[indexPath.row].url)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let cellSize = CGSize(width: Int(collectionView.bounds.width) / numberOfLines - 10 , height: 100)
        return cellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func resizedImage(at image: UIImage, for size: CGSize) -> UIImage? {
        let image = image

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

