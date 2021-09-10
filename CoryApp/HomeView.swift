//
//  HomeView.swift
//  CoryApp
//
//  Created by Cory Schadt on 2021-09-10.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    
    @State var showUpdate = false
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                AvatarView(showProfile: $showProfile)
                
                Button(action: {self.showUpdate.toggle()}) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
                        
                }
                .sheet(isPresented: $showUpdate) {
                    Text("Cool")
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                .rotation3DEffect(Angle(degrees:
                                                            Double(geometry.frame(in:
                                                                                    .global).minX - 30) / -20
                                ), axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 28, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 sections",
            logo: "Logo1", image: Image("Card3"), color: Color("card3")),
    Section(title: "Cory's neat thing", text: "20 sections",
            logo: "Logo2", image: Image("Card2"), color: Color("card2")),
    Section(title: "Cool", text: "11 sections",
            logo: "Logo3", image: Image("Card1"), color: Color("card1"))
]
