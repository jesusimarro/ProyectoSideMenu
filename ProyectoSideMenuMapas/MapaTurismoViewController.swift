//
//  MapaTurismoViewController.swift
//  ProyectoSideMenuMapas
//
//  Created by estech on 20/1/23.
//

import UIKit
import MapKit

class MapaTurismoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationEnabled = false
    var miLocation: CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let catedralLocation = CLLocation(latitude: 37.990090169081064, longitude: -3.46882911704594)
    let regionRadius: CLLocationDistance = 500
    
    let positoLocation = CLLocation(latitude: 38.09271794128776, longitude: -3.635010070431662)
    let escuelaLocation = CLLocation(latitude: 38.09419291831398, longitude: -3.631227323320475)
    
    let centroLocation = CLLocation(latitude: 38.058546913975796, longitude: -3.547715090499774)
    let regionCentroRadius: CLLocationDistance = 20000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureMainMenu(menuButton: menuButton)
        
        self.configureMap()
        self.localiza()
    }
    
    
    func configureMap() {
        self.mapView.delegate = self

        let artwork = Artwork(coordinate: catedralLocation.coordinate, title: "Catedral", locationName: "Catedral de la Natividad de Nuestra Señora de Baeza", discipline: "Iglesias")
        
        let artwork2 = Artwork(coordinate: positoLocation.coordinate, title: "El Pósito", locationName: "El Pósito de Linares", discipline: "Museos")
        
        let artwork3 = Artwork(coordinate: escuelaLocation.coordinate, title: "Escuela Estech", locationName: "Escuela de Tecnologías Aplicadas Estech", discipline: "Educación")
        
        
        let coordinateRegionCentro = MKCoordinateRegion(center: centroLocation.coordinate, latitudinalMeters: regionCentroRadius, longitudinalMeters: regionCentroRadius)
        mapView.setRegion(coordinateRegionCentro, animated: true)
        
        
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(artwork2)
        mapView.addAnnotation(artwork3)
    }
    
    
    @IBAction func SwitchAction(_ sender: UISwitch) {
        
        if sender.isOn {
            for annotation in self.mapView.annotations {
                if annotation.title == "Catedral" {
                    self.mapView.removeAnnotation(annotation)
                }
            }
            
        } else {
            self.configureMap()
        }
    }
    
    
    
    func localiza() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        let status = CLLocationManager()
        
        switch status.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.locationEnabled = true
            
            default:
            print("No tenemos permiso de ubicación")
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.miLocation = locations.last!
        
        let actualArtwork = Artwork(coordinate: miLocation!.coordinate, title: "Ubicación Actual", locationName: "Ahora mismo me encuentro aquí", discipline: "Lugar")
        
        mapView.addAnnotation(actualArtwork)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {
            case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
            case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.locationEnabled = true
            
            default:
            print("El usuario ha rechazado los permisos de ubicación")
            self.locationEnabled = false
        }
    }
    
}
