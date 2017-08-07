//
//  SMBMutableMappedDataCollection.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMutableMappedDataCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBMutableMappedDataCollection ()

#pragma mark - uniqueKey_to_mappableObject_mapping
@property (nonatomic, copy, nullable) NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>* uniqueKey_to_mappableObject_mapping;

-(nonnull NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping_createIfNeeded;
-(nonnull NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping_create;

@end





@implementation SMBMutableMappedDataCollection

-(void)mappableObject_add:(nonnull id<SMBMappedDataCollection_MappableObject>)mappableObject
{
	kRUConditionalReturn(mappableObject == nil, YES);

	NSString* const uniqueKey = [self mappableObject_uniqueKey:mappableObject];
	kRUConditionalReturn(uniqueKey == nil, YES);
	kRUConditionalReturn([self mappableObject_for_uniqueKey:uniqueKey], YES);

	NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>* const uniqueKey_to_mappableObject_mapping = self.uniqueKey_to_mappableObject_mapping_createIfNeeded;

	[uniqueKey_to_mappableObject_mapping setObject:mappableObject forKey:uniqueKey];
}

-(void)mappableObject_remove:(nonnull id<SMBMappedDataCollection_MappableObject>)mappableObject
{
	kRUConditionalReturn(mappableObject == nil, YES);

	NSString* const uniqueKey = [self mappableObject_uniqueKey:mappableObject];
	kRUConditionalReturn(uniqueKey == nil, YES);
	kRUConditionalReturn([self mappableObject_for_uniqueKey:uniqueKey] == nil, YES);

	NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>* const uniqueKey_to_mappableObject_mapping = self.uniqueKey_to_mappableObject_mapping;
	kRUConditionalReturn(uniqueKey_to_mappableObject_mapping == nil, YES);

	[uniqueKey_to_mappableObject_mapping removeObjectForKey:uniqueKey];
}

#pragma mark - uniqueKey_to_mappableObject_mapping
@synthesize uniqueKey_to_mappableObject_mapping = _uniqueKey_to_mappableObject_mapping;
-(void)setUniqueKey_to_mappableObject_mapping:(NSMutableDictionary<NSString *,id<SMBMappedDataCollection_MappableObject>> *)uniqueKey_to_mappableObject_mapping
{
	kRUConditionalReturn((self.uniqueKey_to_mappableObject_mapping == uniqueKey_to_mappableObject_mapping)
						 ||
						 [self.uniqueKey_to_mappableObject_mapping isEqual:uniqueKey_to_mappableObject_mapping], NO);

	_uniqueKey_to_mappableObject_mapping =
	(uniqueKey_to_mappableObject_mapping
	 ?
	 [NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>> dictionaryWithDictionary:uniqueKey_to_mappableObject_mapping]
	 :
	 nil
	);
	
}
-(nonnull NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping_createIfNeeded
{
	return (self.uniqueKey_to_mappableObject_mapping
			?:
			[self uniqueKey_to_mappableObject_mapping_create]);
}

-(nonnull NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping_create
{
	[self setUniqueKey_to_mappableObject_mapping:[NSMutableDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>> dictionary]];
	NSAssert(self.uniqueKey_to_mappableObject_mapping != nil, @"Shouldn't be nil");

	return self.uniqueKey_to_mappableObject_mapping;
}

#pragma mark - copy
-(nonnull SMBMappedDataCollection<id>*)copy
{
	return [[SMBMappedDataCollection<id> alloc] init_with_mappedDataCollection:self];
}

@end
