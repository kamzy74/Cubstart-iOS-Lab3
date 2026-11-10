//
//  ContentView.swift
//  checklist
//
//  Created by Andy Huang on 7/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var description: String = ""
    @State private var inProgress: [String] = ["Go for Pilates class"]
    @State private var complete: [String] = [
        "Study for Database",
        "Buy groceries for putlock",
        "Do AI Governance research"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(description: $description, inProgress: $inProgress)
            ChecklistView(inProgress: $inProgress, complete: $complete)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(
                colors: [.white, .teal, .blue],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

struct HeaderView: View {
    @Binding var description: String
    @Binding var inProgress: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Text("Kamilah")
                    .font(.title)
                    .bold()
                    .padding(.leading, 8)
                Spacer()
            }
            HStack {
                TextField("Add a task", text: $description)
                    .textFieldStyle(.roundedBorder)

                Button {
                    inProgress.append(description)
                    description = ""
                } label: {
                    Text("Add")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
    }
}

struct ChecklistView: View {
    @Binding var inProgress: [String]
    @Binding var complete: [String]

    var body: some View {
        List {
            Section(header: Text("In progress").textCase(nil)) {
                ForEach(inProgress, id: \.self) { task in
                    Button {
                        if let index = inProgress.firstIndex(of: task) {
                            inProgress.remove(at: index)
                        }
                        complete.append(task)
                    } label: {
                        HStack {
                            Image(systemName: "circle")
                            Text(task)
                        }
                        .foregroundColor(.primary)
                    }
                }
            }

            Section(header: Text("Complete").textCase(nil)) {
                ForEach(complete, id: \.self) { task in
                    Button {
                        if let index = complete.firstIndex(of: task) {
                            complete.remove(at: index)
                        }
                        inProgress.append(task)
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text(task)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
