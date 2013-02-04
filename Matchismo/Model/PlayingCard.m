//
//  PlayingCard.m
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()
@end

@implementation PlayingCard
@synthesize suit = _suit; // because we provided getter AND setter

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void) setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+(NSUInteger)maxRank
{
    return [self rankStrings].count -1;
}
-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if(otherCard.rank == self.rank) {
            score = 4;
        }
    }else if ([otherCards count] == 2) {
        PlayingCard *firstOtherCard = [otherCards objectAtIndex:0];
        PlayingCard *secondOtherCard = [otherCards objectAtIndex:1];
        if ([firstOtherCard.suit isEqualToString:self.suit] &&
            [secondOtherCard.suit isEqualToString:self.suit]) {
            score = 2;
        } else if ( (firstOtherCard.rank == self.rank) &&
                   (secondOtherCard.rank == self.rank)) {
            score = 8;
        }
    }
    return score;
}

@end
