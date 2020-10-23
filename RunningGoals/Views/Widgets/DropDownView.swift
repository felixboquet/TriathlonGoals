//
//  DropDownView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct DropDownView<T: DropdownItemProtocol>: View {
    
    @Binding var viewModel: T
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"),
                    buttons: viewModel.options.map { option in
                        return .default(Text(option.formatted)) {
                            viewModel.selectedOption = option
                        }
                    })
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 8)
            Button(action: {
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }.buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }.actionSheet(isPresented: $viewModel.isSelected) {
            actionSheet
        }
        .padding(20)
    }
    
}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropDownView()
//        }.environment(\.colorScheme, .light)
//        
//        NavigationView {
//            DropDownView()
//        }.environment(\.colorScheme, .dark)
//    }
//}
