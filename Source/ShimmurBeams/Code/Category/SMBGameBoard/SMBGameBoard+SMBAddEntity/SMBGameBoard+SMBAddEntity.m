//
//  SMBGameBoard+SMBAddEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoard (SMBAddEntity)

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	
	SMBGameBoardTile* const gameBoardTile =
	[self gameBoardTile_at_position:[[SMBGameBoardTilePosition alloc] init_with_column:column row:row]];
	
	[gameBoardTile gameBoardTileEntities_add:gameBoardTileEntity];
}

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)gameBoardTileEntity_for_beamInteractions_set:(nonnull SMBGameBoardTileEntity*)moveableGameBoardTileEntity
										  to_column:(NSUInteger)column
												row:(NSUInteger)row
{
	kRUConditionalReturn(moveableGameBoardTileEntity == nil, YES);
	
	SMBGameBoardTile* const gameBoardTile =
	[self gameBoardTile_at_position:[[SMBGameBoardTilePosition alloc] init_with_column:column row:row]];

	[gameBoardTile setGameBoardTileEntity_for_beamInteractions:moveableGameBoardTileEntity];
}

@end