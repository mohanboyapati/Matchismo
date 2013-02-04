//
//  PlayingCard.h
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+(NSArray *)rankStrings;
+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
