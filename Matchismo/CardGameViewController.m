//
//  CardGameViewController.m
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)deal:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayMode;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic, strong) NSMutableArray *moveHistory;
@end

@implementation CardGameViewController

- (NSMutableArray *) moveHistory
{
    if (!_moveHistory) _moveHistory = [[NSMutableArray alloc] init];
    return _moveHistory;
}


-(CardMatchingGame *)game
{
     NSUInteger mode = self.gamePlayMode.selectedSegmentIndex + 2;
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]usingDeck:[[PlayingCardDeck alloc] init] gamePlayMode:mode];
    }

    return _game;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    int index = (int) sender.value;
    
    if (index < 0 || (index > self.flipCount - 1)) return;
    
    if (index < self.flipCount-1)
        self.resultLabel.alpha = 0.3;
    else
        self.resultLabel.alpha = 1.0;
    
    self.resultLabel.text = [self.moveHistory objectAtIndex: index];
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons
                                             indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        
        if (card.isFaceUp)
        {
            [cardButton setImage:nil
                        forState:UIControlStateNormal];
        } else {
            [cardButton setImage:[UIImage imageNamed:@"deckback.png"]
                        forState:UIControlStateNormal];
//           cardButton.layer.cornerRadius = 10;
//           cardButton.layer.masksToBounds = YES;
        }
        
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultLabel.text = self.game.lastResult;
    [self.historySlider setMinimumValue:0.0f];
    [self.historySlider setMaximumValue:(float) self.flipCount];
}
-(void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    //NSLog(@"flips update to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    
    [self.gamePlayMode setEnabled:NO];
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
    [self.historySlider setValue:self.flipCount animated:NO];
    self.resultLabel.alpha = 1.0;
    [self.moveHistory addObject:self.game.lastResult];

}


- (IBAction)deal:(id)sender {
    [self.gamePlayMode setEnabled:YES];
    self.game = nil;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: 0"];
    
    self.moveHistory = nil;
    self.flipCount = 0;
    
    [self updateUI];

}
- (IBAction)changeGameMode:(id)sender {
    self.game = nil;
    self.flipCount = 0;
}

@end




