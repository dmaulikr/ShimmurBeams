//
//  SMBDiagonalMirrorTileEntity.m
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDiagonalMirrorTileEntity.h"





@interface SMBDiagonalMirrorTileEntity ()

#pragma mark - draw_startingPoint
-(CGFloat)draw_startingPoint_x_forFrame:(CGRect)frame;
-(CGFloat)draw_startingPoint_y_forFrame:(CGRect)frame;

#pragma mark - draw_endingPoint
-(CGFloat)draw_endingPoint_x_forFrame:(CGRect)frame;
-(CGFloat)draw_endingPoint_y_forFrame:(CGRect)frame;

#pragma mark - mirrorTileEntity_draw_in_rect
-(void)mirrorTileEntity_draw_in_rect:(CGRect)rect;

#pragma mark - paddingFromEdge
+(CGFloat)paddingFromEdge_forRect:(CGRect)rect;

@end





@implementation SMBDiagonalMirrorTileEntity

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];
	
	[self mirrorTileEntity_draw_in_rect:rect];
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
	return [self init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_topLeft];
}

#pragma mark - init
-(nullable instancetype)init_with_startingPosition:(SMBDiagonalMirrorTileEntity_startingPosition)startingPosition
{
	if (self = [super init])
	{
		_startingPosition = startingPosition;
	}
	
	return self;
}

#pragma mark - mirrorTileEntity_draw_in_rect
-(void)mirrorTileEntity_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);
	
	CGPoint const point_start = (CGPoint){
		.x  = [self draw_startingPoint_x_forFrame:rect],
		.y  = [self draw_startingPoint_y_forFrame:rect],
	};
	
	CGPoint const point_end = (CGPoint){
		.x  = [self draw_endingPoint_x_forFrame:rect],
		.y  = [self draw_endingPoint_y_forFrame:rect],
	};
	
	CGContextMoveToPoint(context,
						 point_start.x,
						 point_start.y);
	
	CGContextAddLineToPoint(context,
							point_end.x,
							point_end.y);
	
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
}

#pragma mark - draw_startingPoint
-(CGFloat)draw_startingPoint_x_forFrame:(CGRect)frame
{
	return CGRectGetMinX(frame) + [[self class]paddingFromEdge_forRect:frame];
}

-(CGFloat)draw_startingPoint_y_forFrame:(CGRect)frame
{
	CGFloat const padding = [[self class]paddingFromEdge_forRect:frame];
	return (self.startingPosition == SMBDiagonalMirrorTileEntity_startingPosition_topLeft ? CGRectGetMinY(frame) + padding : CGRectGetMaxY(frame) - padding);
}

#pragma mark - draw_endingPoint
-(CGFloat)draw_endingPoint_x_forFrame:(CGRect)frame
{
	return CGRectGetMaxX(frame) - [[self class]paddingFromEdge_forRect:frame];;
}

-(CGFloat)draw_endingPoint_y_forFrame:(CGRect)frame
{
	CGFloat const padding = [[self class]paddingFromEdge_forRect:frame];
	return (self.startingPosition == SMBDiagonalMirrorTileEntity_startingPosition_topLeft ? CGRectGetMaxY(frame) - padding : CGRectGetMinY(frame) + padding);
}

#pragma SMBGeneralBeamExitDirectionRedirectTileEntity
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	SMBGameBoardTile__direction const enterDirection = beamEnterDirection;
	BOOL const topLeftToBottomRight = (self.startingPosition == SMBDiagonalMirrorTileEntity_startingPosition_topLeft);
	
	switch (enterDirection)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;
			
		case SMBGameBoardTile__direction_down:
			return (topLeftToBottomRight ? SMBGameBoardTile__direction_left : SMBGameBoardTile__direction_right);
			break;
			
		case SMBGameBoardTile__direction_up:
			return (topLeftToBottomRight ? SMBGameBoardTile__direction_right : SMBGameBoardTile__direction_left);
			break;
			
		case SMBGameBoardTile__direction_right:
			return (topLeftToBottomRight ? SMBGameBoardTile__direction_up : SMBGameBoardTile__direction_down);
			break;
			
		case SMBGameBoardTile__direction_left:
			return (topLeftToBottomRight ? SMBGameBoardTile__direction_down : SMBGameBoardTile__direction_up);
			break;
	}
	
	NSAssert(false, @"unhandled type %li", (long) enterDirection);
	return SMBGameBoardTile__direction_left;
}

#pragma mark - paddingFromEdge
+(CGFloat)paddingFromEdge_forRect:(CGRect)rect
{
	return CGRectGetWidth(rect) / 5.0f;
}

@end
