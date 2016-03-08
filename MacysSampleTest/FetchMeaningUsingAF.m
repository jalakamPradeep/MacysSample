//
//  FetchMeaningUsingAF.m
//  MacysSampleTest
//
//  Created by Jalakam, Pradeep on 3/8/16.
//  Copyright © 2016 Jalakam, Pradeep. All rights reserved.
//

#import "FetchMeaningUsingAF.h"
#import "AFNetworking.h"

static NSString * const kBaseUrl = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf";
static NSString * const kLongFormString = @"lfs";
static NSString * const kLongForm = @"lf";
static NSString * const kcontentType = @"text/plain";

@implementation FetchMeaningUsingAF

-(void)fetchMeaningsUsingAFNetworking:(NSString *)acronymsString
{
    NSString *urlString = [NSString stringWithFormat:@"%@=%@", kBaseUrl,acronymsString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableArray *meaningArray =[[NSMutableArray alloc]init];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *lfsArray = [(NSDictionary *)responseObject valueForKey:kLongFormString];
        for (int i =0; i < lfsArray.count; i++)
        {
            [meaningArray addObject:[lfsArray[i] valueForKey:kLongForm]];
        }
        if (meaningArray.count > 0)
        {
            [self.delegate fetchCompleted:[meaningArray copy][0]];
        }
        else
        {
            [self.delegate fetchCompleted:@[@"No meaning found"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self.delegate fetchCompleted:@[@"Please enter valid text"]];
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    // 5
    [operation start];
}

@end
