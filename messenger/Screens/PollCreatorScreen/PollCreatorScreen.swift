import SwiftUI

/// TODO logic:
/// close - title create
/// viewModel
/// creation action
/// logic from service
/// limitation of enter text
/// action delete option
/// option - textfield with limitation

/// TODO: Design:
/// option - text with delete action

struct PollCreatorScreen: View {
    @State private var title: String = ""
    @State private var options: [String] = []
    @State private var isAnonymousOption: Bool = false
    @State private var abilityToAddMoreOptions: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    FormSection(title: "Question") {
                        TextField("Ask a question", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                Text("\(title.count)/50")
                                    .foregroundColor(title.count > 50 ? .red : .primary)
                                    .font(.caption)
                                    .padding(.trailing, 8)
                                , alignment: .trailing
                            )
                    }
                    
                    FormSection(title: "Options") {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                        
                        Button(action: addOption) {
                            Text("Add an option")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    FormSection(title: "Switches") {
                        Toggle("Anonymous voting", isOn: $isAnonymousOption)
                        Toggle("Ability to add more options", isOn: $abilityToAddMoreOptions)
                    }
                }
            }.navigationTitle("Create poll")
        }
    }
    
    func addOption() {
        options.append("Option \(options.count + 1)")
    }
}

struct FormSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        Section(header: Text(title)) {
            content
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PollCreatorScreen()
    }
}
