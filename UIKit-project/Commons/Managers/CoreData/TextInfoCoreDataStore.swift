//
//  TextInfoCoreDataStore.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import CoreData

final class TextInfoCoreDataStore: TextInfoStoreProtocol {
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }
    
    func exists(_ item: TextInfoData) throws -> Bool {
        let ctx = stack.viewContext
        let request: NSFetchRequest<TextInfoEntity> = TextInfoEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %@", item.stableId)
        
        return try ctx.count(for: request) > 0
    }
    
    func save(_ item: TextInfoData) throws {
        let context = stack.newBackgroundContext()

        try context.performAndWait {
            let request: NSFetchRequest<TextInfoEntity> = TextInfoEntity.fetchRequest()
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "id == %@", item.stableId)
            
            let entity = try context.fetch(request).first ?? TextInfoEntity(context: context)
            entity.id = item.stableId
            entity.title = item.title
            entity.author = item.author
            entity.genre = item.genre
            entity.content = item.content
            entity.createdAt = entity.createdAt ?? Date()
            
            if context.hasChanges {
                try context.save()
            }
        }
    }
    
    func fetchAll() throws -> [TextInfoData] {
        let ctx = stack.viewContext
        let request: NSFetchRequest<TextInfoEntity> = TextInfoEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        let results = try ctx.fetch(request)
        return results.map {
            TextInfoData(
                title: $0.title,
                author: $0.author,
                genre: $0.genre,
                content: $0.content
            )
        }
    }
    
    func deleteAll() throws {
        let ctx = stack.newBackgroundContext()

        try ctx.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TextInfoEntity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            deleteRequest.resultType = .resultTypeObjectIDs

            let result = try ctx.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs],
                                                    into: [stack.viewContext])
            }
        }
    }
}
