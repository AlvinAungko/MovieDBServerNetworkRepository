//
//  ActorModelLayer.swift
//  Module4Project
//
//  Created by Alvin  on 25/03/2022.
//

import Foundation

class ActorModelLayer:BaseNetworkAgent
{
    static let actorModelLayer = ActorModelLayer()
    
}

extension ActorModelLayer:ActorProtocol
{
    func fetchTheActorList(page: Int, completion: @escaping (MDBResponse<ActorDataModel>) -> Void) {
        networkAgent.fetchTheActorList(page: page, completion: completion)
    }
    
    func fetchTheDetailOfTheActor(actorID: Int, completion: @escaping (MDBResponse<ActorDetailDataModel>) -> Void) {
        networkAgent.fetchTheDetailOfTheActor(actorID: actorID, completion: completion)
    }
    
    func fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID: Int, completion: @escaping (MDBResponse<ActorCombinedMovie>) -> Void) {
        networkAgent.fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID: actorID, completion: completion)
    }
    
    
}
