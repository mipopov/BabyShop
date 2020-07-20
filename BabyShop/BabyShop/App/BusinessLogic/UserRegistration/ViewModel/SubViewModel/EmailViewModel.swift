protocol EmailViewModelProtocol {
    func checkField(email: String) -> Bool
    var email: String { get set }
}

class EmailViewModel: EmailViewModelProtocol {
    var email: String = ""

    func checkField(email: String) -> Bool {
        self.email = email
        return email.contains("@") && email.contains(".")  && email.count > 4
    }
}
