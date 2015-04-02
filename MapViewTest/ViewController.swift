//
//  ViewController.swift
//  MapViewTest
//
//  Created by lostin1 on 2015. 3. 17..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var locationManager:CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ZoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 20000, 20000)
        mapView.setRegion(region, animated: false)
    }
    @IBAction func changeMapType(sender: AnyObject) {
        if mapView.mapType == MKMapType.Standard {
            mapView.mapType = MKMapType.Satellite
        }
        else {
            mapView.mapType = MKMapType.Standard
        }
    }

    @IBAction func setPin(sender: AnyObject) {
        let touchPoint:CGPoint = sender.locationInView(self.mapView)
        let location:CLLocationCoordinate2D = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        let annotationPin = MKPointAnnotation()
        annotationPin.coordinate = location
        annotationPin.title = "Danger!!!!!"
        annotationPin.subtitle = "Help Me!!!!!!"
        self.mapView.addAnnotation(annotationPin)
        println("longPressRecognizer sender object")
    }

/*
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
*/ 
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch (status) {
            case CLAuthorizationStatus.Denied:
                println("유저가 위치서비스 허용을 거절함")
            break;
            case CLAuthorizationStatus.NotDetermined:
                println("유저가 위치서비스 허용을 아직 선택하지 않았음")
            break;
            case CLAuthorizationStatus.Restricted:
                println("이 앱은 위치서비스 허용을 승인받지 못함. 위치서비스에 대한 제약이 활성화 되어있기 때문에, 유저는 이 상태를 바꿀 수 없고, 개별적으로 권한이 거부되지 않았을 수 있다.")
            break;
            default:
                mapView.showsUserLocation = true
            break;
        }
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800)
        mapView.setRegion(region, animated: true)
        
        let anotationPoint = MKPointAnnotation()
        anotationPoint.coordinate = userLocation.coordinate
        anotationPoint.title = "Where am I?"
        anotationPoint.subtitle = "I'm Here!"
        
        self.mapView.addAnnotation(anotationPoint)
    }
}

