//
//  TransactionSubmitResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bubichain. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionSubmitResult.h"

@interface TransactionSubmitResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) TransactionSubmitResult *result;

-(void)buildResponse:(int32_t)errorCode : (TransactionSubmitResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc : (TransactionSubmitResult *)result;
@end
