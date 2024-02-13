import UIKit

var greeting = "Hello, playground"

var temp = Date(timeIntervalSince1970: 1707836400)
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy.MM.dd hh.mm.ss"
dateFormatter.locale = Locale(identifier: "ko-KR")
dateFormatter.string(from: temp)
