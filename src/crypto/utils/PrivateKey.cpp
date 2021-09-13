/*
	bubi is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	bubi is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with bubi.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "ecdsa.h"
#include "rsa.h"
#include "ripemd.h"
#include "PrivateKey.h"
#include "my_crypto.h"
#include "random.h"
#include "strings.h"
#include "sm3.h"
#include "ecc_sm2.h"


utils::Mutex PrivateKeyBase::lock_;
uint32_t KeypairUtils::keypair_version_ = KEYPAIR_VERSION_V4;
std::string KeypairUtils::RESERVED_CREATOR_ADDRESS = "";
std::string KeypairUtils::CONTRACT_DPOS_ADDRESS = "";
std::string KeypairUtils::RESERVED_ADDRESS4 = "";
std::string KeypairUtils::RESERVED_ADDRESS5 = "";
std::string KeypairUtils::RESERVED_ADDRESS6 = "";
std::string KeypairUtils::RESERVED_ADDRESS7 = "";
std::string KeypairUtils::RESERVED_ADDRESS8 = "";

//buchain::PublicKey pub_key;
//pub_key.Init(buchain::SIGNTYPE_ED25519, "1");
//std::string account1 = pub_key.GetEncAddress();   //a001ff5a3f5747ada4eaa22f1d49c01e52ddb7875b4bf5
//printf("1:%s\n",account1.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "2");
//std::string account2 = pub_key.GetEncAddress();  //a0018b9b5d03019c07d8b6c51f90da3a666eec13ab35c5
//printf("2:%s\n", account2.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "3");
//std::string account3 = pub_key.GetEncAddress();  //a001decfe3ad16b72230967de01f640b7e4729b49fce4d
//printf("3:%s\n", account3.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "4");
//std::string account4 = pub_key.GetEncAddress();  //a00148641d02b4d121d3fd328cb08b5531fcacdabf8a60
//printf("4:%s\n", account4.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "5");
//std::string account5 = pub_key.GetEncAddress();  //a001e54b0c619a1f22327b2ebbcfbec78f5564afe39d2e
//printf("5:%s\n", account5.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "6");
//std::string account6 = pub_key.GetEncAddress();  //a001174fd76f7d0216b612387a5ffcfb81e6f091968320
//printf("6:%s\n", account6.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "7");
//std::string account7 = pub_key.GetEncAddress();  //a00101726517e86b22c56a189f7625a6da49081b24510e
//printf("7:%s\n", account7.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "8");
//std::string account8 = pub_key.GetEncAddress();  //a001310aca000a0df6ac8b66b696d90ef06fdefb64a3e1
//printf("8:%s\n", account8.c_str());

//buchain::KeypairUtils::InitKeypairVersion(buchain::KEYPAIR_VERSION_V4);
//
//buchain::PublicKey pub_key;
//pub_key.Init(buchain::SIGNTYPE_ED25519, "1");
//std::string account1 = pub_key.GetEncAddress();   //adxSrQivns8D9411RyFV5xDqeFQ5dmGwe8mJk
//printf("1:%s\n", account1.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "2");
//std::string account2 = pub_key.GetEncAddress();  //adxSfriYsVg4rT1Z5nvESqxdB5c6nK3x2JTBZ
//printf("2:%s\n", account2.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "3");
//std::string account3 = pub_key.GetEncAddress();  //adxSoSfZNbiWeXKwyWqT5kSQ6jaX5PiEq1NYK
//printf("3:%s\n", account3.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "4");
//std::string account4 = pub_key.GetEncAddress();  //adxSZjK6bTewSPVY2PHzkFSMDKVqNogxdk45x
//printf("4:%s\n", account4.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "5");
//std::string account5 = pub_key.GetEncAddress();  //adxSp2w9kj4SKL5RfxGdUqNMdyBkYu3i7XTrM
//printf("5:%s\n", account5.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "6");
//std::string account6 = pub_key.GetEncAddress();  //adxSVFohGprJY7HNfJj1jHm53KcUaBDZiAWKi
//printf("6:%s\n", account6.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "7");
//std::string account7 = pub_key.GetEncAddress();  //adxSTGCDry6C4PusWhhGDSDXUVN9EWFp4pcKk
//printf("7:%s\n", account7.c_str());
//pub_key.Init(buchain::SIGNTYPE_ED25519, "8");
//std::string account8 = pub_key.GetEncAddress();  //adxSXBrYQmrkymjLBaHDgHGsjCr4FLPg8CfHj
//printf("8:%s\n", account8.c_str());

void KeypairUtils::InitKeypairVersion(uint32_t type) {
    keypair_version_ = type;
    if (type == KEYPAIR_VERSION_V4){
        KeypairUtils::RESERVED_CREATOR_ADDRESS = "adxSfKHhuKpP14t9soDVhiFRmyBJLvuckzbMU"; // If you want to create a dpos contract, pleas change this address or ask the admin for private key.
        KeypairUtils::CONTRACT_DPOS_ADDRESS = "adxSrQivns8D9411RyFV5xDqeFQ5dmGwe8mJk";
        KeypairUtils::RESERVED_ADDRESS4 = "adxSfriYsVg4rT1Z5nvESqxdB5c6nK3x2JTBZ";
        KeypairUtils::RESERVED_ADDRESS5 = "adxSoSfZNbiWeXKwyWqT5kSQ6jaX5PiEq1NYK";
        KeypairUtils::RESERVED_ADDRESS6 = "adxSZjK6bTewSPVY2PHzkFSMDKVqNogxdk45x";
        KeypairUtils::RESERVED_ADDRESS7 = "adxSp2w9kj4SKL5RfxGdUqNMdyBkYu3i7XTrM";
        KeypairUtils::RESERVED_ADDRESS8 = "adxSVFohGprJY7HNfJj1jHm53KcUaBDZiAWKi";
        return;
    }

    KeypairUtils::RESERVED_CREATOR_ADDRESS = "a001eee916cf33f9c81be320bd6c7bb6f8af478fa50a6d"; // If you want to create a dpos contract, pleas change this address or ask the admin for private key.
    KeypairUtils::CONTRACT_DPOS_ADDRESS = "a001ff5a3f5747ada4eaa22f1d49c01e52ddb7875b4bf5";
    KeypairUtils::RESERVED_ADDRESS4 = "a0018b9b5d03019c07d8b6c51f90da3a666eec13ab35c5";
    KeypairUtils::RESERVED_ADDRESS5 = "a001decfe3ad16b72230967de01f640b7e4729b49fce4d";
    KeypairUtils::RESERVED_ADDRESS6 = "a00148641d02b4d121d3fd328cb08b5531fcacdabf8a60";
    KeypairUtils::RESERVED_ADDRESS7 = "a001e54b0c619a1f22327b2ebbcfbec78f5564afe39d2e";
    KeypairUtils::RESERVED_ADDRESS8 = "a001174fd76f7d0216b612387a5ffcfb81e6f091968320";
}


std::string KeypairUtils::EncodeAddress(const std::string& address){
    switch (keypair_version_) {
    case KEYPAIR_VERSION_V3: return utils::String::BinToHexString(address);
    case KEYPAIR_VERSION_V4: return utils::Base58::Encode(address);
    }
    return "";
}
std::string KeypairUtils::DecodeAddress(const std::string& address){
    switch (keypair_version_) {
    case KEYPAIR_VERSION_V3: return utils::String::HexStringToBin(address);
    case KEYPAIR_VERSION_V4: return utils::Base58::Decode(address);
    }
    return "";
}
std::string KeypairUtils::EncodePublicKey(const std::string& key){
    return utils::String::BinToHexString(key);
}

std::string KeypairUtils::DecodePublicKey(const std::string& key){
    return utils::String::HexStringToBin(key);
}
std::string KeypairUtils::EncodePrivateKey(const std::string& key){
    switch (keypair_version_) {
    case KEYPAIR_VERSION_V3: return utils::String::BinToHexString(key);
    case KEYPAIR_VERSION_V4: return utils::Base58::Encode(key);
    }
    return "";
}
std::string KeypairUtils::DecodePrivateKey(const std::string& key){
    switch (keypair_version_) {
    case KEYPAIR_VERSION_V3: return utils::String::HexStringToBin(key);
    case KEYPAIR_VERSION_V4: return utils::Base58::Decode(key);
    }
    return "";
}

std::string KeypairUtils::CalcHash(const std::string &value, const SignatureType &sign_type) {
    std::string hash;
    if (sign_type == SIGNTYPE_CFCASM2) {
        hash = utils::Sm3::Crypto(value);
    }
    else {
        hash = utils::Sha256::Crypto(value);
    }
    return hash;
}

bool KeypairUtils::GetPublicKeyElement(const std::string &encode_pub_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data){
    std::string buff = DecodePublicKey(encode_pub_key);
    if (buff.size() < 6)
        return false;

    uint8_t a = (uint8_t)buff.at(0);
    uint8_t b = (uint8_t)buff.at(1);
    
    PrivateKeyPrefix prefix_tmp = (PrivateKeyPrefix)a;
    if (prefix_tmp != PUBLICKEY_PREFIX)
        return false;

    SignatureType sign_type_tmp = (SignatureType)b;
    size_t datalen = buff.size() - 6;

    bool ret = true;
    switch (sign_type_tmp) {
    case SIGNTYPE_ED25519:{
        ret = (ED25519_PUBLICKEY_LENGTH == datalen);
        break;
    }
    case SIGNTYPE_CFCASM2:{
        ret = (SM2_PUBLICKEY_LENGTH == datalen);
        break;
    }
    default:
        ret = false;
    }

    if (ret){
        //Check checksum
        std::string checksum = buff.substr(buff.size() - 4);
        std::string hash1 = CalcHash(buff.substr(0, buff.size() - 4), sign_type_tmp);
        std::string hash2 = CalcHash(hash1, sign_type_tmp);
        if (checksum.compare(hash2.substr(0, 4)))
            return false;

        prefix = prefix_tmp;
        sign_type = sign_type_tmp;
        raw_data = buff.substr(2, buff.size() - 6);
    }
    return ret;
}

bool KeypairUtils::GetKeyElement(const std::string &encode_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data) {
    PrivateKeyPrefix prefix_tmp;
    SignatureType sign_type_tmp = SIGNTYPE_NONE;
    std::string buff = DecodeAddress(encode_key);
    if (buff.size() == 27 && (uint8_t)buff.at(0) == 0XF8 && (uint8_t)buff.at(1) == 0XE1){// Address
        prefix_tmp = ADDRESS_PREFIX;
    }
    else if (buff.size() == 41 && (uint8_t)buff.at(0) == 0XDA && (uint8_t)buff.at(1) == 0X37 && (uint8_t)buff.at(2) == 0X9F){//private key
        prefix_tmp = PRIVATEKEY_PREFIX;
    }
    else{
        return false;
    }
    
    bool ret = true;
    if (prefix_tmp == ADDRESS_PREFIX) {
        uint8_t a = (uint8_t)buff.at(2);
        sign_type_tmp = (SignatureType)a;
        size_t datalen = buff.size() - 7;
        switch (sign_type_tmp) {
        case SIGNTYPE_ED25519:{
            ret = (ED25519_ADDRESS_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_CFCASM2:{
            ret = (SM2_ADDRESS_LENGTH == datalen);
            break;
        }
        default:
            ret = false;
        }
    }
    else if (prefix_tmp == PRIVATEKEY_PREFIX) {
        uint8_t a = (uint8_t)buff.at(3);
        sign_type_tmp = (SignatureType)a;
        size_t datalen = buff.size() - 9;
        switch (sign_type_tmp) {
        case SIGNTYPE_ED25519:{
            ret = (ED25519_PRIVATEKEY_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_CFCASM2:{
            ret = (SM2_PRIVATEKEY_LENGTH == datalen);
            break;
        }
        default:
            ret = false;
        }
    }
    else {
        ret = false;
    }

    if (ret){
        //Checksum
        std::string checksum = buff.substr(buff.size() - 4);
        std::string hash1 = CalcHash(buff.substr(0, buff.size() - 4), sign_type_tmp);
        std::string hash2 = CalcHash(hash1, sign_type_tmp);
        if (checksum.compare(hash2.substr(0, 4)))
            return false;

        prefix = prefix_tmp;
        sign_type = sign_type_tmp;
        if (prefix_tmp == ADDRESS_PREFIX) {
            raw_data = buff.substr(3, buff.size() - 7);
        }
        else if (prefix_tmp == PRIVATEKEY_PREFIX) {
            raw_data = buff.substr(4, buff.size() - 9);
        }
    }

    return ret;
}

bool KeypairUtils::GetKeyElementV3(const std::string &base16_pub_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data) {
    std::string buff = utils::String::HexStringToBin(base16_pub_key);
    if (buff.size() < 3) {
        return false;
    }

    uint8_t a = (uint8_t)buff.at(0);
    uint8_t b = (uint8_t)buff.at(1);
    //check sum
    PrivateKeyPrefix prefix_tmp = (PrivateKeyPrefix)a;
    SignatureType sign_type_tmp = (SignatureType)b;
    size_t datalen = buff.size() - 3;
    uint8_t checksum = (uint8_t)buff.back();
    uint8_t calc_checksum = utils::Crc8((uint8_t *)buff.c_str(), buff.length() - 1);
    if (checksum != calc_checksum){
        return false;
    }

    bool ret = true;
    if (prefix_tmp == ADDRESS_PREFIX) {
        switch (sign_type_tmp) {
        case SIGNTYPE_ED25519:{
            ret = (ED25519_ADDRESS_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_CFCASM2:{
            ret = (SM2_ADDRESS_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_RSA:{
            break;
        }
        case SIGNTYPE_CFCA:{
            break;
        }
        default:
            ret = false;
        }
    }
    else if (prefix_tmp == PUBLICKEY_PREFIX) {
        switch (sign_type_tmp) {
        case SIGNTYPE_ED25519:{
            ret = (ED25519_PUBLICKEY_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_CFCASM2:{
            ret = (SM2_PUBLICKEY_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_RSA:{
            break;
        }
        case SIGNTYPE_CFCA:{
            break;
        }
        default:
            ret = false;
        }
    }
    else if (prefix_tmp == PRIVATEKEY_PREFIX) {
        switch (sign_type_tmp) {
        case SIGNTYPE_ED25519:{
            ret = (ED25519_PRIVATEKEY_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_CFCASM2:{
            ret = (SM2_PRIVATEKEY_LENGTH == datalen);
            break;
        }
        case SIGNTYPE_RSA:{
            break;
        }
        case SIGNTYPE_CFCA:{
            break;
        }
        default:
            ret = false;
        }
    }
    else {
        ret = false;
    }

    if (ret){
        prefix = prefix_tmp;
        sign_type = sign_type_tmp;
        raw_data = buff.substr(2, buff.size() - 3);
    }

    return ret;
}

std::string KeypairUtils::GetSignTypeDesc(SignatureType type) {
    switch (type) {
    case SIGNTYPE_CFCA: return "cfca";
    case SIGNTYPE_CFCASM2: return "sm2";
    case SIGNTYPE_RSA: return "rsa";
    case SIGNTYPE_ED25519: return "ed25519";
    }

    return "";
}

SignatureType KeypairUtils::GetSignTypeByDesc(const std::string &desc) {
    if (desc == "cfca") {
        return SIGNTYPE_CFCA;
    }
    else if (desc == "sm2") {
        return SIGNTYPE_CFCASM2;
    }
    else if (desc == "rsa") {
        return SIGNTYPE_RSA;
    }
    else if (desc == "ed25519") {
        return SIGNTYPE_ED25519;
    }
    return SIGNTYPE_NONE;
}

PublicKeyV4::PublicKeyV4() : PublicKeyBase(false, SIGNTYPE_ED25519){}

PublicKeyV4::PublicKeyV4(bool valid, SignatureType type) : PublicKeyBase(valid, type){}

PublicKeyV4::PublicKeyV4(const std::string &encode_pub_key) : PublicKeyBase(false, SIGNTYPE_ED25519){
    PrivateKeyPrefix prefix;
    if (KeypairUtils::GetPublicKeyElement(encode_pub_key, prefix, type_, raw_pub_key_)){
        valid_ = (prefix == PUBLICKEY_PREFIX);
    }
}

void PublicKeyV4::Init(SignatureType type, std::string rawpkey) {
    type_ = type;
    raw_pub_key_ = rawpkey;
}

bool PublicKeyV4::IsAddressValid(const std::string &encode_address) {
    PrivateKeyPrefix prefix;
    SignatureType sign_type;
    std::string raw_pub_key;
    if (KeypairUtils::GetKeyElement(encode_address, prefix, sign_type, raw_pub_key)){
        return (prefix == ADDRESS_PREFIX);
    }

    return false;
}

#if 0
std::string PublicKeyV4::GetEncAddress() const {
    std::string address;
    for (int64_t a = 0; a < 0XFF; a++){
        for (int64_t b = 0; b < 0XFF; b++){
            std::string str_result = "";
            //Append prefix (buchain 0XE6 0X9A 0X73 0XFF)
            //Append prefix (bu)
            str_result.push_back((char)a);
            str_result.push_back((char)b);

            //Append version 1byte
            str_result.push_back((char)type_);

            //Append public key 20byte
            std::string hash = CalcHash(raw_pub_key_, type_);
            str_result.append(hash.substr(12));

            //Append checksum 4byte
            std::string hash1, hash2;
            hash1 = CalcHash(str_result, type_);
            hash2 = CalcHash(hash1, type_);

            str_result.append(hash2.c_str(), 4);
            address = EncodeAddress(str_result);
            if (address.compare(0, 1, "a") == 0){
                printf("%s\n", address.c_str());
                printf("%d\n", a);
                printf("%d\n", b);
                printf("");
            }
        }
    }
    
    return address;

}
#else

std::string PublicKeyV4::GetEncAddress() const {
    
    std::string str_result = "";
    //Append prefix (buchain 0XE6 0X9A 0X73 0XFF)
    //Append prefix (bu)
    str_result.push_back((char)0XF8);
    str_result.push_back((char)0XE1);

    //Append version 1byte
    str_result.push_back((char)type_);

    //Append public key 20byte
    std::string hash = KeypairUtils::CalcHash(raw_pub_key_, type_);
    str_result.append(hash.substr(12));

    //Append checksum 4byte
    std::string hash1, hash2;
    hash1 = KeypairUtils::CalcHash(str_result, type_);
    hash2 = KeypairUtils::CalcHash(hash1, type_);

    str_result.append(hash2.c_str(), 4);
    return KeypairUtils::EncodeAddress(str_result);
}
#endif

std::string PublicKeyV4::GetEncPublicKey() const {
    
    std::string str_result = "";
    //Append PrivateKeyPrefix
    str_result.push_back((char)PUBLICKEY_PREFIX);

    //Append version
    str_result.push_back((char)type_);

    //Append public key
    str_result.append(raw_pub_key_);

    std::string hash1, hash2;
    hash1 = KeypairUtils::CalcHash(str_result, type_);
    hash2 = KeypairUtils::CalcHash(hash1, type_);

    str_result.append(hash2.c_str(), 4);
    return KeypairUtils::EncodePublicKey(str_result);
}
//not modify
bool PublicKeyV4::Verify(const std::string &data, const std::string &signature, const std::string &encode_public_key) {
    PrivateKeyPrefix prefix;
    SignatureType sign_type;
    std::string raw_pubkey;
    bool valid = KeypairUtils::GetPublicKeyElement(encode_public_key, prefix, sign_type, raw_pubkey);
    if (!valid || prefix != PUBLICKEY_PREFIX) {
        return false;
    }

    if (signature.size() != 64) {
        return false;
    }

    if (sign_type == SIGNTYPE_ED25519 ) {
        return ed25519_sign_open((unsigned char *)data.c_str(), data.size(), (unsigned char *)raw_pubkey.c_str(), (unsigned char *)signature.c_str()) == 0;
    }
    
    if (sign_type == SIGNTYPE_CFCASM2) {
        return utils::EccSm2::verify(utils::EccSm2::GetCFCAGroup(), raw_pubkey, "1234567812345678", data, signature) == 1;
    }
    
    printf("Failed to verify. Unknown signature type(%d)", sign_type);
    return false;
}

//Generate keypair according to signature type.
PrivateKeyV4::PrivateKeyV4(SignatureType type) {
    std::string raw_pub_key = "";
    type_ = type;
    if (type_ == SIGNTYPE_ED25519) {
        utils::MutexGuard guard_(lock_);
        // ed25519;
        raw_priv_key_.resize(32);
        //ed25519_randombytes_unsafe((void*)raw_priv_key_.c_str(), 32);
        if (!utils::GetStrongRandBytes(raw_priv_key_)){
            valid_ = false;
            return;
        }
        raw_pub_key.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub_key.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 key(utils::EccSm2::GetCFCAGroup());
        key.NewRandom();
        raw_priv_key_ = key.getSkeyBin();
        raw_pub_key = key.GetPublicKey();
    }
    else{
        printf("Failed to verify.Unknown signature type(%d)", type_);
    }
    pub_key_ = std::make_shared<PublicKeyV4>(true, type_);
    pub_key_->Init(type_, raw_pub_key);
    valid_ = true;
}

bool PrivateKeyV4::From(const std::string &encode_private_key) {
    valid_ = false;
    std::string raw_pub;

    PrivateKeyPrefix prefix;
    std::string raw_pubkey;
    valid_ = KeypairUtils::GetKeyElement(encode_private_key, prefix, type_, raw_priv_key_);
    if (!valid_) {
        return false;
    }

    if (prefix != PRIVATEKEY_PREFIX) {
        valid_ = false;
        return false;
    }

    if (type_ == SIGNTYPE_ED25519) {
        raw_pub.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 skey(utils::EccSm2::GetCFCAGroup());
        skey.From(raw_priv_key_);
        raw_pub = skey.GetPublicKey();
    }
    else{
        printf("Failed to verify.Unknown signature type(%d)", type_);
    }

    pub_key_ = std::make_shared<PublicKeyV4>(true, type_);
    pub_key_->Init(type_, raw_pub);
    valid_ = true;

    return valid_;
}

PrivateKeyV4::PrivateKeyV4(const std::string &encode_private_key) {
    From(encode_private_key );
}

void PrivateKeyV4::Init(SignatureType type, std::string raw_priv_key) {
    type_ = type;
    raw_priv_key_ = raw_priv_key;

    std::string raw_pub;
    if (type_ == SIGNTYPE_ED25519) {
        raw_pub.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 skey(utils::EccSm2::GetCFCAGroup());
        skey.From(raw_priv_key_);
        raw_pub = skey.GetPublicKey();
    }
    else{
        printf("Failed to verify.Unknown signature type(%d)", type_);
    }

    pub_key_ = std::make_shared<PublicKeyV4>(true, type_);
    pub_key_->Init(type_, raw_pub);
}

//not modify
std::string PrivateKeyV4::Sign(const std::string &input) const {
    unsigned char sig[10240];
    unsigned int sig_len = 0;

    if (type_ == SIGNTYPE_ED25519) {
        /*	ed25519_signature sig;*/
        ed25519_sign((unsigned char *)input.c_str(), input.size(), (const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)pub_key_->GetRawPublicKey().c_str(), sig);
        sig_len = 64;
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 key(utils::EccSm2::GetCFCAGroup());
        key.From(raw_priv_key_);
        std::string r, s;
        return key.Sign("1234567812345678", input);
    }
    else{
        printf("Failed to verify.Unknown signature type(%d)", type_);
    }
    std::string output;
    output.append((const char *)sig, sig_len);
    return output;
}

