struct UserAuthResponse: Decodable {
    let expires: Int
    let refreshToken: String
    let accesToken: String
}
