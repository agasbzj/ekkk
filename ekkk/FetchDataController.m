//
//  FetchDataController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FetchDataController.h"
#import "OneItem.h"

@implementation FetchDataController
@synthesize itemList = _itemList;

@synthesize fetchedResultsController=__fetchedResultsController;

@synthesize managedObjectContext=__managedObjectContext;

- (id)init {
    if ((self = [super init])) {
        ekkkAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _itemList = [[NSMutableArray alloc] initWithCapacity:20];
        __managedObjectContext = [appDelegate managedObjectContext];
        
    }
    return self;
}
- (void)dealloc {
    [_itemList release];
    [super dealloc];
}

- (void)saveContext {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)getDataByPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = __managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemDetail" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *oneObject in objects) {
        OneItem *one = [[[OneItem alloc] init] autorelease];
        one.city = [oneObject valueForKey:@"city"];
        one.area = [oneObject valueForKey:@"area"];
        one.category_Coarse = [oneObject valueForKey:@"category_Coarse"];
        one.category_Fine = [oneObject valueForKey:@"category_Fine"];
        one.seller = [oneObject valueForKey:@"seller"];
        one.discount = [oneObject valueForKey:@"discount"];
        one.telephone = [oneObject valueForKey:@"telephone"];
        one.latitude = [oneObject valueForKey:@"latitude"];
        one.longitude = [oneObject valueForKey:@"longitude"];
        one.hot = [oneObject valueForKey:@"hot"];
        [_itemList addObject:one];
    }
    [fetchRequest release];
}

- (void)getDataByKey:(NSString *)key isEqualToValue:(id)value {
    NSManagedObjectContext *context = __managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemDetail" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ = %@", key, value];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *oneObject in objects) {
        OneItem *one = [[[OneItem alloc] init] autorelease];
        one.city = [oneObject valueForKey:@"city"];
        one.area = [oneObject valueForKey:@"area"];
        one.category_Coarse = [oneObject valueForKey:@"category_Coarse"];
        one.category_Fine = [oneObject valueForKey:@"category_Fine"];
        one.seller = [oneObject valueForKey:@"seller"];
        one.discount = [oneObject valueForKey:@"discount"];
        one.telephone = [oneObject valueForKey:@"telephone"];
        one.latitude = [oneObject valueForKey:@"latitude"];
        one.longitude = [oneObject valueForKey:@"longitude"];
        one.hot = [oneObject valueForKey:@"hot"];
        [_itemList addObject:one];
    }
    [fetchRequest release];
    
    
}

//#pragma mark - Fetched results controller
//
//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (__fetchedResultsController != nil)
//    {
//        return __fetchedResultsController;
//    }
//    
//    /*
//     Set up the fetched results controller.
//     */
//    // Create the fetch request for the entity.
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemDetail" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:20];
//    
//    // Edit the sort key as appropriate.
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    // Edit the section name key path and cache name if appropriate.
//    // nil for section name key path means "no sections".
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
//    aFetchedResultsController.delegate = self;
//    self.fetchedResultsController = aFetchedResultsController;
//    
//    [aFetchedResultsController release];
//    [fetchRequest release];
//    [sortDescriptor release];
//    [sortDescriptors release];
//    
//	NSError *error = nil;
//	if (![self.fetchedResultsController performFetch:&error])
//    {
//	    /*
//	     Replace this implementation with code to handle the error appropriately.
//         
//	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
//	     */
//	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//	    abort();
//	}
//    
//    return __fetchedResultsController;
//}    


#pragma mark - Fetched results controller delegate

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch(type)
//    {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}

//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    UITableView *tableView = self.tableView;
//    
//    switch(type)
//    {
//            
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView endUpdates];
//}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


@end
