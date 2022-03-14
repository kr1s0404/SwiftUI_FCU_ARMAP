//
//  BeaconDetector.swift
//  ARCL_Test
//
//  Created by Kris on 3/11/22.
//

import SwiftUI
import Combine
import CoreLocation

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate
{
    var objectWillChange = ObservableObjectPublisher()
    var locationManager: CLLocationManager?
    var lastDistance = CLProximity.unknown
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        let beaconReigon = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "My Beacon")
        
        locationManager?.startMonitoring(for: beaconReigon)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity) {
        lastDistance = distance
        self.objectWillChange.send()
    }
}
