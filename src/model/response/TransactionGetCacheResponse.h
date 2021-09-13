//
//  TransactionGetCacheResponse.h
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionGetCacheResult.h"

@interface TransactionGetCacheResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) TransactionGetCacheResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionGetCacheResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionGetCacheResult *)result;
@end
