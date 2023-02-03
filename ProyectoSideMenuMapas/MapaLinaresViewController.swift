//
//  MapaLinaresViewController.swift
//  ProyectoSideMenuMapas
//
//  Created by estech on 20/1/23.
//

import UIKit
import MapKit

class MapaLinaresViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let positoLocation = CLLocation(latitude: 38.09271794128776, longitude: -3.635010070431662)
    let escuelaLocation = CLLocation(latitude: 38.09419291831398, longitude: -3.631227323320475)
    let regionRadius: CLLocationDistance = 500


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureMainMenu(menuButton: menuButton)

        self.configureMap()
    }
    
    func configureMap() {
        self.mapView.delegate = self

        let coordinateRegion = MKCoordinateRegion(center: positoLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let artwork = Artwork(coordinate: positoLocation.coordinate, title: "El Pósito", locationName: "El Pósito de Linares", discipline: "Museos")
        
        let artwork2 = Artwork(coordinate: escuelaLocation.coordinate, title: "Escuela Estech", locationName: "Escuela de Tecnologías Aplicadas Estech", discipline: "Educación")
        
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(artwork2)
    }
    
}


extension MapaLinaresViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Artwork else { return nil }
        
        var view: MKMarkerAnnotationView
        let identifier = "marker"
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if annotation.title == "El Pósito" {
                view.markerTintColor = .yellow
            }
            
            if annotation.title == "Escuela Estech" {
                view.glyphImage = UIImage(named: "estechlogo")
                view.markerTintColor = .systemCyan
            }
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]

        if location.title == "El Pósito" {
            location.mapItem().openInMaps(launchOptions: launchOptions)
            
        } else if location.title == "Escuela Estech" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as! WebViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
