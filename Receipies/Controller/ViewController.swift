//
//  ViewController.swift
//  Receipies
//
//  Created by Apple on 27/03/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableMeals:UITableView!
    lazy var apiManger = APIManager()
    var mealsArray = [Meals]()
    let progressHUD = ProgressHUD(text: "Loading  Data")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(progressHUD)
           // All done!
        tableMeals.delegate = self
        tableMeals.dataSource = self
        tableMeals.register(UINib(nibName: "MealListTableViewCell", bundle: nil), forCellReuseIdentifier: "MealListTableViewCell")
        self.mealsListAPICall()
        
    }
    //API call
    func mealsListAPICall(){
        self.progressHUD.show()
        apiManger.mealsListAPICall { data in
            if let response = data{
                do{
                    let mealsModel = try JSONDecoder().decode(MealsModel.self, from: response)
                    DispatchQueue.main.async {
                        self.mealsArray = mealsModel.meals ?? []
                        self.tableMeals.reloadData()
                        self.progressHUD.hide()
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
//Tableview Delegate methods
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MealListTableViewCell", for: indexPath) as! MealListTableViewCell
        let meal = mealsArray[indexPath.row]
        if meal.strMeal != "",meal.strMealThumb != ""{
            cell.mealName.text = meal.strMeal
            cell.imageMeal.downloadImage(from: URL(string:meal.strMealThumb ?? "")!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewControlelrViewController
        vc.meal = self.mealsArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
