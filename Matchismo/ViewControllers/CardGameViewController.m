//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ricardo Batista on 12/29/14.
//  Copyright (c) 2014 XdroneStudio. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *gameResultLabel;

@end

@implementation CardGameViewController


-(CardMatchingGame *)game{
    
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

-(Deck *)createDeck{ //abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self updateUI];
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    
    self.game.matchTwoCards =  sender.selectedSegmentIndex == 0 ? YES:NO;
}

- (IBAction)resetGame:(UIButton *)sender {
    
    self.game = nil;
    self.gameModeSegmentedControl.selectedSegmentIndex = 0;
    [self updateUI];
}

-(void)updateUI{
    
    for(UIButton* cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    self.gameResultLabel.text = [self.game.playsHistorial lastObject];
    
    self.gameModeSegmentedControl.enabled = !self.game.gameStarted;
}

-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}




@end
