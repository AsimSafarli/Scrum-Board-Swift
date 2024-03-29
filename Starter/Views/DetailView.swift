//
//  DetailView.swift
//  Starter
//
//  Created by Asim Seferli on 17.01.24.
//

import SwiftUI


struct DetailView: View {
    let scrum: DailyScrum
    
    @State private var isPresentingEditView = false


    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: ContentView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                };
                
                HStack{
                    Label("Length",systemImage: "timer")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }        }
        .navigationTitle(scrum.title)
        
        .toolbar {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
        .sheet(isPresented: $isPresentingEditView) {
                 NavigationStack {
                     DetailEditView()
                         .navigationTitle(scrum.title)
                         .toolbar {
                             ToolbarItem(placement: .cancellationAction) {
                                 Button("Cancel") {
                                     isPresentingEditView = false
                                 }
                             }
                         }
                 }
             }
        
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
