//
//  Movie.swift
//  Project_02
//
//  Created by Nam Hoang on 3/6/23.
//

import Foundation

// This is a struct for the movie model
struct Movie: Codable {
    let title: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
}

struct Response: Codable {
    let results: [Movie]
}

func parse(from jsonData: Data) -> Response? {
    do {
        let decodedData = try JSONDecoder().decode(Response.self, from: jsonData);
        print("test json");
        print(decodedData);
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

func mockData() -> [Movie]? {
    do {
        let fileUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!;
        let jsonData = try Data(contentsOf: fileUrl);
        // try parsing the json data
        let movies = parse(from: jsonData)!.results;
        return movies;
    }
    catch {
        print("error: \(error)")
    }
    return nil;

    
//    return [
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: "/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: "/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: "/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: "/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: "/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", popularity: 4969.06, vote_average: 6.6, vote_count: 778)
//    ];
    
//    do {
//        if let filePath = Bundle.main.path(forResource: "moviesDB", ofType: "json") {
//            let fileUrl = URL(fileURLWithPath: filePath)
//            let jsonData = try Data(contentsOf: fileUrl)
//            // try parsing the json data
//            let movies = parse(from: jsonData)!.results;
//            return movies;
//        }
//    } catch {
//        print("error: \(error)")
//    }
//    return nil
}

//// Extend the struct with one more property - the mock data
//extension Movie {
//    static var mockMovies: [Movie] = [
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: URL(string: "https://image.tmdb.org/t/p/w200/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdrop_path: URL(string: "https://image.tmdb.org/t/p/original/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: URL(string: "https://image.tmdb.org/t/p/w200/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdrop_path: URL(string: "https://image.tmdb.org/t/p/w300/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: URL(string: "https://image.tmdb.org/t/p/w200/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdrop_path: URL(string: "https://image.tmdb.org/t/p/w300/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: URL(string: "https://image.tmdb.org/t/p/w200/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdrop_path: URL(string: "https://image.tmdb.org/t/p/w300/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, popularity: 4969.06, vote_average: 6.6, vote_count: 778),
//        Movie(title: "Knock at the Cabin", overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", poster_path: URL(string: "https://image.tmdb.org/t/p/w200/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdrop_path: URL(string: "https://image.tmdb.org/t/p/w300/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, popularity: 4969.06, vote_average: 6.6, vote_count: 778)
//    ];
//}
