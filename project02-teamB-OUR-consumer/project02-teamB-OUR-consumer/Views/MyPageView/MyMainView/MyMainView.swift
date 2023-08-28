import SwiftUI
import Firebase

struct MyMain: View {
    @StateObject private var studyStore = StudyStore()
    @State private var currentTab: Int = 0
    @State private var isMyProfile: Bool = true
    
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var resumeViewModel = ResumeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // 설정 및 북마크 아이콘
                    ProfileBar(isMyProfile: $isMyProfile)
                    
                    // 프로필 헤더
                    ProfileHeaderView(isMyProfile: $isMyProfile, userViewModel: userViewModel)
                }
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch currentTab {
                        case 0:
                            MyResumeView(myResume: resumeViewModel.resume, isMyProfile: $isMyProfile)
                        case 1:
                            MyBoardView()
                        case 2:
                            MyStudyView(studyArray: studyStore.studyArray)
                        default:
                            EmptyView()
                        }
                    } header: {
                        MyMainTabBar(currentTab: $currentTab, namespace: Namespace())
                    }
                }
            }
            .padding(.top, 1)
        }
        .onAppear(){
            userViewModel.fetchUser(userId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2")
            resumeViewModel.fetchResume(userId: "0RPDyJNyzxSViwBvMw573KU0jKv1")
        }
    }
    
}

struct MyMain_Previews: PreviewProvider {
    static var previews: some View {
        MyMain()
    }
}

