//
//  AddItemView.swift
//  WatchToDoList Watch App
//
//  Created by Lei on 2023/7/7.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var locationServiceAdaptor = LocationServiceAdaptor()
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var createdDateString: String = ""
    @State private var dueDateString: String = ""
    @State private var location: String = ""
    
    @State private var showAlert = false
    @State private var alertType: AlertType = .dataSaving

    
    var body: some View {
        ScrollView {
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
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        checkDataFormat()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                        
                    }
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertType.title), message: Text(alertType.message), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            locationServiceAdaptor.getLocation()
        }
    }
    
    private func addNewItem() {
        let newLocation = location.isEmpty ? locationServiceAdaptor.location : location
        let newItem = ToDoItem(title: title,
                               description: description,
                               createdDate: Utils.convertStringToDate(createdDateString) ?? Date(),
                               dueDate: Utils.convertStringToDate(dueDateString) ?? Date(),
                               location: newLocation)
        connectivityManager.sendItem(newItem)
        cleanItemData()
        setAlert(alertType: .dataSaving)
    }
    
    
    
    private func cleanItemData() {
        title = ""
        description = ""
        createdDateString = ""
        dueDateString = ""
        location = ""
    }
    
    private func checkDataFormat() {
        if validateDateFields() {
            addNewItem()
            
        } else {
            setAlert(alertType: .dataInvalid)
        }
    }
    
    private func validateDateFields() -> Bool {
        var isCreatedDateStringValid: Bool = true
        if !createdDateString.isEmpty {
            isCreatedDateStringValid = Utils.validateDateFormat(dateString: createdDateString)
        }
        
        var isDueDateStringValid: Bool = true
        if !dueDateString.isEmpty {
            isDueDateStringValid = Utils.validateDateFormat(dateString: dueDateString)
        }
        
        return isCreatedDateStringValid && isDueDateStringValid
    }
    
    private func setAlert(alertType: AlertType) {
        self.alertType = alertType
        showAlert = true
    }
}

extension AddItemView {
    enum AlertType {
        case dataSaving
        case dataInvalid
        
        var title: String {
            switch self {
            case .dataSaving:
                return "Saving Data in iPhone"
            case .dataInvalid:
                return "Date format is incorrect"
            }
        }
        
        var message: String {
            switch self {
            case .dataSaving:
                return ""
            case .dataInvalid:
                return  "Please modify date in the format of YYYY/MM/DD."
            }
        }
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
