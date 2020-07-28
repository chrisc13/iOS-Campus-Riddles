//
//  WebSession.swift
//  Campus Riddles
//
//  Created by Chris Carbajal on 7/27/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//
//
import Foundation

enum RiddleError: Error{
    case noData
    case canNotProcessData
}

class WebSession{
    
    
    //method: GET riddles
    static func getRiddles(completion: @escaping(Result <[Riddle], RiddleError >)  -> Void){
        let riddlesUrl = "http://localhost:8080/api/Riddles"
        guard let url = URL(string: riddlesUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for errors
            //check response 200 OK
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do{
                let riddles = try JSONDecoder().decode([Riddle].self, from: data)
                completion(.success(riddles))
                
            }catch let jsonErr{
                print("Error serializing JSON", jsonErr)
                completion(.failure(.canNotProcessData))
            }
                
            
        }.resume()
        
    }
}
