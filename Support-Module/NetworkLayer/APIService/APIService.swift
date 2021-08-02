
import Foundation


protocol WebServiceDelegate{
    func getResponse(result:Data)
    func getErrorResponse(error:NSString)
}

class WebService: NSObject {

    var delegate:WebServiceDelegate?

    func APICall( _ url:String, _ method : HTTPMETHOD, _ param: [String:Any]?){
        if Reachability.isConnectedToNetwork(){
            let request = NSMutableURLRequest(url: NSURL(string:url)! as URL)
            let session = URLSession.shared
            request.httpMethod = method.rawValue
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                guard data != nil else {
                    print("no data found: \(String(describing: error))")
                    return
                }
                do {
                    self.delegate?.getResponse(result: data!)
                } catch let parseError {
                    print(parseError)// Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    self.delegate?.getErrorResponse(error: jsonStr!)
                }
            }
            task.resume()
        }else{
            self.delegate?.getErrorResponse(error: kInternetConnectionMsg as NSString)
        }
    }
}
