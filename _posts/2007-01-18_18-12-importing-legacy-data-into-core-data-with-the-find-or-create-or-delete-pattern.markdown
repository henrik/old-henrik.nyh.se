--- 
wordpress_id: 96
title: Importing legacy data into Core Data with the find-or-create (or delete) pattern
tags: 
- OS X
- Cocoa
---
I'm currently playing with Objective-C/Cocoa, writing an improved (and <abbr title="Graphical User Interface">GUI</abbr>'d up) version of <a href="http://henrik.nyh.se/?s=iCalTV">iCalTV</a>.

I'm learning a great deal. Core Data, the modelling/persistence framework, is interesting and daunting.

The <a href="http://developer.apple.com/documentation/Cocoa/Conceptual/CoreData/">Core Data Programming Guide</a> has a chapter on <a href="http://developer.apple.com/documentation/Cocoa/Conceptual/CoreData/index.html?http://developer.apple.com/documentation/Cocoa/Conceptual/CoreData/Articles/cdImporting.html">Efficiently Importing Legacy Data</a>.

That chapter gives examples on implementing the "find-or-create" pattern &ndash; when you want to compare some fresh data (e.g. recently downloaded TV channel lists) with stored Core Data (e.g. channel entity objects) and (efficiently) <em>add</em> whatever items weren't in Core Data already, and only <em>update</em> those that already were.

Apple's sample code ends after creating a list of identifiers for the new items, and a list of the old items.

I filled in the blanks, and modified the code to "find (and update)-or-create-or-remove". That is: if the identifier is already represented in Core Data, <em>update</em> some of its attributes (but maintain the identifier and relations); if the identifier is not represented, <em>create</em> a new object; if there are identifiers in Core Data that are not represented among the new items, <em>remove</em> those objects.

I also generalized it into a method on <code>NSManagedObjectContext</code> (using a category), so that I can use it both when importing channels and when importing programs, without duplicate code.

Hopefully this is of use to someone else.

<!--more-->

The usage is simply

{% highlight c %}
NSError *error;
[myManagedObjectContext updateEntity: @"Channel"
                      fromDictionary: channelsToImport
                      withIdentifier: @"identifier"
                         overwriting: [NSArray arrayWithObject:@"baseURL"]
                            andError: &error];
{% endhighlight %}

where <code>channelsToImport</code> is a dictionary with the identifiers as keys, and dictionaries as values. Those nested dictionaries have attribute names as keys and attribute values as values. So, in pseudo-code (actually Ruby ;p):

{% highlight text %}
{"channel.123" => {"displayName" => "Some Channel", "baseURL" => "http://www.example.com/"}}
{% endhighlight %}

If the identifier is <em>not</em> already represented in Core Data, those are the attributes (along with the identifier) that will be written. The <code>overwriting:</code> argument is an array of strings, enumerating the attributes that will be updated from the dictionary if the identifier <em>is</em> already represented in Core Data. 

Identifiers are assumed to be strings. The error variable will be populated with any errors that occur when fetching the entities.

I did not add support for passing a predicate to limit the entities you want, since I will always want to compare to the full set of channels, but it could be easily done, and I may do so later, if the need arises.

The code (<a href="http://henrik.nyh.se/uploads/NSManagedObjectContext_UpdateEntity.h">download</a>, don't forget to <code>#import</code> the file):

{% highlight c %}
@interface NSManagedObjectContext (UpdateEntity)
- (void)updateEntity:(NSString *)entity fromDictionary:(NSDictionary *)importDict withIdentifier:(NSString *)identifier overwriting:(NSArray *)overwritables andError:(NSError **)error;
@end

@implementation NSManagedObjectContext (UpdateEntity)

/*
  Expects an import dictionary like
  {"some.channel.se" => {"displayName" => "Some Channel", "baseURL" => "http://www.example.com/"}}.
*/

- (void)updateEntity:(NSString *)entity fromDictionary:(NSDictionary *)importDict withIdentifier:(NSString *)identifier overwriting:(NSArray *)overwritables andError:(NSError **)error {

  // Get the sorted import identifiers
  NSArray *identifiersToImport = [[importDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
  
  // Get the entities as managed objects
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  [fetchRequest setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self]];
  [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:identifier ascending:YES] autorelease]]];
  
  NSArray *managedObjects = [self executeFetchRequest:fetchRequest error:error];
  [fetchRequest release];
  
  // Compare import identifiers with managed object identifiers

  NSEnumerator* importIterator = [identifiersToImport objectEnumerator];
  NSEnumerator* objectIterator = [managedObjects objectEnumerator];
  NSString *thisImportIdentifier = [importIterator nextObject];
  NSManagedObject *thisObject = [objectIterator nextObject];

  // Loop through both lists, comparing identifiers, until both are empty
  while (thisImportIdentifier || thisObject) {

    // Compare identifiers 
    NSComparisonResult comparison;
    if (!thisImportIdentifier) {  // If the import list has run out, the import identifier sorts last (i.e. remove remaining objects)
      comparison = NSOrderedDescending;
    } else if (!thisObject) {  // If managed object list has run out, the import identifier sorts first (i.e. add remaining objects)
      comparison = NSOrderedAscending;
    } else {  // If neither list has run out, compare with the object 
      comparison = [thisImportIdentifier compare:[thisObject valueForKey:identifier]];
    }
    
    if (comparison == NSOrderedSame) {  // Identifiers match
      
      if (overwritables) {  // Merge the allowed non-identifier properties, if not nil
        NSDictionary *importAttributes = [importDict objectForKey:thisImportIdentifier];
        NSDictionary *overwriteAttributes = [NSDictionary dictionaryWithObjects:[importAttributes objectsForKeys:overwritables notFoundMarker:@""] forKeys:overwritables];

        [thisObject setValuesForKeysWithDictionary:overwriteAttributes]; 
      }
      
      // Move ahead in both lists
      thisObject = [objectIterator nextObject];
      thisImportIdentifier = [importIterator nextObject];
    
    } else if (comparison == NSOrderedAscending) {  // Imported item sorts before stored item
    
      // The imported item is previously unseen - add it and move ahead to the next import identifier
      
      NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self];
      [newObject setValue:thisImportIdentifier forKey:identifier];
      [newObject setValuesForKeysWithDictionary:[importDict objectForKey:thisImportIdentifier]];
      thisImportIdentifier = [importIterator nextObject];
      
    } else {  // Imported item sorts after stored item
    
      // The stored item is not among those imported, and should be removed, then move ahead to the next stored item

      [self deleteObject:thisObject];
      thisObject = [objectIterator nextObject];

    }
  }
}

@end
{% endhighlight %}
