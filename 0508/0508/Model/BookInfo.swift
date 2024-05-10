//
//  File.swift
//  0508
//
//  Created by t2023-m0114 on 5/8/24.
//

import Foundation

// json데이터를 쉽게 object로 파싱(decode)하기 위해 Codable을 사용한다.
struct BookInfo: Codable {
    let documents: [Document]
}

struct Document: Codable {

    let title: String // 도서 제목
    let contents: String // 도서 소개
    let url: String // 도서 상세 URL
    let authors: [String] // 도서 저자 리스트
    let publisher: String // 도서 출판사
    let price: Int // 정가
    //let salePrice: Int // 판매가
    let thumbnail: String // 표지 미리보기 URL
    
    enum CodingKeys: String, CodingKey {
        case title, contents, url, authors, publisher, price, thumbnail
        //case salePrice = "sale_price" // API에서는 sale_price로 오는 속성을 salePrice로 매핑
    }
}



