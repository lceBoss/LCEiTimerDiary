// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LCEPassword.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface LCEPasswordID : NSManagedObjectID {}
@end

@interface _LCEPassword : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LCEPasswordID *objectID;

@property (nonatomic, strong, nullable) NSString* account;

@property (nonatomic, strong, nullable) NSString* password;

@end

@interface _LCEPassword (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveAccount;
- (void)setPrimitiveAccount:(nullable NSString*)value;

- (nullable NSString*)primitivePassword;
- (void)setPrimitivePassword:(nullable NSString*)value;

@end

@interface LCEPasswordAttributes: NSObject 
+ (NSString *)account;
+ (NSString *)password;
@end

NS_ASSUME_NONNULL_END
