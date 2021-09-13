//
//  TransactionEvaluateFeeResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionEvaluateFeeResult.h"

@interface TransactionEvaluateFeeResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) TransactionEvaluateFeeResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionEvaluateFeeResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionEvaluateFeeResult *)result;
@end
