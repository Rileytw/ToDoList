//
//  DailyQuoteWrapper.m
//  ToDoList
//
//  Created by Lei on 2023/5/17.
//

#import <Foundation/Foundation.h>
#import "DailyQuoteWrapper.h"
#import "daily_quote.hpp"

@implementation DailyQuoteWrapper
- (NSString *)getDailyQuote {
    DailyQuote dailyQuote;
    return [NSString stringWithUTF8String: dailyQuote.Get().c_str()];
}

@end

