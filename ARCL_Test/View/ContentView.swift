//
//  ContentView.swift
//  ARCL_Test
//
//  Created by Kris on 3/10/22.
//

import SwiftUI
import ARCL
import CoreLocation
import SceneKit

struct ContentView: View
{
    @State var showSheet: Bool = false
    @State var LandMark: LandmarkNode?
    
    @ObservedObject var detector = BeaconDetector()
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            if detector.lastDistance == .immediate {
                Text("Right here")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.green)
            } else if detector.lastDistance == .near {
                Text("Near by")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.yellow)
            } else if detector.lastDistance == .far {
                Text("Far away")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.red)
            } else {
                Text("Uknown")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.gray)
            }
            
            
            ARCLViewContainer(ToggleSheetView: $showSheet, LandMark: $LandMark)
                .sheet(isPresented: $showSheet) {
                    LandMarkView(LandMark: LandMark)
                }
                .ignoresSafeArea()
            
        }
    }
}

struct ARCLViewContainer: UIViewControllerRepresentable
{
    @Binding var ToggleSheetView: Bool
    @Binding var LandMark: LandmarkNode?
    
    func makeUIViewController(context: Context) -> ARCLViewController {
        
        let view = ARCLViewController()
        view.observe = {
            ToggleSheetView = $0
            LandMark = $1
        }
        
        return view
    }
    
    func updateUIViewController(_ uiView: ARCLViewController, context: Context) {
        
    }
}


class ARCLViewController: UIViewController
{
    var observe: (Bool, LandmarkNode) -> () = { _, _ in }
    
    private var sceneLocationView = SceneLocationView()
    
    private var currentLocation: CLLocation? {
        return sceneLocationView.sceneLocationManager.currentLocation
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        addAllPoints()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    // MARK: DRAWING
    private func addAllPoints() {
        let objects = LocationViewModel.build()
        for object in objects {
            addPoint(from: object)
        }
    }
    
    private func addPoint(from object: LocationObject) {
        let coordinates = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
        let location = CLLocation(coordinate: coordinates, altitude: object.altitude)
        
        var distanceText = ""
        if let currentLocation = currentLocation {
            let distance = location.distance(from: currentLocation)
            distanceText = String(format: "%.2f 公尺", distance)
        }
        
        let landmarkNode = LandmarkNode(location: location, title: object.name, distance: distanceText, image: object.image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: landmarkNode)
    }
    
    func updateDistanceLabel(from object: LocationObject) {
        
    }
    
    // TODO: add animation on click for example
    private func animatePoint(_ node: SCNNode) {
        let action = SCNAction.rotateBy(x: 0, y: 0, z: 10, duration: 1)
        node.runAction(action)
    }
    
    // MARK: TOUCHES
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                let sceneView = self.sceneLocationView
                let location = touch.location(in: sceneView)
                let hitTest = sceneView.hitTest(location)
                
                if (!hitTest.isEmpty) {
                    let results = hitTest.first!
                    let currentNode = results.node
                    if let locationNode = getLocationNode(node: currentNode) {
                        print("clicked on node \(locationNode.title)")
                        
                        if let currentLocation = currentLocation {
                            let distance = locationNode.location.distance(from: currentLocation)
                            print("distance: \(distance)")
                        }
                        
                        observe(true, locationNode)
                    }
                }
            }
        }
    }
    
    func getLocationNode(node: SCNNode) -> LandmarkNode? {
        if node.isKind(of: LocationNode.self) {
            return node as? LandmarkNode
        } else if let parentNode = node.parent {
            return getLocationNode(node: parentNode)
        }
        return nil
    }
}
