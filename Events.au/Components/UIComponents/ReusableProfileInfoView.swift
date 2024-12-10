import SwiftUI

struct ReusableProfileInfoView: View {
    
  @Binding var path: [HomeNavigation]
    @Binding var selectedTab: Tab
    let user : UserModel2
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                        UserProfileDetailAvatar(user: user)
                    Spacer()
                }
                .padding(.top, 20)
                VStack(alignment: .leading, spacing: 10) {
                  ProfileDetailRow(label: "First Name", value: user.firstName ?? "")
                        //MARK: add last name after dropping user database
//                        ProfileDetailRow(label: "Last Name", value : "Last Name")
                  ProfileDetailRow(label: "Email", value: user.email ?? "")
                  ProfileDetailRow(label: "Phone", value: "\(user.phone ?? -1)")
                }
                .padding()
                .padding(.horizontal, 16)
                
            }
        }
       


        
    }
}


