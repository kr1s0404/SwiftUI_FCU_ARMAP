//
//  LocationLayerNode.swift
//  ARCL_Test
//
//  Created by Kris on 3/10/22.
//

import SwiftUI
import ARCL
import CoreLocation

open class LocationLayerNode: LocationAnnotationNode {
    
    public var layer = CALayer()
    
    public init(location: CLLocation, layer: CALayer) {
        self.layer = layer
        
        guard let image = UIImage.image(from: layer) else {
            fatalError()
        }
        
        super.init(location: location, image: image)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    
    class func image(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, UIScreen.main.scale)
        
        defer { UIGraphicsEndImageContext() }
        
        // Don't proceed unless we have context
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

