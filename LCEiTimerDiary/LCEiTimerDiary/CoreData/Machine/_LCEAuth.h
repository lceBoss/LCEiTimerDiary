// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LCEAuth.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface LCEAuthID : NSManagedObjectID {}
@end

@interface _LCEAuth : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LCEAuthID *objectID;

@property (nonatomic, strong, nullable) NSString* auth_id;

@end

@interface _LCEAuth (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveAuth_id;
- (void)setPrimitiveAuth_id:(nullable NSString*)value;

@end

@interface LCEAuthAttributes: NSObject 
+ (NSString *)auth_id;
@end

NS_ASSUME_NONNULL_END
