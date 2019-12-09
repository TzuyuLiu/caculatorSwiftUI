//
//  CalculatorButtonItem.swift
//  caculatorSwiftUI
//
//  Created by 劉子瑜 on 2019/12/3.
//  Copyright © 2019 劉子瑜. All rights reserved.
//

import Foundation
import SwiftUI

enum CalculatorButtonItem {
    
    enum Op: String{
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multyiply = "×"
        case equal = "="
    }
    
    enum Command: String{
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    //限制選擇digit時輸入的東西為int
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem {
    //title宣告成String代表選擇(case)的東西都為String type
    var title: String {
        //self逮代表CalculatorButtonItem
        switch self {
        case .digit(let value):
            return String(value)
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        //沒有加上rawValue：Cannot convert return expression of type 'CalculatorButtonItem.Command' to return type 'String'
        case .command(let command):
            return command.rawValue
        }
    }
    
    var size: CGSize{
        let something = "."
        //若按鍵為0，則會將長度擴展
        //if case.digit(let value) = self {
        if case .digit(let value) = self,value == 0 {
        //if case.digit(0){ Variable binding in a condition requires an initializer
            return CGSize(width: 88*2+8, height: 88)
        }
        return CGSize(width:88,height:88)
      }
    
    var backgroundColorName: String{
        switch self {
        case .digit, .dot:
            return "digitBackground"
        case .op:
            return "operatorBackground"
        case .command:
            return "commandBackground"
        }
    }
    
    var foregroundColorName: String{
        switch self {
        case .command:
            return  "buttonItemcommand"
        default :
            return "gray"
        }
    }
    
    
}

extension CalculatorButtonItem: Hashable{}