std::string PrivateKeyV4::GetEncPrivateKey() const {
    std::string str_result;
    //Append prefix(priv)
    str_result.push_back((char)0XDA);
    str_result.push_back((char)0X37);
    str_result.push_back((char)0X9F);

    //Append version 1
    str_result.push_back((char)type_);

    //Append private key 32
    str_result.append(raw_priv_key_);

    //Append 0X00 to str_result
    str_result.push_back(0X00);

    //We use 4 byte hash check like Bitcoin.
    std::string hash1, hash2;
    hash1 = KeypairUtils::CalcHash(str_result, type_);
    hash2 = KeypairUtils::CalcHash(hash1, type_);

    str_result.append(hash2.c_str(),4);
    return KeypairUtils::EncodePrivateKey(str_result);
}

PublicKeyV3::PublicKeyV3() : PublicKeyBase(false, SIGNTYPE_RSA){}
PublicKeyV3::PublicKeyV3(bool valid, SignatureType type) : PublicKeyBase(valid, type){}

PublicKeyV3::PublicKeyV3(const std::string &base16_pub_key) : PublicKeyBase(false, SIGNTYPE_RSA){
    PrivateKeyPrefix prefix;
    valid_ = KeypairUtils::GetKeyElementV3(base16_pub_key, prefix, type_, raw_pub_key_);
    valid_ = (prefix == PUBLICKEY_PREFIX);
}

