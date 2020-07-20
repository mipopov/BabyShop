protocol FullNameViewModelProtocol {
    func checkUserName(with name: String) -> Bool
    func checkSurname(with surname: String) -> Bool
    var name: String { get set }
    var surName: String { get set}
}

class FullNameViewModel: UIControl, FullNameViewModelProtocol {
    var name: String = ""
    var surName: String = ""

    func checkUserName(with name: String) -> Bool {
        self.name = name
        return name.count > 0
    }
    
    func checkSurname(with surname: String) -> Bool {
        self.surName = surname
        return surName.count > 0
    }

}
