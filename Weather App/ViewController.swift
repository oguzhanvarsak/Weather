//
//  ViewController.swift
//  Weather App
//
//  Created by Oğuzhan Varsak on 27.06.2020.
//  Copyright © 2020 Oğuzhan Varsak. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet var backgroudView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var daysView: UIView!
    
    
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var dateLbl2: UILabel!
    @IBOutlet weak var dateLbl3: UILabel!
    @IBOutlet weak var dateLbl4: UILabel!
    @IBOutlet weak var dateLbl5: UILabel!
    
    @IBOutlet weak var tempLbl1: UILabel!
    @IBOutlet weak var tempLbl2: UILabel!
    @IBOutlet weak var tempLbl3: UILabel!
    @IBOutlet weak var tempLbl4: UILabel!
    @IBOutlet weak var tempLbl5: UILabel!
    
    @IBOutlet weak var weatherImg1: UIImageView!
    @IBOutlet weak var weatherImg2: UIImageView!
    @IBOutlet weak var weatherImg3: UIImageView!
    @IBOutlet weak var weatherImg4: UIImageView!
    @IBOutlet weak var weatherImg5: UIImageView!
    
    @IBOutlet weak var splashImage: UIImageView!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var middleHourBGView: UIView!
    
    @IBOutlet weak var leftHourLbl: UILabel!
    @IBOutlet weak var leftTempLbl: UILabel!
    
    @IBOutlet weak var middleHourLbl: UILabel!
    @IBOutlet weak var middleTempLbl: UILabel!
    
    @IBOutlet weak var rightHourLbl: UILabel!
    @IBOutlet weak var rightTempLbl: UILabel!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    var locationManager: CLLocationManager?
    var currentHour : String?
    var currentDay = 0
    var nextDayShort = [String]()

    var weather = WeatherAPI()
    let storyBoardEdit = StoryboardEditor()
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
           switch CLLocationManager.authorizationStatus() {
                case .restricted, .denied:
                    let alert = UIAlertController(title: "Locations servies are disabled!", message: "Please go to settings and allow location services or the application can't fetch weather data.", preferredStyle: .alert)
                   
                    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }

                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    }
                   
                   alert.addAction(settingsAction)
                   let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                   alert.addAction(cancelAction)

                   self.present(alert, animated: true, completion: nil)
            
                case .authorizedAlways, .authorizedWhenInUse:
                   print("Access")
            
                @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysView.layer.cornerRadius = 10
        daysView.layer.shadowOpacity = 0.5
        daysView.layer.shadowOffset = .zero
        daysView.layer.shadowRadius = 10
        
        middleView.layer.cornerRadius = 25
        middleHourBGView.layer.cornerRadius = 10
        
        let now = Date()
        let formatter = DateFormatter()
        let hour = Calendar.current.component(.hour, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM dd,YYYY EEEE"
        let dateString = formatter.string(from: now)
        
        dateLbl.text = dateString
        currentHour = String(hour)
        currentDay = day
        
        let formatter2 = DateFormatter()
        
        for n in 1..<6 {
            var dayComponent = DateComponents()
            dayComponent.day = n
            let theCalendar = Calendar.current
            let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
            formatter2.dateFormat = "EE"
            let nextDaySh = formatter2.string(from: nextDate! as Date)
            self.nextDayShort.append(nextDaySh)
        }
        
        DispatchQueue.main.async {
            self.dateLbl1.text = self.nextDayShort[0].uppercased()
            self.dateLbl2.text = self.nextDayShort[1].uppercased()
            self.dateLbl3.text = self.nextDayShort[2].uppercased()
            self.dateLbl4.text = self.nextDayShort[3].uppercased()
            self.dateLbl5.text = self.nextDayShort[4].uppercased()
        }
        
        if (hour > 5 && hour < 21) {
            backgroudView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            timeView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            daysView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)

        } else {
            backgroudView.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.09411764706, blue: 0.3058823529, alpha: 1)
            timeView.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.09411764706, blue: 0.3058823529, alpha: 1)
            cityLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tempLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            daysView.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            leftHourLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            leftTempLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            rightHourLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            rightTempLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            middleTempLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        weather.getWeather(lat: location.latitude, lon: location.longitude) { weather in
            DispatchQueue.main.async {
                self.cityLbl.text  = weather.city.name
                self.tempLbl.text  = "\(Int(round(weather.list[0].main.temp)) - 273)°"
                self.tempLbl1.text = "\(Int(round(weather.list[1].main.temp)) - 273)°"
                self.tempLbl2.text = "\(Int(round(weather.list[2].main.temp)) - 273)°"
                self.tempLbl3.text = "\(Int(round(weather.list[3].main.temp)) - 273)°"
                self.tempLbl4.text = "\(Int(round(weather.list[4].main.temp)) - 273)°"
                self.tempLbl5.text = "\(Int(round(weather.list[5].main.temp)) - 273)°"
                
                self.splashImage.isHidden = true
            }
            
            
            var dayId = [String]()
            for x in 1..<6 {
                
                dayId.append("\(weather.list[x].weather[0].id)")
                let dayIdInt = Int(dayId[x-1])!
                let imageIDName = self.storyBoardEdit.editWeatherIcons(dayIDInt: dayIdInt)
                
                switch x {
                case 1:
                    DispatchQueue.main.async {
                        self.weatherImg1.image = UIImage(named: imageIDName)
                    }
                case 2:
                    DispatchQueue.main.async {
                        self.weatherImg2.image = UIImage(named: imageIDName)
                    }
                case 3:
                    DispatchQueue.main.async {
                        self.weatherImg3.image = UIImage(named: imageIDName)
                    }
                case 4:
                    DispatchQueue.main.async {
                        self.weatherImg4.image = UIImage(named: imageIDName)
                    }
                case 5:
                    DispatchQueue.main.async {
                        self.weatherImg5.image = UIImage(named: imageIDName)
                    }
                default:
                    break
                }
            }
            
            var hours = [String]()
            var temperatures = [String]()
            var icons = [String]()
            
            for k in 0..<3 {
                let date = Date(timeIntervalSince1970: TimeInterval(weather.list[k].dt))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH"
                dateFormatter.timeZone = .current
                hours.append(dateFormatter.string(from: date))
                
                temperatures.append("\(Int(round(weather.list[k].main.temp)) - 273)°")
                icons.append(self.storyBoardEdit.editWeatherIcons(dayIDInt: weather.list[k].weather[0].id) + " big")
            }
            
            
            
            DispatchQueue.main.async {
                self.middleHourLbl.text = hours[1] + ":00"
                self.leftHourLbl.text = hours[0] + ":00"
                self.rightHourLbl.text = hours[2] + ":00"
                
                self.middleTempLbl.text = temperatures[1]
                self.leftTempLbl.text = temperatures[0]
                self.rightTempLbl.text = temperatures[2]
                
                self.middleImage.image = UIImage(named: icons[1])
                self.leftImage.image = UIImage(named: icons[0])
                self.rightImage.image = UIImage(named: icons[2])
                
                
                print(icons)
            }
        }
    }
}
