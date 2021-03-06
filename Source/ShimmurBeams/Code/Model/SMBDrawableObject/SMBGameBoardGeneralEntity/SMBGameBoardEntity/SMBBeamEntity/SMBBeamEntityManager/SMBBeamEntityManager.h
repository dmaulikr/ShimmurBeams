//
//  SMBBeamEntityManager.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBBeamEntity;





/**
 A beam entity should be added to `forMarkingNodesReady` when it's got nodes to mark ready.
 Once a beam entity in the `forMarkingNodesReady` queue becomes the `beamEntity_forMarkingNodesReady` property, it should only leave when it's done, when is defined as when it meets all of the following conditions:
 1. It's finished marking it's nodes as ready.
 2. It's not currently trying to generate any new nodes.
 */
@interface SMBBeamEntityManager : NSObject

#pragma mark - beamEntity_forMarkingNodesReady
@property (nonatomic, readonly, strong, nullable) SMBBeamEntity* beamEntity_forMarkingNodesReady;
-(void)beamEntity_forMarkingNodesReady_add:(nonnull SMBBeamEntity*)beamEntity;
-(void)beamEntity_forMarkingNodesReady_remove:(nonnull SMBBeamEntity*)beamEntity;
-(BOOL)beamEntity_forMarkingNodesReady_exists:(nonnull SMBBeamEntity*)beamEntity;

#pragma mark - singleton
+(nonnull instancetype)sharedInstance;

@end





@interface SMBBeamEntityManager_PropertiesForKVO : NSObject

+(nonnull NSString*)beamEntity_forMarkingNodesReady;

@end
