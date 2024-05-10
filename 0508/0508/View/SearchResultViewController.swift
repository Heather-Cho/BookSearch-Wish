//
//  SearchResultViewController.swift
//  0508
//
//  Created by t2023-m0114 on 5/9/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var selectedBookTitle = UILabel()
    var selectedBookWriter = UILabel()
    var selectedBookThumbnail = UIImageView()
    var thumbnailURL: String? // url정보 받아올 변수
    var selectedBookPublisher = UILabel()
    var selectedBookPrice = UILabel()
    var selectedBookContents = UILabel()
    
    var xButton = UIButton()
    var addCartButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        configureUI()
        
        if let thumbnailURLString = thumbnailURL,
           let thumbnailURL = URL(string: thumbnailURLString) {
            loadImage(from: thumbnailURL)
        }
    }
    
    // MARK: - setupConstraints, addSubview, 오토레이아웃
    
    func setupConstraints() {
        [selectedBookTitle, selectedBookWriter, selectedBookPublisher, selectedBookThumbnail, selectedBookPrice, selectedBookContents, xButton, addCartButton].forEach {
            view.addSubview($0)
        }
        
        selectedBookTitle.snp.makeConstraints { make in
            make.top.equalTo(view).offset(30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(35)
        }
        
        selectedBookWriter.snp.makeConstraints { make in
            make.top.equalTo(selectedBookTitle.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        selectedBookPublisher.snp.makeConstraints { make in
            make.top.equalTo(selectedBookTitle.snp.bottom).offset(5)
            make.leading.equalTo(selectedBookWriter.snp.trailing).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        selectedBookThumbnail.snp.makeConstraints { make in
            make.top.equalTo(selectedBookWriter.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(250)
        }
        
        selectedBookPrice.snp.makeConstraints { make in
            make.top.equalTo(selectedBookThumbnail.snp.bottom).offset(5)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        selectedBookContents.snp.makeConstraints { make in
            make.top.equalTo(selectedBookPrice.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        xButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-40)
            make.leading.equalTo(view).offset(30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        addCartButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-40)
            make.trailing.equalTo(view).offset(-30)
            make.width.equalTo(260)
            make.height.equalTo(60)
        }
        
    }
    
    // MARK: - configureUI, 텍스트, 컬러 외
    
    func configureUI() {
//        
//        //영역잡느라 잡깐 쓰는 애들
//        selectedBookTitle.text = "Title테스트용, 이따가 주석처리해"
//        selectedBookWriter.text = "Writer테스트용"
//        selectedBookPublisher.text = "Publisher테스트용"
//        selectedBookPrice.text = "Price테스트용"
//        selectedBookContents.text = "Contents테스트용"
//        selectedBookTitle.backgroundColor = .brown
//        selectedBookWriter.backgroundColor = .brown
//        selectedBookPublisher.backgroundColor = .brown
//        selectedBookPrice.backgroundColor = .brown
//        selectedBookContents.backgroundColor = .brown
//        selectedBookThumbnail.backgroundColor = .black
//        
        //책 제목
        selectedBookTitle.textColor = .black
        selectedBookTitle.font = UIFont.systemFont(ofSize: 22)
        selectedBookTitle.textAlignment = .center
        selectedBookTitle.numberOfLines = 1
        selectedBookTitle.adjustsFontSizeToFitWidth = true
        selectedBookTitle.minimumScaleFactor = 0.8
        //작가
        selectedBookWriter.textColor = .black
        selectedBookWriter.font = UIFont.systemFont(ofSize: 15)
        selectedBookWriter.textAlignment = .center
        selectedBookWriter.numberOfLines = 1
        selectedBookWriter.adjustsFontSizeToFitWidth = true
        selectedBookWriter.minimumScaleFactor = 0.8
        //출판사
        selectedBookPublisher.textColor = .black
        selectedBookPublisher.font = UIFont.systemFont(ofSize: 15)
        selectedBookPublisher.textAlignment = .center
        selectedBookPublisher.numberOfLines = 1
        selectedBookPublisher.adjustsFontSizeToFitWidth = true
        selectedBookPublisher.minimumScaleFactor = 0.8
        //썸네일
        selectedBookThumbnail.contentMode = .scaleAspectFit
        //가격
        selectedBookPrice.textColor = .blue
        selectedBookPrice.font = UIFont.systemFont(ofSize: 18)
        selectedBookPrice.textAlignment = .center
        selectedBookPrice.numberOfLines = 1
        selectedBookPrice.adjustsFontSizeToFitWidth = true
        selectedBookPrice.minimumScaleFactor = 0.8
        //책설명
        selectedBookContents.textColor = .black
        selectedBookContents.font = UIFont.systemFont(ofSize: 15)
        selectedBookContents.numberOfLines = 0
        selectedBookContents.lineBreakMode = .byWordWrapping
        //닫기버튼
        xButton.setTitle("X", for: .normal)
        xButton.setTitleColor(.white, for: .normal)
        xButton.backgroundColor = .blue
        xButton.layer.cornerRadius = 25
        xButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        //addCartButton
        addCartButton.setTitle("담기", for: .normal)
        addCartButton.setTitleColor(.white, for: .normal)
        addCartButton.backgroundColor = .blue
        addCartButton.layer.cornerRadius = 25
    }
    
    // URL에서 이미지 로드하여 이미지 뷰에 표시하는 함수
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image:", error)
                return
            }
            guard let data = data else {
                print("No image data")
                return
            }
            // 데이터를 UIImage로 변환하여 이미지 뷰에 설정
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.selectedBookThumbnail.image = image
                }
            }
        }.resume()
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}




// MARK: - 미리보기, 업데이트 : command + option +. p

#Preview {
    SearchResultViewController()
}
