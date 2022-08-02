//
//  EmployeeViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 19/05/2022.
//

import Foundation

struct EmployeeViewModel: EmployeePresentable {
  
    let employee: Employee
  
    var name: String {
        return employee.name
    }
  
    var age: String {
        return employee.age
    }
    
    var salary: String {
        return employee.salary
    }
    
    var picture: String {
        let first = "https://static.vecteezy.com/system/resources/thumbnails/006/487/917/small_2x/man-avatar-icon-free-vector.jpg"
        let second = "https://cdn-icons-png.flaticon.com/512/194/194938.png"
        let third = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuNfh5XEmL28p3fZftINhCjPR1g7V8IDWJ9-H58s0jyp4GMH_nWaRqFrRFu-6CJbaTdK0&usqp=CAU"
        let fourth = "https://i.stack.imgur.com/BAFSr.png?s=40&g=1"
        let fifth = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvFWTVF8t77qNUOW-M0MJt-97KXpoW6mRp7Gx22Jlr-X1wRtW63QggWyUVhnXhjvXjcSA&usqp=CAU"
        let avatars:[String] = [first, second, third, fourth, fifth]
        return avatars.randomElement() ?? first
    }
}