void PublicKeyV3::Init(SignatureType type, std::string rawpkey) {
    type_ = type;
    raw_pub_key_ = rawpkey;
}

bool PublicKeyV3::IsAddressValid(const std::string &address_base16) {
    std::string address = utils::String::HexStringToBin(address_base16, true);
    if (address.size() != 23) {
        return false;
    }

    if (address.at(0) != (char)ADDRESS_PREFIX) {
        return false;
    }

    uint8_t crc = utils::Crc8(address.substr(0, address.size() - 1));
    if (crc != (uint8_t)address.back()) {
        return false;
    }

    return true;
}

std::string PublicKeyV3::CalcHash(const std::string &value) const {
    std::string hash;
    if (type_ == SIGNTYPE_CFCASM2) {
        hash = utils::Sm3::Crypto(raw_pub_key_);
    }
    else {
        hash = utils::Sha256::Crypto(raw_pub_key_);
    }
    return hash;
}

std::string PublicKeyV3::GetEncAddress() const {
    //append prefix
    std::string str_result = "";
    str_result.push_back((char)ADDRESS_PREFIX);

    //append version
    str_result.push_back((char)type_);

    //append public key
    std::string hash = CalcHash(raw_pub_key_);
    str_result.append(hash.substr(12));

    //append check sum
    str_result.push_back((char)utils::Crc8(str_result));
    return utils::String::BinToHexString(str_result);
}

