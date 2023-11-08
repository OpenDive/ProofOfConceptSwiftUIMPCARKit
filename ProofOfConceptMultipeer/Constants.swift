//
//  Constants.swift
//  RizApp
//
//  Created by Marcus Arnett on 9/22/23.
//

import Foundation
import SwiftUI

struct RizzColors {
    static let rizzPink = Color("RizzPink")
    static let rizzBlue = Color("RizzBlue")
    static let rizzBlack = Color("RizzBlack")
    static let rizzWhite = Color("RizzWhite")
    static let rizzGray = Color("RizzGray")
    static let rizzLightGray = Color("RizzLightGray")
    static let rizzMatteBlack = Color("RizzMatteBlack")
    static let rizzNeonBlue = Color("RizzNeonBlue")
    static let rizzRed = Color("RizzRed")
    static let rizzGreen = Color("RizzGreen")
    static let rizzPurple = Color("RizzPurple")
}

struct RizzOnboarding {
    static let features: [FeatureItem] = [
        FeatureItem(
            icon: "Wallet",
            title: "Not another boring wallet",
            description: "Non-Fungible Network for Non-Fungible people. A social wallet with UX for creating, sharing, and showcasing static dynamic NFTs."
        ),
        FeatureItem(
            icon: "Tech",
            title: "Web3 at its core",
            description: "Interconnected, integrated, end to end experience. Created for artists, collectors and patrons.\n"
        ),
        FeatureItem(
            icon: "Connected",
            title: "Powered by DApps",
            description: "Immersive and engaging NFT experiences, Integrated blockchain technology, increase in utility across the platform."
        ),
        FeatureItem(
            icon: "Logo",
            title: "Track any Wallet",
            description: "Sign in below using WalletConnect."
        )
    ]
    
    static let discover: [Collection] = [
        Collection(title: "Bored Ape Yacht Club", logo: "BAYCLogo", NFTs: ["BAYC1"]),
        Collection(title: "Cool Cats", logo: "CoolCatLogo", NFTs: ["CoolCat1", "CoolCat2"]),
        Collection(title: "Robotos", logo: "RobotosLogo", NFTs: ["Robotos1"]),
        Collection(title: "Rare Pizza Boxes", logo: "PizzaBoxLogo", NFTs: ["PizzaBox1", "PizzaBox2", "PizzaBox3", "PizzaBox4", "PizzaBox5"]),
        Collection(title: "Real Punks", logo: "RealPunkLogo", NFTs: ["RealPunk1", "RealPunk2", "RealPunk3"])
    ]
    
    static let nftCollection: [String] = [
        "BAYC1",
        "CoolCat1", "CoolCat2",
        "Robotos1",
        "PizzaBox1", "PizzaBox2", "PizzaBox3", "PizzaBox4", "PizzaBox5",
        "RealPunk1", "RealPunk2", "RealPunk3"
    ]
}

struct Collection: Identifiable {
    let title: String
    let logo: String
    let NFTs: [String]
    let id = UUID().uuidString
}

struct FeatureItem: Hashable, Identifiable {
    let icon: String
    let title: String
    let description: String
    
    var id: String {
        return "\(self.icon)-\(self.title)-\(self.description)"
    }
}
