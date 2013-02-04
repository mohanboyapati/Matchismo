//
//  Deck.m
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

-(NSMutableArray *) cards
{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}
- (void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if(card) {
        if(atTop) {
            [self.cards insertObject:card atIndex:0];
        }else {
            [self.cards addObject:card];
        }
    }
}

-(id)drawRandomCard
{
    id randomCard = nil;
    if(self.cards.count) {
        NSUInteger index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
