//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property(strong, nonatomic) NSMutableArray *cards;
@property(readwrite, nonatomic) NSInteger score;
@property (nonatomic) NSInteger gamePlayMode;
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards
{
    if(!_cards) {
        _cards = [NSMutableArray array];
    }
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(PlayingCardDeck *)deck
{
    self = [ super init];
    if(self) {
        for(NSInteger i = 0; i < count; i++) {
            PlayingCard *card = [deck drawRandomCard];
            if(card) {
                self.cards[i] = card;
    // NSLog(@"card adding at %d", [self.cards count]);
            } else {
                self = nil;
                break;
            }
        }
        
    }
    return self;
}
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(PlayingCardDeck *)deck
           gamePlayMode:(NSUInteger)mode
{
    self = [super init];
    
    if (self) {
        self.gamePlayMode = mode;
        self = [self initWithCardCount:count
                             usingDeck:deck];
    }
    return self;
}


- (PlayingCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS_2_CARD 4
#define MATCH_BONUS_3_CARD 8

-(void)flipCardAtIndex:(NSUInteger)index
{
    PlayingCard *card = [self cardAtIndex:index];
    if (self.gamePlayMode == 2)
    {
        if(card && !card.isUnplayable){
            if(!card.isFaceUp){
                self.lastResult = [[NSString alloc] initWithFormat:@"Flipped up %@", card];
                for(PlayingCard *otherCard in self.cards) {
                    if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                        int matchScore = [card match:@[otherCard]];
                       // NSLog(@"MatchScore = %d", matchScore);
                        if(matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS_2_CARD;
                            self.lastResult = [[NSString alloc] initWithFormat:@"2 Card Matched %@ & %@ for %d points", card, otherCard, matchScore * MATCH_BONUS_2_CARD];
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.lastResult = [[NSString alloc] initWithFormat:@"%@ & %@ don't match! %d point penalty!", card, otherCard, MISMATCH_PENALTY];

                        }
                        break;
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.isFaceUp;
        }
    }else if (self.gamePlayMode == 3) {
        if (card && !card.isUnplayable) {
            if (!card.isFaceUp) {
                NSString *flipResult = nil;
                NSMutableArray *otherFaceUpCards = [[NSMutableArray alloc] init];
                
                for (PlayingCard *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [otherFaceUpCards addObject:otherCard];
                    }
                }
                
                if (otherFaceUpCards.count == 0) {
                } else {
                    if (otherFaceUpCards.count == 1) {
                        // we just flipped the 2nd card
                        int matchScore = [card match:otherFaceUpCards];
                        if (matchScore) {
                            // The frist 2 match
                        } else {
                            PlayingCard *otherCard = [otherFaceUpCards objectAtIndex:0];
                            otherCard.faceUp = NO;
                        }
                    } else if (otherFaceUpCards.count == 2) {
                        int matchScore = [card match:otherFaceUpCards];
                        if (matchScore) {
                            card.unplayable = YES;
                            PlayingCard *otherCard0 = [otherFaceUpCards objectAtIndex:0];
                            otherCard0.unplayable = YES;
                            PlayingCard *otherCard1 = [otherFaceUpCards objectAtIndex:1];
                            otherCard1.unplayable = YES;
                            
                            self.score += matchScore * MATCH_BONUS_3_CARD;
                            int bonus = matchScore * MATCH_BONUS_3_CARD;
                            flipResult = [NSString stringWithFormat:@"3Card Matched %@ & %@ & %@ for %d points", card.contents, otherCard0.contents, otherCard1.contents, bonus];
                        } else {
                            Card *otherCard0 = [otherFaceUpCards objectAtIndex:0];
                            otherCard0.faceUp = NO;
                            Card *otherCard1 = [otherFaceUpCards objectAtIndex:1];
                            otherCard1 = NO;
                        }
                    }
                }
                
                if (flipResult == nil) {
                    flipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
                self.lastResult = flipResult;
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.faceUp;
        }
    }
}
@end
