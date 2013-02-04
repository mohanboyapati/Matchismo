//
//  Deck.h
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void) addCard:(Card *) card atTop:(BOOL)atTop;
-(id)drawRandomCard;
@end
