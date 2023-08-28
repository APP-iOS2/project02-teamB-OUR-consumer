import SwiftUI
import Firebase

struct ProfileEditView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var profileMessage: String = ""
    @State private var profileImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image("defaultProfileImage") // Default profile image placeholder
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            Button("사진 선택") {
                isImagePickerPresented = true
            }
            .sheet(isPresented: $isImagePickerPresented, content: {
                ImagePicker(image: $profileImage)
            })
            
            TextField("이름", text: $name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            TextField("이메일", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            TextEditor(text: $profileMessage)
                .frame(height: 150)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button("저장") {
                saveProfileChanges()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .onAppear {
            if let user = userViewModel.user {
                name = user.name
                email = user.email
                profileMessage = user.profileMessage ?? ""
            }
        }
        .padding()
    }
    
    func saveProfileChanges() {
        if var updatedUser = userViewModel.user {
            updatedUser.name = name
            updatedUser.email = email
            updatedUser.profileMessage = profileMessage
            userViewModel.updateUser(user: updatedUser)
        }
    }
    
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(userViewModel: UserViewModel())
    }
}
