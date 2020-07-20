protocol PhoneViewModelProtocol {
    func checkPhoneNumber(with phone: String) -> Bool
    var phoneNumber: String { get set }
}
class PhoneViewModel: PhoneViewModelProtocol {
    var phoneNumber: String = ""

    func checkPhoneNumber(with phone: String) -> Bool {
        phoneNumber = phone
        return phone.count == 11 && phone.contains("8")
    }
}
