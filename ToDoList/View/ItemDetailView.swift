//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct ItemDetailView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var location: String
    @Binding var createdDate: Date
    @Binding var dueDate: Date
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title3)
                    .bold()
                TextField("Title...", text: $title)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.title3)
                    .bold()
                TextField("Description...", text: $description)
                Divider()
            }
            
            DatePicker(
                selection: $createdDate,
                displayedComponents: .date) {
                    Text("Created Date").foregroundColor(Color(.gray))
                }
            DatePicker(
                selection: $dueDate,
                displayedComponents: .date) {
                    Text("Due Date").foregroundColor(Color(.gray))
                }
            
            VStack(alignment: .leading) {
                Text("Location")
                    .font(.title3)
                    .bold()
                if let defaultLocation = locationManager.location {
                    let defaultLocationString = Utils.getDefaultLocationString(location: defaultLocation)
                    TextField("Location: \(defaultLocationString)", text: $location)
                } else {
                    TextField("Location...", text: $location)
                }
                
                Divider()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding()
        .onAppear {
            locationManager.requestLocation()
        }
    }
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(
                   title: .constant("Sample Title"),
                   description: .constant("Sample Description"),
                   location: .constant("Sample Location"),
                   createdDate: .constant(Date()),
                   dueDate: .constant(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
               )
    }
}
