//
//  HomeAPI.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import Foundation

struct WellnessAppData {
    var imageURI: URL
    var title: String
    var description: String
}

struct StrikeData {
    var number: Int
    var label: String
}

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
    var userStrikes: [StrikeData]
    var wellnessApps: [WellnessAppData]
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

            let strikesData = [
                StrikeData(number: 290, label: "check-ins"),
                StrikeData(number: 2, label: "day streak"),
                StrikeData(number: 25, label: "facilities"),
                StrikeData(number: 18, label: "neighborhoods"),
                StrikeData(number: 5, label: "cities"),
            ]

            let wellnessData = [
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/S76GphUu2pZa249td2Bb4XAhLcPRrFdL1zp_5qU1ouukvRq9r0-8jJ-CruaTtdT6g84=s360-rw")!, title: "Calm", description: "Sleep, Meditation and Relaxation"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/j-ZV144PlVuTVsLuBzIKyEw9CbFnmWw9ku2NJ1ef0gZJh-iiIN1nrNPmAtvgAteyDqU=s360-rw")!, title: "Strava", description: "Track activity & map routes"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/xbF2DUtTeEB7E4wy0hArgj2QoxlufPiXei72K9t_1PdfFmM-ws-zrJAB7ODRwGU8smg=s360-rw")!, title: "Lifesum", description: "Get happier and helthier through better eating"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/3FGXUY3twWiTEoppfutcIzgLT6LUwHgsQmYAkkUqTj6U_c4zHyy_dffYwu_0SavPvmjb=s360-rw")!, title: "Meditopia", description: "Inner peace through meditation, sleep stories and relaxing songs"),
                WellnessAppData(imageURI: URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Purple125/v4/73/bb/0c/73bb0c39-d33b-72d1-d7db-4148187c891b/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/350x350.png")!, title: "Fabuluous", description: "Build heathier habits with your own personal coach and hapiness trainer"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/gA1EnzqYkjI6vLLOm3JGbK4bcWKchJQ5eXhr8cHQ_HDGtrLyyDi7NPMka_N9l__9lzY=s360-rw")!, title: "Neou", description: "Solo & family workouts"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/K67cfyPh1HTQf91sZV7-O6uhTZJhXeZ3EsnvvAQQ4hT0gUJQTZtZ8dx4wLffQgNpo-c=s360-rw")!, title: "Yogaia", description: "Strenghten your body and mind"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/dRzgjaDIvpDETOQZt0qrhY5HNd1ckQJM37S4xTsxau-KK0k1we4s-qh4zDpN47vs8tCK=s360-rw")!, title: "BTFIT", description: "Online on-demand fitness powered by Bodytech"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/WyrPH1z2CmQhf7f9AaWM0FDLF32lFLVUz9w4aQTFaoc3KfZYNmVdSui9e9Ihvq5gYw=s360-rw")!, title: "ZenApp", description: "Meditation & Personal Development"),
                WellnessAppData(imageURI: URL(string: "https://play-lh.googleusercontent.com/yBKuVfq8LV_1VcDK1jJTTKGZLuht0KRYEPRx4NDLd5bDo6RiZhvEdsoypTlfe5am2Q=s360-rw")!, title: "Wellness Coach", description: "Mind, body and sleep"),
            ]

            let homeData = HomeData(userData: userData, banners: bannersData, userStrikes: strikesData, wellnessApps: wellnessData)
            
            completionHandler(homeData)
        }
    }

}
