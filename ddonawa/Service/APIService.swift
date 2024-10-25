//
//  APIService.swift
//  ddonawa
//
//  Created by 강한결 on 6/30/24.
//

import Foundation

final class APIService {
   private init() {}
   
   static let manager = APIService()
   
   deinit {
      print("deinit?")
   }
   
   enum SortType: String, CaseIterable {
      case sim = "sim"
      case date = "date"
      case asc = "asc"
      case dsc = "dsc"
   }
   
   enum Errors: Error {
      case notFound
      case badRequest
      case responseError
   }
   
   struct APIInputType {
      var query: String
      var start: Int = 1
      var sort: SortType = .sim
   }
   
   private func genEndpoint(query: String, start: Int, sort: SortType.RawValue) -> URL {
      var components = URLComponents()
      components.scheme = SCHEME
      components.host = HOST
      components.path = PATH
      components.queryItems = [
         URLQueryItem(name: "display", value: "10"),
         URLQueryItem(name: "query", value: query),
         URLQueryItem(name: "start", value: String(start)),
         URLQueryItem(name: "sort", value: sort)
      ]
      
      return components.url!
   }
   
   private func genRequest(_ url: URL) -> URLRequest {
      var request = URLRequest(url: url)
      
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = [HEADERS_KEY_ID:HEADERS_VALUE_ID, HEADERS_KEY_SECRET: HEADERS_VALUE_SECRET]
      
      return request
   }
   
   func fetch<T: Decodable>(query: String, start:Int = 1, sort: SortType = .sim, handler: @escaping (T?, Errors?) -> ()) {
      let request = self.genRequest(self.genEndpoint(query: query, start: start, sort: sort.rawValue))
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard error == nil else {
            handler(nil, .badRequest)
            return;
         }
         
         guard let data else {
            handler(nil, .notFound)
            return;
         }
         
         do {
            let data = try JSONDecoder().decode(T.self, from: data)
            handler(data, nil)
         } catch {
            handler(nil, .responseError)
         }
      }.resume()
   }
   
   func fetch<D: Decodable>(_ input: APIInputType, of: D.Type) async throws -> D {
      let (data, response) = try await URLSession.shared.data(
         for: genRequest(
            genEndpoint(query: input.query, start: input.start, sort: input.sort.rawValue)
         )
      )
      
      if let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) {
         do {
            return try JSONDecoder().decode(D.self, from: data)
         } catch {
            throw Errors.notFound
         }
      }
      
      throw Errors.responseError
   }
}

