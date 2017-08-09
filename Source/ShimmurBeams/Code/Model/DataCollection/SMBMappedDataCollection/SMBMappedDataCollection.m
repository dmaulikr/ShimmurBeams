//
//  SMBMappedDataCollection.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection.h"
#import "SMBMutableMappedDataCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@interface SMBMappedDataCollection ()

#pragma mark - uniqueKey_to_mappableObject_mapping
@property (nonatomic, copy, nullable) NSDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>* uniqueKey_to_mappableObject_mapping;

@end





@implementation SMBMappedDataCollection

#pragma mark - init
-(nonnull instancetype)init_with_uniqueKey_to_mappableObject_mapping:(nullable NSDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping
{
	if (self = [self init])
	{
		[self setUniqueKey_to_mappableObject_mapping:uniqueKey_to_mappableObject_mapping];
	}

	return self;
}

-(nonnull instancetype)init_with_mappedDataCollection:(nullable SMBMappedDataCollection<id>*)mappedDataCollection
{
	return (self = [self init_with_uniqueKey_to_mappableObject_mapping:mappedDataCollection.uniqueKey_to_mappableObject_mapping]);
}

#pragma mark - objects
-(nullable NSArray<id>*)mappableObjects
{
	return self.uniqueKey_to_mappableObject_mapping.allValues;
}

-(nullable id)mappableObject_for_uniqueKey:(nonnull NSString*)uniqueKey
{
	kRUConditionalReturn_ReturnValueNil(uniqueKey == nil, YES);

	NSDictionary<NSString*,id<SMBMappedDataCollection_MappableObject>>* const uniqueKey_to_mappableObject_mapping = self.uniqueKey_to_mappableObject_mapping;
	kRUConditionalReturn_ReturnValueFalse(uniqueKey_to_mappableObject_mapping == nil, NO);

	return [uniqueKey_to_mappableObject_mapping objectForKey:uniqueKey];
}

-(BOOL)mappableObject_exists:(nonnull id<SMBMappedDataCollection_MappableObject>)mappableObject
{
	return ([self mappableObject_for_uniqueKey:[self mappableObject_uniqueKey:mappableObject]] != nil);
}

-(nullable NSString*)mappableObject_uniqueKey:(nonnull id<SMBMappedDataCollection_MappableObject>)mappableObject
{
	kRUConditionalReturn_ReturnValueFalse(mappableObject == nil, YES);

	NSString* const uniqueKey = [mappableObject smb_uniqueKey];
	kRUConditionalReturn_ReturnValueNil(uniqueKey == nil, YES);

	return uniqueKey;
}

#pragma mark - copy
-(nonnull SMBMappedDataCollection<id>*)copy
{
	return self;
}

-(nonnull SMBMutableMappedDataCollection<id>*)mutableCopy
{
	return [[SMBMutableMappedDataCollection<id> alloc] init_with_mappedDataCollection:self];
}

#pragma mark - gameBoardTilePosition
-(BOOL)isEqual_to_mappedDataCollection:(nullable SMBMappedDataCollection<id>*)mappedDataCollection
{
	kRUConditionalReturn_ReturnValueFalse(mappedDataCollection == nil, YES);
	kRUConditionalReturn_ReturnValueTrue(self == mappedDataCollection == false, NO);
	
	kRUConditionalReturn_ReturnValueFalse(__RUClassOrNilUtilFunction(mappedDataCollection, [self class]) == nil, YES);
	
	kRUConditionalReturn_ReturnValueFalse((self.uniqueKey_to_mappableObject_mapping != mappedDataCollection.uniqueKey_to_mappableObject_mapping)
										  &&
										  ([self.uniqueKey_to_mappableObject_mapping isEqual:mappedDataCollection.uniqueKey_to_mappableObject_mapping] == false), NO);
	
	return YES;
}

#pragma mark - changes
+(void)changes_from_mappedDataCollection:(nullable SMBMappedDataCollection<id>*)from_mappedDataCollection
				 to_mappedDataCollection:(nullable SMBMappedDataCollection<id>*)to_mappedDataCollection
						  removedObjects:(NSArray<id>*_Nullable * _Nonnull)removedObjects
							  newObjects:(NSArray<id>*_Nullable * _Nonnull)newObjects
{
	kRUConditionalReturn(removedObjects == nil, YES);
	kRUConditionalReturn(newObjects == nil, YES);

	NSMutableArray<id>* const removedObjects_mutable = [NSMutableArray<id> array];
	[[from_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([to_mappedDataCollection mappableObject_exists:obj] == false)
		{
			[removedObjects_mutable addObject:obj];
		}
	}];

	*removedObjects = [NSArray<id> arrayWithArray:removedObjects_mutable];

	NSMutableArray<id>* const newObjects_mutable = [NSMutableArray<id> array];
	[[to_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([from_mappedDataCollection mappableObject_exists:obj] == false)
		{
			[newObjects_mutable addObject:obj];
		}
	}];

	*newObjects = [NSArray<id> arrayWithArray:newObjects_mutable];
}

@end