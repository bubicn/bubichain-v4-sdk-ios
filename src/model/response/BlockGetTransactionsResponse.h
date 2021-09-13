//
//  BlockGetTransactionsResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetTransactionsResult.h"

@interface BlockGetTransactionsResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockGetTransactionsResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetTransactionsResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetTransactionsResult *)result;
@end
