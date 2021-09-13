//
//  BlockRewardJsonResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockRewardJsonResult.h"

@interface BlockRewardJsonResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockRewardJsonResult *result;
@end
