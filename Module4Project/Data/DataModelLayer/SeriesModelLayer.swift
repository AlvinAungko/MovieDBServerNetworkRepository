//
//  SeriesModelLayer.swift
//  Module4Project
//
//  Created by Alvin  on 25/03/2022.
//

import Foundation

class SeriesModelLayer:BaseNetworkAgent
{
    static let seriesModelLayer = SeriesModelLayer()
}

extension SeriesModelLayer:SeriesProtocol
{
    func fetchPopularSeries(completion: @escaping (MDBResponse<PopulaBestrSeries>) -> Void) {
        networkAgent.fetchPopularSeries(completion: completion)
    }
    
    func fetchTheSerieDetail(seriesID: Int, completion: @escaping (MDBResponse<SeriesDetail>) -> Void) {
        networkAgent.fetchTheSerieDetail(seriesID: seriesID, completion: completion)
    }
    
    func fetchTheCastAccordingToTheSeriesID(seriesID: Int, completion: @escaping (MDBResponse<CreditDataModel>) -> Void) {
        networkAgent.fetchTheCastAccordingToTheSeriesID(seriesID: seriesID, completion: completion)
    }
    
    func fetchTheTvTrailers(seriesID: Int, completion: @escaping (MDBResponse<TVTrailer>) -> Void) {
        networkAgent.fetchTheTvTrailers(seriesID: seriesID, completion: completion)
    }
    
    func searchTheSeries(seriesName: String, page: Int, completion: @escaping (MDBResponse<PopulaBestrSeries>) -> Void) {
        networkAgent.searchTheSeries(seriesName: seriesName, page: page, completion: completion)
    }
    
    
}
