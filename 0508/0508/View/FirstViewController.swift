//
//  ViewController.swift
//  0508
//
//  Created by t2023-m0114 on 5/8/24.
//

import UIKit
import SnapKit

class FirstViewController: UITabBarController {
    
    
    //1영역 : 서치바
    let searchBar = UISearchBar()
    
    
    //2영역 : 검색결과: searchResult View
    
    let searchResultView = UIView()
    let searchResultTitle = UILabel()
    
    let searchResultTableView = UITableView()
    let apiManager = APIManager()
    
    var searchResults = [Document]()
    
    
    //3영역 : 최근 본 책
    let recentBookTitleLabel = UILabel()
    let recentBookView = UIStackView()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configureUI()
        
        view.backgroundColor = .white
        
        searchBar.delegate = self
        
        
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
        searchResultTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        
        
    }
    
    // MARK: - setupConstraints, addSubview, 오토레이아웃
    
    func setupConstraints() {
        [searchBar, searchResultView, searchResultTitle, searchResultTableView, recentBookView, recentBookTitleLabel].forEach {
            view.addSubview($0)
        }
        
        //1영역
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(60)
        }
        
        //2영역
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(searchBar)
            make.trailing.equalTo(searchBar)
            make.height.equalTo(250)
        }
        
        searchResultTitle.snp.makeConstraints { make in
            make.top.equalTo(searchResultView.snp.top).offset(10)
            make.leading.equalTo(searchBar).offset(10)
            make.trailing.equalTo(searchBar).offset(-10)
            make.height.equalTo(25)
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchResultTitle.snp.bottom).offset(10)
            make.leading.equalTo(searchBar)
            make.trailing.equalTo(searchBar)
            make.height.equalTo(200)
        }
        
        
        
        
        //3영역
        recentBookView.snp.makeConstraints { make in
            make.top.equalTo(searchResultView.snp.bottom).offset(10)
            make.leading.equalTo(searchBar)
            make.trailing.equalTo(searchBar)
            make.height.equalTo(180)
        }
        
        recentBookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(recentBookView).offset(10)
            make.leading.equalTo(searchBar).offset(10)
            make.trailing.equalTo(searchBar).offset(-10)
            make.height.equalTo(25)
        }
        
        
    }
    
    
    
    
    // MARK: - configureUI, 텍스트, 컬러 외
    
    func configureUI() {
        
        //1영역
        searchBar.placeholder = "검색어를 입력하세요 여기다가."
        
        
        //2영역
        searchResultTitle.text = "검색결과"
        searchResultTitle.textColor = .blue
        
        
        searchResultView.isHidden = true
        searchResultTitle.isHidden = true
        searchResultTableView.isHidden = true
        
        
        //3영역
        //recentBookView.backgroundColor = .black
        recentBookTitleLabel.text = "최근에 본 책"
        recentBookTitleLabel.textColor = .blue
        
        recentBookView.isHidden = true
        recentBookTitleLabel.isHidden = true
        
    }
    
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(searchResults.count, 10) //최대 10개의 검색결과만 리턴해라
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 특정 인덱스 패스에 해당하는 셀을 반환합니다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        
        let document = searchResults[indexPath.row]
        cell.searchResultTitleLabel.text = document.title
        cell.searchResultWriterLabel.text = document.authors.first ?? "Unknown Author"
        cell.searchResultPriceLabel.text = "\(document.price)원"
        
        return cell
    }
}


extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let selectedBook = searchResults[indexPath.row]

            let SearchResultVC = SearchResultViewController()

            // 선택된 책 정보 새로운 뷰 컨트롤러로 전달
        SearchResultVC.selectedBookTitle.text = selectedBook.title
        SearchResultVC.selectedBookWriter.text = selectedBook.authors.first
        SearchResultVC.selectedBookPrice.text = "\(selectedBook.price)원"
        SearchResultVC.selectedBookPublisher.text = selectedBook.publisher
        SearchResultVC.selectedBookContents.text = selectedBook.contents
        
        SearchResultVC.thumbnailURL = selectedBook.thumbnail

        present(SearchResultVC, animated: true, completion: nil)
        }
}





extension FirstViewController: UISearchBarDelegate {
    
    private func dismissKeyboard() {searchBar.resignFirstResponder()
        // "너가 첫 번째 리스폰더가 아니니 사임해라" 라는 의마라고 함
        // 첫 응답이 키보드가 올라오는 것인데,이를 관두면 키보드는 자동으로 내려가게 됨.
    }
    
    
    //서치 버튼 클릭했을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 히든 해제해라
        searchResultView.isHidden = false
        searchResultTitle.isHidden = false
        searchResultTableView.isHidden = false
        recentBookView.isHidden = false
        recentBookTitleLabel.isHidden = false
        
        dismissKeyboard() // 키보드 내려라

        guard let searchText = searchBar.text, searchText.isEmpty == false else { return }
        apiManager.fetchqueryAPI(with: searchText) { result in
            switch result {
            case .success(let bookInfo):
                // 성공적으로 BookInfo를 받아온 경우
                print("😺😺😺", "Received BookInfo: \(bookInfo)")
                
                //배열의 내용을 검색결과로 바꿔라
                self.searchResults = bookInfo.documents
                
                //테이블뷰를 업데이트해라
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
                                
                
            case .failure(let error):
                // API 요청이 실패한 경우
                print("👹👹👹", "Error fetching BookInfo: \(error)")
            }
        }
    }
}



// MARK: - 미리보기, 업데이트 : command + option +. p

#Preview {
    FirstViewController()
}


