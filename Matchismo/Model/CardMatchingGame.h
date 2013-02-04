//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"


@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) NSInteger score;
-(id)initWithCardCount:(NSUInteger)count
              usingDeck:(PlayingCardDeck *)deck;
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(PlayingCardDeck *)deck
           gamePlayMode:(NSUInteger)mode;
-(void)flipCardAtIndex:(NSUInteger)index;
- (PlayingCard *)cardAtIndex:(NSUInteger)index;

@property (strong, nonatomic)NSString *lastResult;
@end