std::string PublicKeyV3::GetEncPublicKey() const {
    //append prefix
    std::string str_result = "";
    str_result.push_back((char)PUBLICKEY_PREFIX);

    //append version
    str_result.push_back((char)type_);

    //append public key
    str_result.append(raw_pub_key_);

    str_result.push_back((char)utils::Crc8(str_result));
    return utils::String::BinToHexString(str_result);
}

bool PublicKeyV3::Verify(const std::string &data, const std::string &signature, const std::string &public_key_base16) {
    PrivateKeyPrefix prefix;
    SignatureType sign_type;
    std::string raw_pubkey;
    bool valid = KeypairUtils::GetKeyElementV3(public_key_base16, prefix, sign_type, raw_pubkey);
    if (!valid || prefix != PUBLICKEY_PREFIX) {
        return false;
    }

    if (sign_type == SIGNTYPE_ED25519) {
        return ed25519_sign_open((unsigned char *)data.c_str(), data.size(), (unsigned char *)raw_pubkey.c_str(), (unsigned char *)signature.c_str()) == 0;
    }
    
    if (sign_type == SIGNTYPE_CFCASM2) {
        return utils::EccSm2::verify(utils::EccSm2::GetCFCAGroup(), raw_pubkey, "1234567812345678", data, signature) == 1;
    }
    
    return false;
}

