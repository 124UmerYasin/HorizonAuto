//
//  UserModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/02/2023.
//

import Foundation
import JWTDecode

struct User {
    let id: String
    let email: String
    let picture: String
    let name: String

}

extension User {
    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let email = jwt["email"].string,
              let picture = jwt["picture"].string,
              let name = jwt["name"].string

        else { return nil }
        self.id = id
        self.email = email
        self.picture = picture
        self.name = name

    }
}
