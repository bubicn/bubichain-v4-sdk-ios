//
//  AccountGetNonceResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountGetNonceResult.h"

@interface AccountGetNonceResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) AccountGetNonceResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountGetNonceResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetNonceResult *)result;
@end