PrivateKeyV3::PrivateKeyV3(SignatureType type) {
    std::string raw_pub_key = "";
    type_ = type;
    if (type_ == SIGNTYPE_ED25519) {
        utils::MutexGuard guard_(lock_);
        // ed25519;
        raw_priv_key_.resize(32);
        ed25519_randombytes_unsafe((void*)raw_priv_key_.c_str(), 32);

        raw_pub_key.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub_key.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 key(utils::EccSm2::GetCFCAGroup());
        key.NewRandom();
        raw_priv_key_ = key.getSkeyBin();
        raw_pub_key = key.GetPublicKey();
    }

    pub_key_ = std::make_shared<PublicKeyV3>(true, type_);
    pub_key_->Init(type_, raw_pub_key);
    valid_ = true;
}

bool PrivateKeyV3::From(const std::string &base16_private_key) {
    valid_ = false;
    std::string raw_pub_key;

    PrivateKeyPrefix prefix;
    std::string raw_pubkey;
    valid_ = KeypairUtils::GetKeyElementV3(base16_private_key, prefix, type_, raw_priv_key_);
    if (!valid_) {
        return false;
    }

    if (prefix != PRIVATEKEY_PREFIX) {
        valid_ = false;
        return false;
    }

    if (type_ == SIGNTYPE_ED25519) {
        raw_pub_key.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub_key.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 skey(utils::EccSm2::GetCFCAGroup());
        skey.From(raw_priv_key_);
        raw_pub_key = skey.GetPublicKey();
    }
    //ToBase58();

    pub_key_ = std::make_shared<PublicKeyV3>(true, type_);
    pub_key_->Init(type_, raw_pub_key);
    valid_ = true;

    return valid_;
}

