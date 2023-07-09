//
//  AddItemView.swift
//  WatchToDoList Watch App
//
//  Created by Lei on 2023/7/7.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var locationServiceAdaptor = LocationServiceAdaptor()
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var createdDateString: String = ""
    @State private var dueDateString: String = ""
    @State private var location: String = ""
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Group {
                    Text(ItemList.title.titleName)
                        .bold()
                    TextField("Title...", text: $title)
                    Divider()
                }
                
                
                Group {
                    Text(ItemList.description.titleName)
                        .bold()
                    TextField("Description...", text: $description)
                    Divider()
                }
                
                Group {
                    Text(ItemList.createdDate.titleName)
                        .bold()
                    TextField(Utils.convertDateToString(Date()), text: $createdDateString)
                    Divider()
                }
                
                Group {
                    Text(ItemList.dueDate.titleName)
                        .bold()
                    TextField(Utils.convertDateToString(Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()), text: $dueDateString)
                    Divider()
                }
                
                Group {
                    Text(ItemList.location.titleName)
                        .bold()
                    TextField(locationServiceAdaptor.location, text: $location)
                    Divider()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                       addNewItem()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                        
                    }
                    Spacer()
                }
            }
        }
        
        .onAppear {
            locationServiceAdaptor.getLocation()
            location = locationServiceAdaptor.location
            print("===location:\(location)")
        }
    }
    
    private func addNewItem() {
        let newItem = ToDoItem(title: title,
                               description: description,
                               createdDate: Utils.convertStringToDate(createdDateString) ?? Date(),
                               dueDate: Utils.convertStringToDate(dueDateString) ?? Date(),
                               location: location)
//        viewModel.addNewItem(newItem: newItem)
        print("===new item:\(newItem)")
        
    }
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

struct DatePickerButton: View {
    let title: String
    let range: ClosedRange<Int>
    @Binding var selectedValue: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Picker(selection: $selectedValue, label: Text(title)) {
                ForEach(range, id: \.self) { value in
                    Text("\(value)")
                }
            }
            .frame(width: 80)
            .pickerStyle(WheelPickerStyle())
        }
    }
}
