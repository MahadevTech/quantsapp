//
//  CategoriesCVC.swift
//  Quantsapp
//
//  Created by Mahadev on 07/12/21.
//

import UIKit



class CategoriesCVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    

    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewL: UIView!

    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var viewSC: UIView!
    @IBOutlet weak var viewS: UIView!
    @IBOutlet weak var viewLU: UIView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    var webRes : [model_categoryRootClass] = []
    var cellData:[getcatDataStruct] = []
    var resp:[String:String] = [:]
    var l  : [String] = []
    var lu : [String] = []
    var s  : [String] = []
    var sc : [String] = []
    
    let _vm_category = vm_category()
    var res_symbol : [String] = []
    var lSymbols : [String] = []
    var lprc : [String] = []
    var lperchange : [String] = []
    var color : [String] = []
    var allData : [String:[Any]] = [:]
    var totaldata : [String] = []
    var selectedBgColor = ""
    var prodArray:NSMutableArray = NSMutableArray()
    var mainResp : [getcatDataStruct] = []
    var searchTempData : [getcatDataStruct] = []
    
    var lbl : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        searchView.delegate = self
        callCategory()
        design()
    
    
    }

    func callCategory(){
        _vm_category.getCategoryData{ [self](data,error) in
            if (error == ""){
                self.webRes.append(data!)
                lbl.text = ""
                btnAllAct(self)
            
            }
            else{
                lbl.text = cfg.no_data
            }
        }
    }
   
    func design(){
        viewL.layer.cornerRadius = 15
        viewAll.layer.cornerRadius = 15
        viewLU.layer.cornerRadius = 15
        viewSC.layer.cornerRadius = 15
        viewS.layer.cornerRadius = 15
        searchView.searchTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        lbl.text = cfg.loading
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredData:[getcatDataStruct] = []
       
               if searchText.isEmpty == false {
                   filteredData = searchTempData.filter({ $0.symbol.uppercased().contains(searchText.uppercased()) })
               }else{
                   if searchTempData.count != 0{
                       filteredData = searchTempData
                   }
               }
                 cellData = filteredData
        self.categoryCollection.reloadData()
    }

    
    
    func map(){
        mainResp = []
        for product in totaldata{
            let val = product.components(separatedBy: ",")
            let prod: NSMutableDictionary = NSMutableDictionary()
            prod.setValue(val[0], forKey: "symbol")
            prod.setValue(val[1], forKey: "price")
            prod.setValue(val[2], forKey: "open_intrest")
            prod.setValue(val[3], forKey: "price_change_per")
            prod.setValue(val[4], forKey: "open_intrest_per")
            prod.setValue(val[5], forKey: "color")
            prodArray.add(prod)
        }
        let arr = prodArray as [AnyObject]
        for val in arr{
            let allresp = getcatDataStruct(symbol: val["symbol"] as! String, price: val["price"] as! String, open_intrest: val["open_intrest"] as! String, price_change_per: val["price_change_per"] as! String, open_intrest_per: val["open_intrest_per"] as! String, color: val["color"] as! String)
            mainResp.append(allresp)
        }
        print(mainResp)
        let sortArray = mainResp.sorted{ Double($0.price_change_per)! > Double($1.price_change_per)! }
 
        let temp = sortArray
        mainResp = temp
        cellData = mainResp
        searchTempData = cellData

        }
 
    
    func getAll(){
        l  = webRes[0].l?.components(separatedBy: ";") ?? []
        l = setColor(l, ",G")
        lu = webRes[0].lu?.components(separatedBy: ";") ?? []
        lu = setColor(lu, ",B")
        s = webRes[0].s?.components(separatedBy: ";") ?? []
        s = setColor(s, ",R")
        sc  = webRes[0].sc?.components(separatedBy: ";") ?? []
        sc = setColor(sc, ",Y")
        totaldata.append(contentsOf: l)
        totaldata.append(contentsOf: lu)
        totaldata.append(contentsOf: s)
        totaldata.append(contentsOf: sc)
        map()
        self.categoryCollection.reloadData()

    }
    
    func setColor(_ data:[String],_ col:String) -> [String]{
        var temp = data
        for i in 0..<temp.count{
            temp[i].append(col)
        }
        return temp
    }
    
    var twoDeci: String{
        return String(format:"%.2f",self)
    }
    @IBAction func btnAllAct(_ sender: Any) {
        if mainResp.count == 0 {
            getAll()
        }else{
            cellData = mainResp
            searchTempData = cellData
            self.categoryCollection.reloadData()
        }
    }
    
    func filterData(_ data:[getcatDataStruct],_ txt: String){
        let fildt = data.filter{$0.color.uppercased() == txt}
        cellData = fildt
        searchTempData = cellData
        self.categoryCollection.reloadData()
    }
    @IBAction func btnLAct(_ sender: Any) {

        filterData(mainResp,"G")

    }

    @IBAction func btnSCAct(_ sender: Any) {

        filterData(mainResp,"Y")

    }

    @IBAction func btnSAct(_ sender: Any) {

        filterData(mainResp,"R")
 
    }
    @IBAction func btnLU(_ sender: Any) {

        filterData(mainResp,"B")
     
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellData.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/4
        let cells = floor(collectionView.frame.width/width)
        let wd = collectionView.frame.width/cells
        return CGSize(width: wd, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : Categoriescell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! Categoriescell
        cell.populatedata(cellData[indexPath.row])
        let dt = cellData[indexPath.row]
        if dt.color == "G"{
            cell.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
        else if dt.color == "R"{
            cell.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        else if dt.color == "B"{
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.9764705882, alpha: 1)
            
        }
        else if dt.color == "Y"{
            cell.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            
        }
        return cell
        
    }
    
}
class Categoriescell: UICollectionViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblsymbol: UILabel!
    @IBOutlet weak var lblperChng: UILabel!
    @IBOutlet weak var viewImg: UIView!
    
    override func awakeFromNib() {
        viewImg.layer.cornerRadius = 6
        viewImg.layer.borderWidth = 1
        viewImg.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func populatedata(_ data: getcatDataStruct){
        lblsymbol.text = data.symbol
        let pchng = Double(data.price_change_per) ?? 0.0
        let pc = pchng * 100
        lblperChng.text = "\(pc.roundToDecimal(2))%"
    }

}
extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}


extension CategoriesCVC{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//           return CGSize(width: self.categoryCollection.bounds.width, height: self.categoryCollection.bounds.height)
//       }
//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
