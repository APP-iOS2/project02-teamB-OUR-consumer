import SwiftUI

struct MyFollowerView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    @State var followers: [User] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(followers) { follower in
                        NavigationLink(destination: FollowerDetailView(follower: follower)) {
                            MyFollowerCell(userViewModel: userViewModel, follower: follower)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationBarTitle("Followers", displayMode: .inline)
            .onAppear {
                guard let userId = userViewModel.user?.id else { return print("옵셔널 못품") }
                
                userViewModel.fetchFollowDetails(userId: userId, follow: .follower) { users in
                    self.followers = users
                }
            }
        }
    }
}

struct FollowerDetailView: View {
    var follower: User

    var body: some View {
        Text("Detail for \(follower.name)")
    }
}

struct MyFollowerView_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowerView(userViewModel: UserViewModel())
    }
}
