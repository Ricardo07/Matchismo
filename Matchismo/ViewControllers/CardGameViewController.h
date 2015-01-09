//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ricardo Batista on 12/29/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

//Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//Protect
//for subclasses
-(Deck *)createDeck; //abstract

@end