PrivateKeyV3::PrivateKeyV3(const std::string &base58_private_key) {
    From(base58_private_key);
}

void PrivateKeyV3::Init(SignatureType type, std::string raw_priv_key) {
    type_ = type;
    raw_priv_key_ = raw_priv_key;

    std::string raw_pub_key;
    if (type_ == SIGNTYPE_ED25519) {
        raw_pub_key.resize(32);
        ed25519_publickey((const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)raw_pub_key.c_str());
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 skey(utils::EccSm2::GetCFCAGroup());
        skey.From(raw_priv_key_);
        raw_pub_key = skey.GetPublicKey();
    }
    //ToBase58();

    pub_key_ = std::make_shared<PublicKeyV3>(true, type_);
    pub_key_->Init(type_, raw_pub_key);
}

std::string PrivateKeyV3::Sign(const std::string &input) const {
    unsigned char sig[10240];
    unsigned int sig_len = 0;

    if (type_ == SIGNTYPE_ED25519) {
        /*	ed25519_signature sig;*/
        ed25519_sign((unsigned char *)input.c_str(), input.size(), (const unsigned char*)raw_priv_key_.c_str(), (unsigned char*)pub_key_->GetRawPublicKey().c_str(), sig);
        sig_len = 64;
    }
    else if (type_ == SIGNTYPE_CFCASM2) {
        utils::EccSm2 key(utils::EccSm2::GetCFCAGroup());
        key.From(raw_priv_key_);
        std::string r, s;
        return key.Sign("1234567812345678", input);
    }
    std::string output;
    output.append((const char *)sig, sig_len);
    return output;
}

