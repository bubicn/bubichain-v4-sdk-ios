//
//  TransactionGetCacheResult.m
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import "TransactionGetCacheResult.h"
#import "YYModelClass.h"

@implementation TransactionGetCacheResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"totalCount" : @"total_count"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transactions" : [TransactionHistory class]};
}
@end
