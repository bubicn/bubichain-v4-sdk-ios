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

#ifndef PRIVATE_KEY_H_
#define PRIVATE_KEY_H_

#include "ed25519.h"
#include "thread.h"
#include "strings.h"

typedef unsigned char sm2_public_key[65];
typedef const unsigned char* puchar;
enum SignatureType {
    SIGNTYPE_NONE,
    SIGNTYPE_ED25519 = 1,
    SIGNTYPE_CFCASM2 = 2,
    SIGNTYPE_RSA = 3,
    SIGNTYPE_CFCA = 4
};

enum PrivateKeyPrefix {
    ADDRESS_PREFIX = 0xa0, //0xa0
    PUBLICKEY_PREFIX = 0xb0, //0xb0
    PRIVATEKEY_PREFIX = 0xc0  //0xc0
};

enum Ed25519KeyLength {
    ED25519_ADDRESS_LENGTH = 20, // 2+1+20+4
    ED25519_PUBLICKEY_LENGTH = 32, //1+1+32+4
    ED25519_PRIVATEKEY_LENGTH = 32, //3+1+32+1+4
};

enum Sm2KeyLength {
    SM2_ADDRESS_LENGTH = 20, //2+1+20+4
    SM2_PUBLICKEY_LENGTH = 65, //1+1+65+4
    SM2_PRIVATEKEY_LENGTH = 32 //3+1+32+1+4
};

enum KeypairVersion {
    KEYPAIR_VERSION_V3 = 0,
    KEYPAIR_VERSION_V4,
};

//tools
class KeypairUtils {
public:
    //Init key pair version
    static void InitKeypairVersion(uint32_t type);
    static uint32_t GetKeypairVersion() { return keypair_version_; }

    static std::string EncodeAddress(const std::string& address);
    static std::string DecodeAddress(const std::string& address);
    static std::string EncodePublicKey(const std::string& key);
    static std::string DecodePublicKey(const std::string& key);
    static std::string EncodePrivateKey(const std::string& key);
    static std::string DecodePrivateKey(const std::string& key);

    static std::string CalcHash(const std::string &value, const SignatureType &sign_type);
    static bool GetPublicKeyElement(const std::string &encode_pub_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data);
    static bool GetKeyElement(const std::string &encode_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data);
    static bool GetKeyElementV3(const std::string &encode_key, PrivateKeyPrefix &prefix, SignatureType &sign_type, std::string &raw_data);
    static std::string GetSignTypeDesc(SignatureType type);
    static SignatureType GetSignTypeByDesc(const std::string &desc);

    static std::string RESERVED_CREATOR_ADDRESS;
    static std::string CONTRACT_DPOS_ADDRESS;
    static std::string RESERVED_ADDRESS4;
    static std::string RESERVED_ADDRESS5;
    static std::string RESERVED_ADDRESS6;
    static std::string RESERVED_ADDRESS7;
    static std::string RESERVED_ADDRESS8;

private:
    static uint32_t keypair_version_;
};

//base
class PublicKeyBase {
public:
    PublicKeyBase(bool valid, SignatureType type) : valid_(valid), type_(type){}
    ~PublicKeyBase(){}

    virtual void Init(SignatureType type, std::string rawpkey) = 0;
    virtual std::string GetEncAddress() const = 0;
    virtual std::string GetEncPublicKey() const = 0;

    std::string GetRawPublicKey() const { return raw_pub_key_; };
    bool IsValid() const { return valid_; }
    SignatureType GetSignType() const { return type_; };

protected:
    bool valid_;
    SignatureType type_;
    std::string raw_pub_key_;
};

class PrivateKeyBase {
public:
    PrivateKeyBase() : valid_(false), type_(SIGNTYPE_ED25519){}
    ~PrivateKeyBase(){}

    virtual void Init(SignatureType type, std::string raw_priv_key) = 0;
    virtual bool From(const std::string &encode_private_key) = 0;
    virtual std::string	Sign(const std::string &input) const = 0;
    virtual std::string GetEncPrivateKey() const = 0;

