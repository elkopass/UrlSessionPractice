//
//  ViewController.swift
//  UrlSessionPractise
//
//  Created by Веретнов Тимофей on 25.05.2023.
//

import UIKit
import Alamofire

struct TokenResponse: Codable {
	let accessToken: String
	let accessTokenExpiresIn: String
	let refreshToken: String
	let refreshTokenExpiresIn: String
}
struct Profile: Codable {
	let id: String
	let fullName: String
	let login: String
	let roles: [String]
}

struct AuthTokenData: Codable {
	let tokens: TokenResponse
	let profile: Profile
}

class ViewController: UIViewController {
	
	@IBAction func loginTap(_ sender: Any) {
		AlamRequest()
		
	}
	
	@IBAction func createAccount(_ sender: Any) {
		AF.request("http://localhost:8800/api/v1/auth/register", method: .post, parameters: [
			"firstName": "Haidar",
			"lastName": "Daukaev",
			"patronymic": "Aliakbarovich",
			"role": "EMPLOYEE"
		], encoding: JSONEncoding.default, headers: ["Authorization" : "Bearer " + UserSettings.api_token]).responseData { response in
			switch response.result {
			case .success(let data):
				if (response.response?.statusCode == 200){
					
					let results: AuthTokenData = try! JSONDecoder().decode(AuthTokenData.self, from: data)
					print(results)
					
				}
				else {
					var dialogMessage = UIAlertController(title: "Confirm", message: "User with such login does not exist", preferredStyle: .alert)
					let ok =  UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
						print("Ok button tapped")
					})
					
					dialogMessage.addAction(ok)
					
					self.present(dialogMessage, animated: true, completion: nil)
				}
			case .failure(let error):
				print(error.errorDescription)
				
				var dialogMessage = UIAlertController(title: "Confirm", message: error.errorDescription, preferredStyle: .alert)
				let ok =  UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
					print("Ok button tapped")
				})
				
				dialogMessage.addAction(ok)
				
				self.present(dialogMessage, animated: true, completion: nil)
			}
		}
	}
	
	@IBOutlet weak var loginTapped: UIButton!
	
	@IBOutlet weak var textField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	func AlamRequest() {
		AF.request("http://localhost:8800/api/v1/auth/login", method: .post, parameters: ["login": textField.text], encoding: JSONEncoding.default).responseData { response in
			switch response.result {
			case .success(let data):
				if (response.response?.statusCode == 200){
					
					let results: AuthTokenData = try! JSONDecoder().decode(AuthTokenData.self, from: data)
					print(results)
					UserSettings.api_token = results.tokens.accessToken
					
				}
				else {
					var dialogMessage = UIAlertController(title: "Confirm", message: "User with such login does not exist", preferredStyle: .alert)
					let ok =  UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
						print("Ok button tapped")
					})
					
					dialogMessage.addAction(ok)
					
					self.present(dialogMessage, animated: true, completion: nil)
				}
			case .failure(let error):
				print(error.errorDescription)
				
				var dialogMessage = UIAlertController(title: "Confirm", message: error.errorDescription, preferredStyle: .alert)
				let ok =  UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
					print("Ok button tapped")
				})
				
				dialogMessage.addAction(ok)
				
				self.present(dialogMessage, animated: true, completion: nil)
			}
		}
	}
}

