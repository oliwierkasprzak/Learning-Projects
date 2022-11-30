//
//  DataPersitenceManager.swift
//  Netflix Clone
//
//  Created by Oliwier Kasprzak on 27/11/2022.
//

import CoreData
import Foundation
import UIKit


class DataPersistenceManager {
    
    enum DataBaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case faileToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Movies, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.id = Int64(model.id)
        item.overview = model.overview
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.poster_path = model.poster_path
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do {
         try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSaveData))
        }
        
        
    }
    
    func fetchingTitleFromDataBase(completion: @escaping(Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DataBaseError.failedToFetchData ))
        }
    }
    func deleteTitleWith(model: TitleItem, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faileToDeleteData))
        }
    }
}
