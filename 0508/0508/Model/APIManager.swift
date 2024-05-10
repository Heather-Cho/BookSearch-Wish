//
//  APIManager.swift
//  0508
//
//  Created by t2023-m0114 on 5/9/24.
//

import Foundation

class APIManager {
    //검색기능 구현하기
    func fetchqueryAPI(with searchText: String, completion: @escaping (Result<BookInfo, Error>) -> Void) {
        
        //특정 문자 집합에 속하지 않는 문자들을 퍼센트 인코딩하여 반환
        guard let encodedQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?target=title") else { return } //여기
        
        //URL Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.url?.append(queryItems: [URLQueryItem(name: "query", value: searchText)]) //여기
        urlRequest.allHTTPHeaderFields = ["Authorization": "KakaoAK ca10c1402a391b56fea23def7c153e9c"] // api 키 넣음
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        let error = NSError(domain: "APIManagerError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                        completion(.failure(error))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let bookInfo = try decoder.decode(BookInfo.self, from: data)
                        completion(.success(bookInfo))
                    } catch {
                        completion(.failure(error))
                    }
                }
                .resume()
            }
}
