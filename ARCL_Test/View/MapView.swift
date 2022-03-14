//
//  MapView.swift
//  ARCL_Test
//
//  Created by Kris on 3/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var coordinate: CLLocationCoordinate2D
    
    /// 這裡的center裡面放的經緯度是placeholder，會影響使用者開起MapView之後地圖顯示的中間位子在哪裡
    /// span代表的是要縮放的地圖大小，數值越大代表地圖顯示的越粗，所以數值越小才能顯示較精細的東西
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.0020, longitudeDelta: 0.0020)
    )
    
    var body: some View
    {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(coordinate)
            }
    }
    
    /// 我們要針對不同的建築物所顯示不同的MapView，所以在這邊新增一個func去產生新的coordinate
    /// - Parameter coordinate: 傳入我們從JSON裡面所設置的座標
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.0020, longitudeDelta: 0.0020)
        )
    }
}
