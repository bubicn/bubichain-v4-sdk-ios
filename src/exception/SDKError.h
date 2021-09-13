//
//  SDKError.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SdkError) {
    SUCCESS = 0,
    ACCOUNT_CREATE_ERROR = 11001,
    INVALID_SOURCEADDRESS_ERROR,
    INVALID_DESTADDRESS_ERROR,
    INVALID_INITBALANCE_ERROR,
    SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR,
    INVALID_ADDRESS_ERROR,
    CONNECTNETWORK_ERROR,
    INVALID_ISSUE_AMOUNT_ERROR,
    NO_ASSET_ERROR,
    NO_METADATA_ERROR,
    INVALID_DATAKEY_ERROR,
    INVALID_DATAVALUE_ERROR,
    INVALID_DATAVERSION_ERROR,
    INVALID_MASTERWEIGHT_ERROR = 11015,
    INVALID_SIGNER_ADDRESS_ERROR,
    INVALID_SIGNER_WEIGHT_ERROR,
    INVALID_TX_THRESHOLD_ERROR,
    INVALID_TYPETHRESHOLD_TYPE_ERROR,
    INVALID_TYPE_THRESHOLD_ERROR,
    INVALID_ASSET_CODE_ERROR = 11023,
    INVALID_ASSET_AMOUNT_ERROR,
    INVALID_GAS_AMOUNT_ERROR = 11026,
    INVALID_ISSUER_ADDRESS_ERROR,
    NO_SUCH_TOKEN_ERROR = 11030,
    INVALID_TOKEN_NAME_ERROR,
    INVALID_TOKEN_SYMBOL_ERROR,
    INVALID_TOKEN_DECIMALS_ERROR,
    INVALID_TOKEN_TOTALSUPPLY_ERROR,
    INVALID_TOKENOWNER_ERROR,
    INVALID_TOKEN_SUPPLY_ERROR,
    INVALID_CONTRACTADDRESS_ERROR,
    CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR,
    INVALID_TOKEN_AMOUNT_ERROR,
    SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR,
    INVALID_FROMADDRESS_ERROR,
    FROMADDRESS_EQUAL_DESTADDRESS_ERROR,
    INVALID_SPENDER_ERROR,
    PAYLOAD_EMPTY_ERROR,
    INVALID_LOG_TOPIC_ERROR,
    INVALID_LOG_DATA_ERROR,
    INVALID_CONTRACT_TYPE_ERROR,
    INVALID_NONCE_ERROR,
    INVALID_GASPRICE_ERROR,
    INVALID_FEELIMIT_ERROR,
    OPERATIONS_EMPTY_ERROR,
    INVALID_CEILLEDGERSEQ_ERROR,
    OPERATIONS_ONE_ERROR,
    INVALID_SIGNATURENUMBER_ERROR,
    INVALID_HASH_ERROR,
    INVALID_BLOB_ERROR,
    PRIVATEKEY_NULL_ERROR,
    PRIVATEKEY_ONE_ERROR,
    SIGNDATA_NULL_ERROR,
    INVALID_BLOCKNUMBER_ERROR,
    PUBLICKEY_NULL_ERROR,
    URL_EMPTY_ERROR,
    CONTRACTADDRESS_CODE_BOTH_NULL_ERROR,
    INVALID_OPTTYPE_ERROR,
    GET_ALLOWANCE_ERROR,
    GET_TOKEN_INFO_ERROR,
    SIGNATURE_EMPTY_ERROR,
    CONNECTN_BLOCKCHAIN_ERROR = 19999,
    SYSTEM_ERROR = 20000,
    REQUEST_NULL_ERROR
};

@interface SDKError : NSObject
+(NSString *) getDescription: (NSInteger) errorCode;
@end
