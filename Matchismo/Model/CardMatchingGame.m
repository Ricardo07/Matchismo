//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ricardo Batista on 12/31/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (strong,nonatomic) NSMutableArray *cards;// of Cards
@property (strong,nonatomic) NSMutableArray *otherCardsToMatch;
@end

@implementation CardMatchingGame

-(NSMutableArray*)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)otherCardsToMatch{
    if(!_otherCardsToMatch) _otherCardsToMatch = [[NSMutableArray alloc] init];
    return _otherCardsToMatch;
}

-(NSMutableArray *)playsHistorial{
    if(!_playsHistorial){
        _playsHistorial = [[NSMutableArray alloc] init];
        [_playsHistorial addObject:@""];
    }
    return _playsHistorial;
}


-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init];//super's designated initializer
    
    if(self){
        for(int i=0;i < count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        self.gameStarted = NO;
        self.matchTwoCards = YES; //Default game mode
    }
    
    return self;
}

-(Card*)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index]:nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    
    
    if(!card.isMatched){
        
        if(card.isChosen){
            card.chosen = NO;
        }else{
            
            [self.playsHistorial addObject:[NSString stringWithFormat:@"%@",card.contents]];
            
            //match against other cards
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    if(![self.otherCardsToMatch containsObject:otherCard]){
                        [self.otherCardsToMatch addObject:otherCard];
                    }
                    
                    
                    if((self.matchTwoCards && ([self.otherCardsToMatch count] == 1)) ||
                       (!self.matchTwoCards && ([self.otherCardsToMatch count] == 2)))
                    {
                        int matchScore = [card match:self.otherCardsToMatch];
                        
                        //Making the string that contains the card on the last play
                        NSString *cardsPlayString = [NSString stringWithFormat:@"%@ ",card.contents];
                        for(Card *c in self.otherCardsToMatch){
                            cardsPlayString = [cardsPlayString stringByAppendingString:[NSString stringWithFormat:@"%@ ",c.contents]];
                        }
                        
                        if(matchScore){
                            self.score += matchScore * MATCH_BONUS;
                            
                            [self.playsHistorial addObject:[NSString stringWithFormat:@"Matched %@ for %d",cardsPlayString,matchScore * MATCH_BONUS]];
                            
                            //Set cards to matched
                            card.matched = YES;
                            for(Card *c in self.otherCardsToMatch){
                                c.matched = YES;
                            }
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            
                            [self.playsHistorial addObject:[NSString stringWithFormat:@"%@ don’t match! %d point penalty!",cardsPlayString, MISMATCH_PENALTY]];
                            
                            //Set cards to chosen
                            card.chosen = NO;
                            for(Card *c in self.otherCardsToMatch){
                                c.chosen = NO;
                            }
                        }
                        
                        self.otherCardsToMatch = nil;
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
    if(self.gameStarted == NO){
        self.gameStarted = YES;
    }
}



@end
