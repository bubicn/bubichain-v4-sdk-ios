//
//  TransactionGetCacheRequest.h
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionGetCacheRequest : NSObject {
@private
    NSString *_hash;
}

- (void) setHash : (NSString *)hash;
- (NSString *) getHash;

@end
