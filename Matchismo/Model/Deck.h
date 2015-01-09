//
//  Deck.h
//  Matchismo
//
//  Created by Ricardo Batista on 12/27/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card*)card atTop:(BOOL)atTop;
-(void)addCard:(Card*)card;

-(Card*)drawRandomCard;

@end
