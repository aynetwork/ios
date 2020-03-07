//
//  Model.swift
//  CurrencyProject
//
//  Created by GPM IMac on 13.02.2020.
//  Copyright © 2020 GPM IMac. All rights reserved.
//

import UIKit

class Currency {
    var NumCode: String?
    var CharCode: String?
    var Nominal: String?
    var Name: String?
    var Value: String?
    var valueDouble: Double?
    var nominalDouble: Double?
}

class Model: NSObject, XMLParserDelegate {
    static let shared = Model()
    var currencies: [Currency] = []
    var currentDate: String = ""
    
    
    var pathForXML: String {
        
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
        
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
        
        return Bundle.main.path(forResource: "data", ofType: "xml")!
        
    }
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    
    //функция XML с cbr.ru и сохранение в каталоге приложений
    func loadXMLFile(date: Date?) {
        
        
        
        var strUrl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            strUrl = strUrl + dateFormatter.string(from: date!)
        }
        
        let url = URL(string : strUrl)

        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                               FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
                let urlForSAve = URL(fileURLWithPath: path)
                do {
                    try data?.write(to: urlForSAve)
                    
                    print("File loaded")
                    
                    self.parseXML()
                } catch {
                    print("Error when save data : \(error.localizedDescription)")
                }
            } else {
                print("error" + error!.localizedDescription)
            }
        }
        task.resume()
    }
    
    //распарсить xml и положить его в currencies
    func parseXML() {
        currencies = []
        let parser = XMLParser(contentsOf: urlForXML)
        print(urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        
       // print(currencies)
    }
    
    
    var currentCurrency : Currency?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"] {
                currentDate = currentDateString
            }
        }
        
        if elementName == "Valute" {
            currentCurrency = Currency()
        }
        
        if elementName == "CharCode" {
            currentCurrency?.NumCode = currentCharacters
        }
        
        
        if elementName == "Nominal" {
            currentCurrency?.Nominal = currentCharacters
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        
        
        if elementName == "Value" {
            currentCurrency?.Value = currentCharacters
            currentCurrency?.valueDouble = Double(currentCharacters)
        }
        
        if elementName == "Name" {
            currentCurrency?.Name = currentCharacters
        }
      
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Value" {
            currencies.append(currentCurrency!)
        }
        
        
        
    }
    
    var currentCharacters: String = ""
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }
    
    
}
