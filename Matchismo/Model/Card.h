//
//  Card.h
//  Matchismo
//
//  Created by MOHAN BOYAPATI on 1/31/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
-(NSInteger) match:(NSArray *) otherCards;
@end