    std::string GetRawPrivateKey() const{ return KeypairUtils::EncodePrivateKey(raw_priv_key_); }
    std::string GetRawHexPrivateKey() const { return utils::String::BinToHexString(raw_priv_key_); }
    bool IsValid() const { return valid_; }
    SignatureType GetSignType() const { return type_; };
    std::string GetEncAddress() const{ return pub_key_->GetEncAddress(); };
    std::string GetEncPublicKey() const { return pub_key_->GetEncPublicKey(); };
    std::string GetRawPublicKey() const { return pub_key_->GetRawPublicKey(); };

protected:
    bool valid_;
    SignatureType type_;
    std::string raw_priv_key_;
    static utils::Mutex lock_;
    std::shared_ptr<PublicKeyBase> pub_key_;
};

//v4
class PublicKeyV4 : public PublicKeyBase {
    DISALLOW_COPY_AND_ASSIGN(PublicKeyV4);
    friend class PrivateKeyV4;

public:
    PublicKeyV4();
    PublicKeyV4(bool valid, SignatureType type);
    PublicKeyV4(const std::string &encode_pub_key);
    ~PublicKeyV4(){}

    void Init(SignatureType type, std::string rawpkey);

    std::string GetEncAddress() const;

    std::string GetEncPublicKey() const;

    static bool Verify(const std::string &data, const std::string &signature, const std::string &encode_public_key);
    static bool IsAddressValid(const std::string &encode_address);
};

class PrivateKeyV4 : public PrivateKeyBase {
    DISALLOW_COPY_AND_ASSIGN(PrivateKeyV4);
public:
    PrivateKeyV4(SignatureType type);
    PrivateKeyV4(const std::string &encode_private_key);
    bool From(const std::string &encode_private_key);
    ~PrivateKeyV4(){}

    void Init(SignatureType type, std::string raw_priv_key);

    std::string	Sign(const std::string &input) const;
    std::string GetEncPrivateKey() const;
};

//v3
class PublicKeyV3 : public PublicKeyBase {
    DISALLOW_COPY_AND_ASSIGN(PublicKeyV3);
    friend class PrivateKeyV3;

public:
    PublicKeyV3();
    PublicKeyV3(bool valid, SignatureType type);
    PublicKeyV3(const std::string &base16_pub_key);
    ~PublicKeyV3() {}

    void Init(SignatureType type, std::string rawpkey);
    std::string GetEncAddress() const;
    std::string GetEncPublicKey() const;
    std::string CalcHash(const std::string &value) const;

    static bool Verify(const std::string &data, const std::string &signature, const std::string &public_key_base16);
    static bool IsAddressValid(const std::string &public_key_base16);
};

class PrivateKeyV3 : public PrivateKeyBase {
    DISALLOW_COPY_AND_ASSIGN(PrivateKeyV3);
public:
    PrivateKeyV3(SignatureType type);
    PrivateKeyV3(const std::string &base16_private_key);
    bool From(const std::string &base16_private_key);
    ~PrivateKeyV3(){}

    void Init(SignatureType type, std::string raw_priv_key);

    std::string	Sign(const std::string &input) const;
    std::string GetEncPrivateKey() const;
};

//wrapper
class PublicKey {
    DISALLOW_COPY_AND_ASSIGN(PublicKey);
    friend class PrivateKey;

public:
    PublicKey();
    PublicKey(const std::string &encode_pub_key);
    ~PublicKey();

    void Init(SignatureType type, std::string rawpkey);

    std::string GetEncAddress() const;
    std::string GetEncPublicKey() const;
    std::string GetRawPublicKey() const;

    bool IsValid() const;

    SignatureType GetSignType() const;

    static bool Verify(const std::string &data, const std::string &signature, const std::string &encode_public_key);
    static bool IsAddressValid(const std::string &encode_address);

private:
    std::shared_ptr<PublicKeyBase> pub_base_;
};

class PrivateKey {
    DISALLOW_COPY_AND_ASSIGN(PrivateKey);
public:
    PrivateKey();
    PrivateKey(SignatureType type);
    PrivateKey(const std::string &encode_private_key);
    bool From(const std::string &encode_private_key);
    ~PrivateKey();

    void Init(SignatureType type, std::string raw_priv_key);

    std::string	Sign(const std::string &input) const;
    std::string GetEncPrivateKey() const;
    std::string GetEncAddress() const;
    std::string GetEncPublicKey() const;
    std::string GetRawPublicKey() const;
    std::string GetRawHexPrivateKey() const;
    bool IsValid() const;
    std::string GetRawPrivateKey() const;
    SignatureType GetSignType() const;

private:
    std::shared_ptr<PrivateKeyBase> priv_base_;
};

#endif
