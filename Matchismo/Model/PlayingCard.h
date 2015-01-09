//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ricardo Batista on 12/27/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit; //suit
@property (nonatomic) NSUInteger rank;//rank

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