std::string PrivateKeyV3::GetEncPrivateKey() const {
    //append prefix
    std::string str_result;
    str_result.push_back((char)PRIVATEKEY_PREFIX);

    //append version
    str_result.push_back((char)type_);

    //append private key
    str_result.append(raw_priv_key_);

    str_result.push_back((char)utils::Crc8(str_result));
    return utils::String::BinToHexString(str_result);
}

PublicKey::~PublicKey() {}

PublicKey::PublicKey() {
    switch (KeypairUtils::GetKeypairVersion())
    {
    case KEYPAIR_VERSION_V3: pub_base_ = std::make_shared<PublicKeyV3>(); break;
    case KEYPAIR_VERSION_V4: pub_base_ = std::make_shared<PublicKeyV4>(); break;
    }
}

PublicKey::PublicKey(const std::string &encode_pub_key) {
    switch (KeypairUtils::GetKeypairVersion())
    {
    case KEYPAIR_VERSION_V3: pub_base_ = std::make_shared<PublicKeyV3>(encode_pub_key); break;
    case KEYPAIR_VERSION_V4: pub_base_ = std::make_shared<PublicKeyV4>(encode_pub_key); break;
    }
}

void PublicKey::Init(SignatureType type, std::string rawpkey) {
    pub_base_->Init(type, rawpkey);
}

