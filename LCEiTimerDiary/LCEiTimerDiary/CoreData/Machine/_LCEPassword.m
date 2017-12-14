// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LCEPassword.m instead.

#import "_LCEPassword.h"

@implementation LCEPasswordID
@end

@implementation _LCEPassword

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LCEPassword" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LCEPassword";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LCEPassword" inManagedObjectContext:moc_];
}

- (LCEPasswordID*)objectID {
	return (LCEPasswordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic password;

@end

@implementation LCEPasswordAttributes 
+ (NSString *)password {
	return @"password";
}
@end

