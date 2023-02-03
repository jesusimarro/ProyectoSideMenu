//
//  Artwork.swift
//  ProyectoSideMenuMapas
//
//  Created by estech on 20/1/23.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String
    let discipline: String
    
    var subtitle: String? {
        return locationName
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, locationName: String, discipline: String) {
        self.coordinate = coordinate
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)

        mapItem.name = title

        return mapItem
    }
    
}
