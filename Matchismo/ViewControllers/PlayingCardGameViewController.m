//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Ricardo Batista on 1/9/15.
//  Copyright (c) 2015 XdroneStudio. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end
