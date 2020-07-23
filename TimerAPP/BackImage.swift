//
//  Image.swift
//  TimerAPP
//
//  Created by 下里浩昇 on 2020/07/17.
//  Copyright © 2020 shimo. All rights reserved.
//

import SwiftUI

struct BackImage: View {
    var body: some View {
        Image("IMG_3734")
            .resizable()
            .scaledToFit()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 4
                )
            )
            .shadow(radius: 10)

    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        BackImage()
    }
}
