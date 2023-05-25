//
//  UserSettings.swift
//  UrlSessionPractise
//
//  Created by Веретнов Тимофей on 25.05.2023.
//

import Foundation


final class UserSettings {
	private enum SettingsKeys: String {
		case api_token
	}
	
	static var api_token: String! {
		get{
			return UserDefaults.standard.string(forKey: SettingsKeys.api_token.rawValue)
		}
		set{
			let defaults = UserDefaults.standard
			let key = SettingsKeys.api_token.rawValue
			if let token = newValue {
				defaults.set(token, forKey: key)
			} else {
				defaults.removeObject(forKey: key)
			}
		}
	
	}
}
