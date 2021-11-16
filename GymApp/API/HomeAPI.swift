//
//  HomeAPI.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import Foundation

struct BannerDestination {
    let tab: String
    let route: String
    let bag: [String: Any]?

    init?(path: String, params: [String: Any]? = nil) {
        let tokens = path.split(separator: "/")

        self.tab = String(tokens[0])
        self.route = String(tokens[1])
        self.bag = params
    }
}

struct BannerData {
    var title: String
    var description: String
    var callToAction: String
    var callToActionFontColor: String
    var backgroundColor: String
    var backgroundImageName: String
    var characterImageName: String
    var destination: BannerDestination?
}

struct UserData {
    var photoURI: URL
    var shortName: String
    var plan: String
    var gymappID: String
}

struct HomeData {
    var userData: UserData
    var banners: [BannerData]
}

class HomeAPI {

    func getHomeInfo(for userAuthentication: Authentication,
                           completionHandler: @escaping (HomeData) -> Void,
                           failureHandler: @escaping () -> Void) {
        let responseTime = 2.5 // seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + responseTime) {
            // do the http request passing the user token
            
            let photoURI = URL(string: "https://user-images.githubusercontent.com/13206745/114415754-5c378f00-9b86-11eb-996d-4d42858ad3c1.jpeg")
            let userData = UserData(photoURI: photoURI!, shortName: "Rafael", plan: "GymApp - Platinum", gymappID: "19009160440663")
                    
            let bannersData: [BannerData] = [
                BannerData(title: "Personal training",
                           description: "Discover dedicated support to ensure you reach your goals.",
                           callToAction: "Get started",
                           callToActionFontColor: "Elm",
                           backgroundColor: "Skeptic",
                           backgroundImageName: "GreenStarsTexture",
                           characterImageName: "TrainerCharacter",
                           destination: BannerDestination(path: "/explore/root",
                                                          params: ["ref": "personal-training"])),
                BannerData(title: "Dependents",
                           description: "Enjoy GymApp with your family",
                           callToAction: "See dependents",
                           callToActionFontColor: "BlueViolet",
                           backgroundColor: "MoonRaker",
                           backgroundImageName: "PurpleCirclesTexture",
                           characterImageName: "BadmintonCharacter",
                           destination: BannerDestination(path: "/home/dependents")),
                BannerData(title: "Interactive group classes",
                           description: "Join a group class and stay active at home!",
                           callToAction: "Check schedule",
                           callToActionFontColor: "HavelockBlue",
                           backgroundColor: "LinkWater",
                           backgroundImageName: "VideoIconsTexture",
                           characterImageName: "DancingCharacter",
                           destination: BannerDestination(path: "/explore/root",
                                                          params: ["ref": "group-classes"]))
            ]

            let homeData = HomeData(userData: userData, banners: bannersData)
            completionHandler(homeData)
        }
    }

}