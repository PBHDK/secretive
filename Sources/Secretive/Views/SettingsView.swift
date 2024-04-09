
import SwiftUI

enum CommentStyle: String, CaseIterable, Identifiable {
    case keyAndHost = "keyAndHost"
    case none = "none"
    
    var id: Self { self }
}

struct GeneralSettingsView: View {
    @AppStorage("com.maxgoedjen.Secretive.commentStyle") var selectedCommentStyle: CommentStyle = .keyAndHost

    var body: some View {
        VStack(alignment: .leading) {
            Section(footer: Text("SSH public keys can be extended with an arbitrary comment string without changing the meaning of the key.")
                .font(.caption)
                .fontWeight(.light)) {
                    Picker("SSH Public Key Comment", selection: $selectedCommentStyle) {
                        Text("Default").tag(CommentStyle.keyAndHost)
                        Text("None").tag(CommentStyle.none)
                    }
                    .pickerStyle(DefaultPickerStyle())
                    // TODO: Add selected comment style from keychain
                    CopyableView(title: "public_key_comment_style_label", image: Image(systemName: "touchid"), text: "ecdsa-sha2-nistp256 <your_public_key>")
                }
        }
        .padding(30)
        .navigationTitle("Settings")
    }
}


struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        }
        .padding(20)
        .frame(width: 500, height: 200)
    }
}

#Preview {
    SettingsView()
}
