//
//  SearchResultTableViewCell.swift
//  0508
//
//  Created by t2023-m0114 on 5/9/24.
//

import UIKit
import SnapKit

class SearchResultTableViewCell: UITableViewCell {
    
    
    let searchResultTitleLabel = UILabel()
    let searchResultWriterLabel = UILabel()
    let searchResultPriceLabel = UILabel()
    
    
    
    static let identifier = "SearchResultTableViewCell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //backgroundColor = .gray
        
        [searchResultTitleLabel, searchResultWriterLabel, searchResultPriceLabel].forEach {
            contentView.addSubview($0)
        }
        
        searchResultTitleLabel.font = UIFont.systemFont(ofSize: 16)
        searchResultTitleLabel.text = "책 이름"
        searchResultTitleLabel.textColor = .black
        searchResultTitleLabel.backgroundColor = .white
        searchResultTitleLabel.adjustsFontSizeToFitWidth = true // 텍스트 크기를 자동으로 조정하도록 설정
        searchResultTitleLabel.minimumScaleFactor = 0.8 // 텍스트가 축소되는 최소비율
        
        searchResultTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(210)
            make.height.equalTo(30)
        }
        
        
        searchResultWriterLabel.font = UIFont.systemFont(ofSize: 14)
        searchResultWriterLabel.text = "작가 이름"
        searchResultWriterLabel.textColor = .black
        searchResultWriterLabel.backgroundColor = .white
        searchResultWriterLabel.adjustsFontSizeToFitWidth = true
        searchResultWriterLabel.minimumScaleFactor = 0.8

        searchResultWriterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalTo(searchResultTitleLabel.snp.trailing).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        searchResultPriceLabel.font = UIFont.systemFont(ofSize: 13)
        searchResultPriceLabel.text = "책 가격"
        searchResultPriceLabel.textColor = .black
        searchResultPriceLabel.backgroundColor = .white
        
        searchResultPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalTo(searchResultWriterLabel.snp.trailing).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



// MARK: - 미리보기, 업데이트 : command + option +. p

#Preview {
    SearchResultTableViewCell()
}
