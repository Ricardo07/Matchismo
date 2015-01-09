//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ricardo Batista on 12/27/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards{
    
    int score = 0;
    
    if([otherCards count] == 1){
        
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        }else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }else if([otherCards count] == 2){
        
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *othercard2 = [otherCards lastObject];
        
        //Evaluating ranks
        if(self.rank == otherCard1.rank == othercard2.rank){
            score = 12;
        }else if(self.rank == otherCard1.rank ||
                 self.rank == othercard2.rank ||
                 otherCard1.rank == othercard2.rank)
        {
            score = 4;
        }
        
        //Evaluating suits
        if([self.suit isEqualToString:otherCard1.suit] &&
           [self.suit isEqualToString:othercard2.suit]){
            score = 8;
        }else if([self.suit isEqualToString:otherCard1.suit] ||
                 [self.suit isEqualToString:othercard2.suit] ||
                 [otherCard1.suit isEqualToString:othercard2.suit])
        {
            score = 4;
        }
    }
    
    return score;
}


- (NSString *)contents{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}

@synthesize suit = _suit;// Because we provide setter AND getter

- (void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}


+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank{
    return [[PlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
