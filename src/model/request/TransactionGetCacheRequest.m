//
//  TransactionGetCacheRequest.m
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import "TransactionGetCacheRequest.h"

@implementation TransactionGetCacheRequest
- (void) setHash : (NSString *)hash {
    _hash = hash;
}
- (NSString *) getHash {
    return _hash;
}
@end
