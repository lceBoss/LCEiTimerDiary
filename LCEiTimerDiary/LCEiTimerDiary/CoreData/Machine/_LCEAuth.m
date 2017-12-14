// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LCEAuth.m instead.

#import "_LCEAuth.h"

@implementation LCEAuthID
@end

@implementation _LCEAuth

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LCEAuth" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LCEAuth";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LCEAuth" inManagedObjectContext:moc_];
}

- (LCEAuthID*)objectID {
	return (LCEAuthID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic auth_id;

@end

@implementation LCEAuthAttributes 
+ (NSString *)auth_id {
	return @"auth_id";
}
@end

