//
//  APIClient.swift
//  Locket
//
//  Created by Гусейн Римиханов on 19.11.2024.
//

import Foundation

/*
 
 {
   "userId": 1,
   "id": 1,
   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 }
 
 */
struct PostItemResponseElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias PostItemResponse = [PostItemResponseElement]

class APIClient {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    
    func test() async throws {
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "GET"
        let (data,response) = try await session.data(for: request)
        
        let posts: PostItemResponse = try decoder.decode(PostItemResponse.self, from: data)
        
       
        print(posts)
        print("dsaasdasdasd")
        
    }
    
    init() {
        self.session = URLSession(configuration: .default)
        self.decoder = JSONDecoder()
    }
    
    
}
