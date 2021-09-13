//
//  TransactionGetCacheResult.h
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionHistory.h"

@interface TransactionGetCacheResult : NSObject
@property (nonatomic, assign) int64_t totalCount;
@property (nonatomic, strong) NSArray *transactions;
@end
