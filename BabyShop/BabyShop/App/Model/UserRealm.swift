import RealmSwift

class UserRealm: Object {
    @objc dynamic var userName = ""
    @objc dynamic var userSurname = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var expires = 0
    @objc dynamic var refreshToken = ""
    @objc dynamic var accesToken = ""

    convenience init(userName: String, surname: String,
                     email: String, password: String, phone: String,
                     expires: Int, refreshTok: String, accesTok: String) {
        self.init()
        self.userName = userName
        self.userSurname = surname
        self.email = email
        self.password = password
        self.phoneNumber = phone
        self.expires = expires
        self.refreshToken = refreshTok
        self.accesToken = accesTok
    }

    override class func primaryKey() -> String? {
        return "email"
    }
}
