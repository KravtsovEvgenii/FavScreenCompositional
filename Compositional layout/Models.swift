//
//  Models.swift
//  Compositional layout
//
//  Created by User on 31.01.2021.
//

import UIKit
var formatter: DateFormatter{
    let df = DateFormatter()
    df.dateFormat = "MMM d, h:mm"
    return df
}

//MARK: Section
enum Section: Int, CaseIterable {
    case online
    case offline
    case announce
}
//MARK: Announce
struct Announce {
    var game: String
    var title: String
    var date: Date
    
    var stringDate: String {
        return formatter.string(from: self.date)
    }
}
//MARK: Stream
struct Stream: Hashable {
    var id: UUID
    var title: String
    var image: UIImage?
    var lastOnline: Date?
    var announce: Announce?
    var streamer: Streamer
    var game: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Stream, rhs: Stream) -> Bool {
        return lhs.id == rhs.id &&  lhs.title == rhs.title
    }
    
    init(id: UUID? = UUID(), title: String? = "Stream Title", image: UIImage? = nil, streamer: Streamer) {
        self.id = id!
        self.title = title!
        self.image = image
        self.streamer = streamer
        self.game = "Game Title"
    }
}
//MARK: Streamer
struct Streamer {
    let name: String
    let image: UIImage
}
//MARK: AllStreams
struct AllStreams {
    var onlineStreams: [Stream]
    var offlineStreams: [Stream]
    var announceStreams: [Stream]
    init(){
        onlineStreams = []
        offlineStreams = []
        announceStreams = []
    }
}
//MARK: Helper Methods
let streamerNamesArray = ["John", "TGW","Miker", "Hawk", "Foggy", "MisterWinner"]

 func makeStreams(count: Int)-> AllStreams {
    var allStreams = AllStreams()
    var overall = count
    let onlineCount = Int.random(in: 0...overall)
    overall -= onlineCount
    let offlineCount = Int.random(in: 0...overall)
    let announceCount = overall - offlineCount
    allStreams.onlineStreams = generateStreams(count: onlineCount)
    allStreams.offlineStreams = generateStreams(count: offlineCount)
    allStreams.announceStreams = generateStreams(count: announceCount,announce: true)
    
    return allStreams
}

fileprivate func generateStreams(count: Int, announce: Bool? = false) -> [Stream] {
    var streams: [Stream] = []
    for _ in 0..<count {
        
        let streamer = Streamer(name: streamerNamesArray.randomElement()!, image: getAvatarImage())
        var stream = Stream(streamer: streamer)
        stream.image = getStreamImage()
        if announce ?? false {stream.announce = generateAnnounce()}
        streams.append(stream)
    }
    return streams
}
fileprivate func getAvatarImage()-> UIImage {
    let array = ["beaver","brat", "ggl", "pekaPhone", "slow"]
    let string = array.randomElement()!
    return UIImage(named: string)!
}

fileprivate func getStreamImage()-> UIImage {
    let array = ["streamDog","streamGame","streamPainting","streamWitcher"]
    let string = array.randomElement()!
    return UIImage(named: string)!
}
fileprivate func generateAnnounce()-> Announce {
    let randomSeconds = Double.random(in: 7200...720000)
    let announce = Announce(game: "Game Title", title: "Stream title", date: Date().addingTimeInterval(randomSeconds))
    return announce
}
