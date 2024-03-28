//
//  DetailViewControlelrViewController.swift
//  Receipies
//
//  Created by Apple on 27/03/24.
//

import UIKit

class DetailViewControlelrViewController: UIViewController {
    @IBOutlet weak var mealIngredeents: UILabel!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    lazy var apiManger = APIManager()
    let progressHUD = ProgressHUD(text: "Loading  Data")
    var meal:Meals?
    var mealDetail:MealDetail?
    var responseData = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(progressHUD)
        self.navigationController?.title = meal?.strMeal
        self.mealDetailApi()
        
    }
    //API call
    func mealDetailApi(){
        self.progressHUD.show()
        apiManger.mealsDetailAPICall(mealID: (meal?.idMeal)!, completion:  { data in
            if let response = data{
                do{
                    self.responseData = try! JSONSerialization.jsonObject(with: response,options: []) as! [String : Any]
                    let mealsDetailModel = try JSONDecoder().decode(MealDetailModel.self, from: response)
                    DispatchQueue.main.async {
                        self.mealDetail = mealsDetailModel.meals?.first
                        self.loadUI()
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        })
      }
    //Load UI
    func loadUI(){
        self.mealTitle.text = mealDetail?.strMeal
        self.instructions.text = mealDetail?.strInstructions
        if mealDetail?.strMealThumb != "" || mealDetail?.strMealThumb != nil{
            self.mealImage.downloadImage(from: URL(string:mealDetail?.strMealThumb ?? "")!)
        }
        if  let mealsData = (responseData["meals"] as? [[String:Any]])?.first as? [String:Any]{
            for (key,value) in mealsData{
                if let ingrediant = value as? String{
                    if key.contains("strIngredient"),!(ingrediant as! String).isEmpty || ingrediant.count > 0{
                        self.mealIngredeents.text = "\(self.mealIngredeents.text ?? "") \n >\(value)"
                        self.progressHUD.hide()
                    }
                }
            }
        }
        
    }

}