std::string PublicKey::GetEncAddress() const {
    return pub_base_->GetEncAddress();
}

std::string PublicKey::GetEncPublicKey() const {
    return pub_base_->GetEncPublicKey();
}

std::string PublicKey::GetRawPublicKey() const {
    return pub_base_->GetRawPublicKey();
}

bool PublicKey::IsValid() const {
    return pub_base_->IsValid();
}

SignatureType PublicKey::GetSignType() const{
    return pub_base_->GetSignType();
}

bool PublicKey::Verify(const std::string &data, const std::string &signature, const std::string &encode_public_key) {
    switch (KeypairUtils::GetKeypairVersion())
    {
    case KEYPAIR_VERSION_V3: return PublicKeyV3::Verify(data, signature, encode_public_key);
    case KEYPAIR_VERSION_V4: return PublicKeyV4::Verify(data, signature, encode_public_key);
    }
    return false;
}

bool PublicKey::IsAddressValid(const std::string &encode_address) {
    switch (KeypairUtils::GetKeypairVersion())
    {
    case KEYPAIR_VERSION_V3: return PublicKeyV3::IsAddressValid(encode_address);
    case KEYPAIR_VERSION_V4: return PublicKeyV4::IsAddressValid(encode_address);
    }
    return false;
}


PrivateKey::~PrivateKey() {}

PrivateKey::PrivateKey() : PrivateKey(SIGNTYPE_ED25519) {
}

PrivateKey::PrivateKey(SignatureType type) {
    switch (KeypairUtils::GetKeypairVersion()) {
    case KEYPAIR_VERSION_V3: priv_base_ = std::make_shared<PrivateKeyV3>(type); break;
    case KEYPAIR_VERSION_V4: priv_base_ = std::make_shared<PrivateKeyV4>(type); break;
    }
}

PrivateKey::PrivateKey(const std::string &encode_private_key) {
    switch (KeypairUtils::GetKeypairVersion()) {
    case KEYPAIR_VERSION_V3: priv_base_ = std::make_shared<PrivateKeyV3>(encode_private_key); break;
    case KEYPAIR_VERSION_V4: priv_base_ = std::make_shared<PrivateKeyV4>(encode_private_key); break;
    }
}

bool PrivateKey::From(const std::string &encode_private_key) {
    return priv_base_->From(encode_private_key);
}

void PrivateKey::Init(SignatureType type, std::string raw_priv_key) {
    priv_base_->Init(type, raw_priv_key);
}

std::string	PrivateKey::Sign(const std::string &input) const {
    return priv_base_->Sign(input);
}

std::string PrivateKey::GetEncPrivateKey() const {
    return priv_base_->GetEncPrivateKey();
}

std::string PrivateKey::GetEncAddress() const {
    return priv_base_->GetEncAddress();
}

std::string PrivateKey::GetEncPublicKey() const {
    return priv_base_->GetEncPublicKey();
}

std::string PrivateKey::GetRawPublicKey() const {
    return priv_base_->GetRawPublicKey();
}

std::string PrivateKey::GetRawHexPrivateKey() const {
    return priv_base_->GetRawHexPrivateKey();
}

bool PrivateKey::IsValid() const {
    return priv_base_->IsValid();
}

std::string PrivateKey::GetRawPrivateKey() const{
    return priv_base_->GetRawPrivateKey();
}

SignatureType PrivateKey::GetSignType() const{
    return priv_base_->GetSignType();
}
