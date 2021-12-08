//
//  model_categoryRootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 30, 2021

import Foundation

struct model_categoryRootClass : Codable {

        let l : String?
        let lu : String?
        let s : String?
        let sc : String?
    var cellColor: String = ""

        enum CodingKeys: String, CodingKey {
                case l = "l"
                case lu = "lu"
                case s = "s"
                case sc = "sc"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                l = try values.decodeIfPresent(String.self, forKey: .l)
                lu = try values.decodeIfPresent(String.self, forKey: .lu)
                s = try values.decodeIfPresent(String.self, forKey: .s)
                sc = try values.decodeIfPresent(String.self, forKey: .sc)
        }

}

struct model_getcat : Codable {
  
    
    var symbol : String = ""
    var price : String = ""
    var open_intrest : String = ""
    var price_change_per : String = ""
    var open_intrest_per : String = ""
    var color : String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case price = "price"
        case open_intrest = "open_intrest"
        case price_change_per = "price_change_per"
        case open_intrest_per = "open_intrest_per"
        case color = "color"
     
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = String(try values.decodeIfPresent(dataGeneric.self, forKey: .symbol)?.values ?? "")
        price = String(try values.decodeIfPresent(dataGeneric.self, forKey: .price)?.values ?? "")
        open_intrest = String(try values.decodeIfPresent(dataGeneric.self, forKey: .open_intrest)?.values ?? "")
        price_change_per = String(try values.decodeIfPresent(dataGeneric.self, forKey: .price_change_per)?.values ?? "") 
        open_intrest_per = String(try values.decodeIfPresent(dataGeneric.self, forKey: .open_intrest_per)?.values ?? "") 
        color = try values.decodeIfPresent(dataGeneric.self, forKey: .color)?.values ?? ""
       
    }
    
}

struct dataGeneric: Decodable{
    
    var values: String = ""
    
    init(from decoder: Decoder) throws {
        var dataofInt: Int = 0
        var dataofDOuble: Double = 0.0
        var dataofString: String = ""
        var dataofBool: Bool = false
        
        let container = try decoder.singleValueContainer()
        do{
            dataofInt = try container.decode(Int.self)
            values = String(dataofInt)
        }
        catch{
            do{
                dataofDOuble = try container.decode(Double.self)
                values = String(dataofDOuble)
            }
            catch{
                do{
                    dataofString = try container.decode(String .self)
                    values = dataofString
                }
                catch{
                    do{
                        dataofBool = try container.decode(Bool .self)
                        values = String(dataofBool)
                    }
                    catch{
                        values = ""
                    }
                }
            }
        }
    }
}
struct getcatDataStruct{
  
    
    var symbol : String = ""
    var price : String = ""
    var open_intrest : String = ""
    var price_change_per : String = ""
    var open_intrest_per : String = ""
    var color : String = ""
}

