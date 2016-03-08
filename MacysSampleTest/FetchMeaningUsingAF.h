//
//  FetchMeaningUsingAF.h
//  MacysSampleTest
//
//  Created by Jalakam, Pradeep on 3/8/16.
//  Copyright © 2016 Jalakam, Pradeep. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchedMeaningDelegate <NSObject>

@required
- (void) fetchCompleted:(NSArray *)meaningArray;

@end

@interface FetchMeaningUsingAF : NSObject

@property (nonatomic,weak) id <FetchedMeaningDelegate> delegate;

-(void)fetchMeaningsUsingAFNetworking:(NSString *)acronymsString ;

@end
