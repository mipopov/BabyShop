protocol PasswordViewModelProtocol {
    func checkPasswords(with password: String, and confirmPas: String) -> Bool
    var password: String { get set }
}

class PasswordViewModel: PasswordViewModelProtocol {
    var password: String = ""

    func checkPasswords(with password: String, and confirmPas: String) -> Bool {
        self.password = password
        return password == confirmPas && password.count > 0 && confirmPas.count > 0
    }

}
