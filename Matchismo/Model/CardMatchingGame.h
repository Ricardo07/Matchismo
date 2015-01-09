//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ricardo Batista on 12/31/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//Designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck*)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card*)cardAtIndex:(NSUInteger)index;

@property(nonatomic,readonly) NSInteger score;
@property(nonatomic) BOOL matchTwoCards;
@property(nonatomic) BOOL gameStarted;
@property(strong,nonatomic) NSMutableArray *playsHistorial;

@end
