//
//  ContentView.swift
//  caculatorSwiftUI
//
//  Created by 劉子瑜 on 2019/11/29.
//  Copyright © 2019 劉子瑜. All rights reserved.
//

import SwiftUI
import Combine

let scale = UIScreen.main.bounds.width / 414

struct ContentView: View {
    var body: some View {
        //alignment用來做對齊
        VStack(spacing: 12) {
            //Spacer會將可佔據的空白空間填滿
            Spacer()//畫面中剩下的空白
            Text("012345")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5) //文字的縮小比例，最多能縮小多少
                .padding(.trailing,24 * scale) //與最後一行的間距
                .lineLimit(1) //行數限制在一行
                //frame中的maxWidth設定為inifity，表示不對最大寬度進行限制，text會盡可能佔據容器寬度
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad().padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //支援更多的螢幕尺寸
        Group{
            ContentView()
            ContentView().previewDevice("iPhone SE")
        }
    }
}

struct CalculatorButton: View {
    let fontSize:CGFloat = 38
    let title:String
    let size:CGSize
    let backgroundColorName:String
    let foregroundColorName:String
    let action:()->Void //內容是空，而且沒有回傳內容
    var body: some View {
        Button(action:action) { //當按下button後會執行action closure(在此沒執行東西)，而要顯示的內容則是使用第二個
            Text(title)
                .font(.system(size:fontSize * scale)) //更變字型樣式
                .foregroundColor(Color(foregroundColorName)) //設定前景/字形顏色
                .frame(width: size.width * scale, height: size.height * scale)
                .background(Color(backgroundColorName)) //設定背景顏色
                .cornerRadius(size.width * scale/2) //設定角度
        }
    }
}

struct CalculatorButtonRow: View{
    let row:[CalculatorButtonItem]
    var body: some View {
        //Horizontal Stack：水平堆疊，沒設定間距，就是預設為0
        HStack{
            //forEach init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content)
            //forEach是利用Id來區分array裡面的裡面的成員，
            //當row傳入array，需要額外設定型別KeyPath的參數ID，
            //ID將設定array成員的ID，在此傳入\.self，表示array成員自己就是ID
            //e.g .command(.clear)的ID就是.command(.clear)
            // \.self寫法與Swift KeyPath有關，並非任何東西都能當ID
            //ForEach的定義為ID的型別必須遵守protocol Hashable(Int與String本身就有尊湊)
            //foreach原先是用來列舉同一型態的元素，若要列舉，要在array那邊加上hasable
            
            //列舉元素，並生成對應view collection類型
            ForEach(row,id:\.self){item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName,
                    foregroundColorName: item.foregroundColorName)
                {
                    print("Button:\(item.title)")
                }
            }
        }
    }
}

struct CalculatorButtonPad: View{
    let pad:[[CalculatorButtonItem]] = [
        [.command(.clear),.command(.flip),.command(.percent),.op(.divide)],
        [.digit(7),.digit(8),.digit(9),.op(.multyiply)],
        [.digit(4),.digit(5),.digit(6),.op(.minus)],
        [.digit(1),.digit(2),.digit(3),.op(.plus)],
        [.digit(0),.dot,.op(.equal)]
    ]
    var body: some View{
        //垂直堆疊，間距為8
        VStack(spacing:8){
            ForEach(pad,id: \.self){ row in
                CalculatorButtonRow(row:row)
            }
        }
    }
}
