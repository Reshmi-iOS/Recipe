//
//  MealModel.swift
//  Receipies
//
//  Created by Apple on 27/03/24.
//

import Foundation

struct MealsModel:Decodable{
    var meals:[Meals]?
}
struct Meals:Decodable{
    var strMeal,strMealThumb,idMeal:String?
}
struct MealDetailModel:Decodable{
    var meals:[MealDetail]?
}
struct MealDetail:Decodable{
    var idMeal,
          strMeal,
          strInstructions,
          strMealThumb,
          strIngredient1,
          strIngredient2,
          strIngredient3,
          strIngredient4,
          strIngredient5,
          strIngredient6,
          strIngredient7,
          strIngredient8,
          strIngredient9,
          strIngredient10,
          strIngredient11,
          strIngredient12,
          strIngredient13,
          strIngredient14,
          strIngredient15,
          strIngredient16,
           strIngredient17,
          strIngredient18,
          strIngredient19,
        strIngredient20:String?
}
