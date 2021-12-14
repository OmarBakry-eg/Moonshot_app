//
//  MissionView.swift
//  Moonshot
//
//  Created by Omar Bakry on 14/12/2021.
//

import SwiftUI

struct MissionView: View {
    let mission : Mission
    let crew: [CrewMember]
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    var body: some View {
        GeometryReader {
            geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:geo.size.width * 0.6)
                        .padding([.top,.bottom])
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    VStack(alignment:.leading){
                       Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom,5)
                        Text(mission.description)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.bottom)
               
            
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(crew,id: \.role) {
                            member in
                            NavigationLink {
                                AstronautView(astronaut: member.astronaut)
                            } label: {
                                HStack {
                                    Image(member.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().strokeBorder(.white,lineWidth: 1))
                                    VStack(alignment: .leading) {
                                                        Text(member.astronaut.name)
                                                            .foregroundColor(.white)
                                                            .font(.headline)
                                                        Text(member.role)
                                                            .foregroundColor(.secondary)
                                                    }
                                    .padding(.horizontal,2)
                                  
                                }
                                .padding(.horizontal,3)
                            }
                        }
                    }
                }
            }
            
          
           
        }
        .navigationBarTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0],astronauts: astronauts)
              .preferredColorScheme(.dark)
    }
}
