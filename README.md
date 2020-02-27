# MVVMAPICALL

Post call using Urlsession


let url = URL(string: "http:sdfcewrtvervtr.com")!
var request = URLRequest(url: url)
request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
request.httpMethod = "POST"
let parameters: [String: Any] = [
    "id": 45,
    "name": "ios"
]
request.httpBody = parameters.percentEncoded()

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, 
        let response = response as? HTTPURLResponse, 
        error == nil else {                                              // check for fundamental networking error
        print("error", error ?? "Unknown error")
        return
    }

    guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
        print("statusCode should be 2xx, but is \(response.statusCode)")
        print("response = \(response)")
        return
    }

    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(responseString)")
}

task.resume()




// params setter

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet { 
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
