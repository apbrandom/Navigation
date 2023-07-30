//
//  MapViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 29.07.2023.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    
    weak var coordinator: MapCoordinatable?
    private let locationManager = CLLocationManager()
    private var mapConfigurationState: MapConfigurationState = .state1
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var userLocationButton: MapStyleButton = {
        let button = MapStyleButton()
        button.imageSystemName = .locationCircle
        button.pressed = {
            self.userLocationButtonTapped()
        }
        return button
    }()
    
    lazy var movingToDirectionButton: MapStyleButton = {
        let button = MapStyleButton()
        button.imageSystemName = .flagCheckeredCircle
        button.pressed = {
            button.isActivated.toggle()
        }
        return button
    }()
    
    lazy var mapConfigurationButton: MapStyleButton = {
        let button = MapStyleButton()
        button.imageSystemName = .square3layers3dtopfilled
        button.pressed = {
            switch self.mapConfigurationState {
            case .state1:
                self.handleState1()
            case .state2:
                self.handleState2()
            case .state3:
                self.handleState3()
            }
        }
        return button
    }()
    
    lazy var clearAnnotationsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearAnnotationsButtonTapped))
        return button
    }()
    
    deinit {
        coordinator?.finish()
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        setupLocationManager()
        navigationItem.leftBarButtonItem = clearAnnotationsButton
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Map"
        
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(addAnnatationOnLongPress(gesture:)))
        longPress.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPress)
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func getDirection(to destenation: MKAnnotation) {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destenation.coordinate))
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate { [unowned self] response, error in
            guard let response = response else { return }
            guard let route = response.routes.first else { return }
            
            let edgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                           edgePadding: edgePadding,
                                           animated: true)
        }
    }
    
    private func handleState1() {
            self.mapConfigurationState = .state2

            if #available(iOS 16.0, *) {
                self.mapView.preferredConfiguration = MKHybridMapConfiguration()
            } else {
                self.mapView.mapType = .hybrid
            }

            self.mapConfigurationButton.imageSystemName = .square3layers3dmiddlefilled
        }

        private func handleState2() {
            self.mapConfigurationState = .state3

            if #available(iOS 16.0, *) {
                self.mapView.preferredConfiguration = MKImageryMapConfiguration()
            } else {
                self.mapView.mapType = .satellite
            }

            self.mapConfigurationButton.imageSystemName = .square3layers3dbottomfilled
        }

        private func handleState3() {
            self.mapConfigurationState = .state1

            if #available(iOS 16.0, *) {
                self.mapView.preferredConfiguration = MKStandardMapConfiguration()
            } else {
                self.mapView.mapType = .standard
            }

            self.mapConfigurationButton.imageSystemName = .square3layers3dtopfilled
        }

    
    //MARK: - Action
    
    private func userLocationButtonTapped() {
        locationManager.requestLocation()
    }
    
    @objc func clearAnnotationsButtonTapped() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    @objc func addAnnatationOnLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            let annatation = MKPointAnnotation()
            annatation.coordinate = coordinate
            self.mapView.addAnnotation(annatation)
            
            if movingToDirectionButton.isActivated {
                self.getDirection(to: annatation)
            }
        }
    }
    
    //MARK: - layout
    
    private func setupLayout() {
        view.addSubview(mapView)
        mapView.addSubview(userLocationButton)
        mapView.addSubview(movingToDirectionButton)
        mapView.addSubview(mapConfigurationButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        userLocationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(mapView).inset(20)
            make.size.equalTo(50)
        }
        
        movingToDirectionButton.snp.makeConstraints { make in
            make.trailing.equalTo(mapView).inset(20)
            make.bottom.equalTo(userLocationButton).offset(-60)
            make.size.equalTo(50)
        }
        
        mapConfigurationButton.snp.makeConstraints { make in
            make.bottom.equalTo(mapView).inset(20)
            make.trailing.equalTo(userLocationButton).offset(-60)
            make.size.equalTo(50)
        }
    }
}
