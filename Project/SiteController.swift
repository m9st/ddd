//
//  SiteController.swift
//  Project
//
//  Created by HotCode on 23.01.17.
//  Copyright © 2017 HotCode. All rights reserved.
//

import UIKit


class SiteController: UIViewController, XMLParserDelegate {
    
    let url =  URL(string: "http://static.feed.rbc.ru/rbc/logical/footer/news.rss")
    
    var elementTitle: String!
    var element: Element?
    var elements = [Element]()
    
    @IBAction func pickAction(_ sender: UIButton) {
            let xmlWithRssData = XMLParser(contentsOf: url!)
            xmlWithRssData?.delegate = self
            xmlWithRssData?.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            element = Element()
        }
        elementTitle = elementName
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !string.contains("\n") {
            switch elementTitle {
            case "title":
                element?.title = string
            case "link":
                element?.link = string
            case "pubDate":
                let formatter = DateFormatter()
                formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                element?.date = formatter.date(from: string)
            default:
                return
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(element!)
            element = nil
        }
    }
}

class Element: NSObject {
    var date: Date!
    var title: String!
    var link: String!
}
