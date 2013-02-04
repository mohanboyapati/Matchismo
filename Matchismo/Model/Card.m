//
//  Card.m
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@implementation Card

-(NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    for (Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (NSString *)description {
    return self.contents;
}
@end
