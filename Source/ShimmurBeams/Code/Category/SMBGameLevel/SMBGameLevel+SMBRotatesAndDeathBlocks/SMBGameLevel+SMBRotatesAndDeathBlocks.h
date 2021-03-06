//
//  SMBGameLevel+SMBRotatesAndDeathBlocks.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBRotatesAndDeathBlocks)

#pragma mark - rotates
+(nonnull instancetype)smb_rotates_oneRotate_right;
+(nonnull instancetype)smb_rotates_two_left;

#pragma mark - rotates and forced
+(nonnull instancetype)smb_rotates_oneRight_forced_oneRight;

#pragma mark - rotates and wall
+(nonnull instancetype)smb_rotates_oneLeft_twoRight_wall_oneCenter;

#pragma mark - rotates and death blocks
+(nonnull instancetype)smb_rotates_twoRight_deathBlock_one;
+(nonnull instancetype)smb_rotates_twoRight_twoLeft_deathBlocks_surrounded_and_someBlocking;
+(nonnull instancetype)smb_rotates_deathBlocks_blackAnglesMatter;
+(nonnull instancetype)smb_rotates_deathBlocks_scattered;

@end
