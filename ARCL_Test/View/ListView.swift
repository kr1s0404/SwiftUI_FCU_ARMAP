//
//  ListView.swift
//  ARCL_Test
//
//  Created by Kris on 3/14/22.
//

import SwiftUI

enum LocationEnum: String {
    case Administration_Building                = "Administration_Building"
    case Administration_Building_II             = "Administration_Building_II"
    case Chiu_Feng_Chia_Memorial_Hall           = "Chiu_Feng_Chia_Memorial_Hall"
    case Library                                = "Library"
    case Science_and_Aeronautical_Eng_building  = "Science_and _Aeronautical_Eng_building"
    case Business_Building                      = "Business_Building"
    case Jong_Chin_Building                     = "Jong-Chin_Building"
    case Architecture_Building                  = "Architecture_Building"
    case Language_Building                      = "Language_Building"
    case Engineering_Building                   = "Engineering_Building"
    case Ren_Yan_Building                       = "Ren-Yan_Building"
    case Information_Engineering_Eng_Building   = "Information_Engineering_Eng_Building"
    case Humanities_Social_sciences_Building    = "Humanities_Social_sciences_Building"
    case Electronic_Communications_Eng_Building = "Electronic_Communications_Eng_Building"
    case Recreation_Building                    = "Recreation_Building"
    case Civil_Hydraulic_Eng_Building           = "Civil_Hydraulic_Eng_Building"
    case Science_Building                       = "Science_Building"
    case Xue_Si_building                        = "Xue_Si_building"
    case Sports_Building                        = "Sports_Building"
    case Wenhwa_Innovation_Building             = "Wenhwa_Innovation_Building"
    case East_Door                              = "East_Door"
}

struct ListView: View
{
    @State var objs: [OfficeObject]?
    @State var locationEnum: LocationEnum = .Administration_Building
    
    var body: some View
    {
        // 在LandMark裡面已經包在NavigationView裡面了
        ScrollView
        {
            ForEach(objs!, id: \.self) { obj in
                CustomNavigationLink(title: obj.name) {
                    ListDetailView(obj: obj)
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View
    {
        NavigationLink
        {
            content()
        } label: {
            HStack()
            {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.white.cornerRadius(12))
            .padding(.horizontal)
            .padding(.top, 10)
            .shadow(radius: 8)
        }
    }
    
    
    func OfficeList(objs: OfficeObject) -> AnyView {
        switch locationEnum {
        case .Administration_Building:
            return AnyView(EmptyView())
        case .Administration_Building_II:
            return AnyView(EmptyView())
        case .Chiu_Feng_Chia_Memorial_Hall:
            return AnyView(EmptyView())
        case .Library:
            let libraryObject = LibraryViewModel.build()
            return AnyView(ListView(objs: libraryObject))
        case .Science_and_Aeronautical_Eng_building:
            return AnyView(EmptyView())
        case .Business_Building:
            return AnyView(EmptyView())
        case .Jong_Chin_Building:
            return AnyView(EmptyView())
        case .Architecture_Building:
            return AnyView(EmptyView())
        case .Language_Building:
            return AnyView(EmptyView())
        case .Engineering_Building:
            return AnyView(EmptyView())
        case .Ren_Yan_Building:
            return AnyView(EmptyView())
        case .Information_Engineering_Eng_Building:
            return AnyView(EmptyView())
        case .Humanities_Social_sciences_Building:
            return AnyView(EmptyView())
        case .Electronic_Communications_Eng_Building:
            return AnyView(EmptyView())
        case .Recreation_Building:
            return AnyView(EmptyView())
        case .Civil_Hydraulic_Eng_Building:
            return AnyView(EmptyView())
        case .Science_Building:
            return AnyView(EmptyView())
        case .Xue_Si_building:
            return AnyView(EmptyView())
        case .Sports_Building:
            return AnyView(EmptyView())
        case .Wenhwa_Innovation_Building:
            return AnyView(EmptyView())
        case .East_Door:
            return AnyView(EmptyView())
        }
    }
}

struct ListDetailView: View
{
    @State var obj: OfficeObject?
    
    var body: some View
    {
        VStack
        {
            Text(obj?.phone ?? "")
            Text(obj?.office ?? "")
        }
    }
}

struct ListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ListView()
    }
}
