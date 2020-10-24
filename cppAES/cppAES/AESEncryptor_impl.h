#include "AESEncryptor.h"
#pragma once
using StrCIter = std::string::const_iterator;

template <size_t KeySize>
AESEncryptor<KeySize>::AESEncryptor()
{
	this->data = std::vector<std::string>{};
}

template <size_t KeySize>
AESEncryptor<KeySize>::AESEncryptor(const std::string& inputData)
{
	this->numBlocks = (inputData.size() / N) + (inputData.size() % N ? 1 : 0);
	this->data.resize(this->numBlocks, std::string(N, '0'));
	SplitData(inputData);
}

template <size_t KeySize>
void AESEncryptor<KeySize>::SplitData(const std::string& inputData)
{
	for (int i = 0; i < this->numBlocks; i++)
	{
		auto firstIter = std::begin(inputData) + (i * N);
		auto lastIter = (i == this->numBlocks - 1) ?
			std::end(inputData) :
			std::begin(inputData) + ((1 + i) * N);

		std::copy(firstIter, lastIter, std::begin(this->data[i]));
	}
}

template <size_t KeySize>
size_t AESEncryptor<KeySize>::blocks() const
{
	return this->numBlocks;
}

template <size_t KeySize>
std::string_view AESEncryptor<KeySize>::GetBlock(size_t idx) const
{
	if (idx >= numBlocks)
	{
		throw std::invalid_argument("Block index is not valid.\n");
	}
	return this->data[idx];
}

template<size_t KeySize>
void AESEncryptor<KeySize>::load(const std::string& x)
{
	*this = AESEncryptor{ x };
}

template<size_t KeySize>
inline void AESEncryptor<KeySize>::loadFile(const std::string& fName)
{
	std::ifstream f1(fName);
	if (!f1)
	{
		throw std::invalid_argument("Could not open the file.\n");
	}
	std::string ss;
	std::getline(f1, ss, char{ EOF });
	this->load(ss);
}

template<size_t KeySize>
inline std::string AESEncryptor<KeySize>::AddRoundKey(const std::string& state, const std::string& key)
{
	std::string res;
	res.resize(16);
	for (int i = 0; i < N; i++)
	{
		res[i] = state[i] ^ key[i];
	}
	return res;
}

template<size_t KeySize>
inline std::string AESEncryptor<KeySize>::SubBytes(const std::string& state)
{
	std::string res;
	res.resize(16);
	for (size_t i = 0; i < N; i++)
	{
		res[i] = SBox[state[i]];
	}
	return res;
}

template<size_t KeySize>
inline std::string AESEncryptor<KeySize>::ShiftRows(const std::string& state)
{
	std::string res;
	res.resize(16);

	res[0] = state[0];
	res[1] = state[5];
	res[2] = state[10];
	res[3] = state[15];

	res[4] = state[4];
	res[5] = state[9];
	res[6] = state[14];
	res[7] = state[3];

	res[8] = state[8];
	res[9] = state[13];
	res[10] = state[2];
	res[11] = state[7];

	res[12] = state[12];
	res[13] = state[1];
	res[14] = state[6];
	res[15] = state[11];

	return res;
}

/*
	STATE:						MixColumn Matrix:
	| B0 | B4 | B8  | B12 |     | 2 | 3 | 1 | 1 |
	| B1 | B5 | B9  | B11 |  *  | 1 | 2 | 3 | 1 |
	| B2 | B6 | B10 | B14 |     | 1 | 1 | 2 | 3 |
	| B3 | B7 | B11 | B15 |     | 3 | 1 | 1 | 2 |
	Constrained matrix multiplication over Galois fields.

	Multiplying a "number" from the GF(2^8) by 1 results in the same "number"
	Multiplying a "number" from the GF(2^8) by 2 (MOD the AES irreducible polynomial) results in a "number" in GF(2^8)
	Multiplying a "number" from the GF(2^8) by 3 (MOD the AES irreducible polynomial) results in a "number" in GF(2^8)

	Those multiplications are done for every possibile "number"s in the GF(2^8), which can be seen as a byte.

	So the matrix multiplication is now "regular" matrix multiplication but we get the values of the terms accumulated to 
	result in the dot product from the G2Mul and G3Mul lookup tables.

	The accumulation step is also done in the finite field. Thus, XOR is user rather than normal addition.
	XOR(b1, b2) is equivilant to (b1 + b2) % 2.
	This means that XOR will result in a "number" in the GF(2).
*/

template<size_t KeySize>
inline std::string AESEncryptor<KeySize>::MixColumns(const std::string& state)
{
	auto& s = state;
	std::string res;
	res.resize(16);
	res[0]  = GMul2(s[0]) ^ GMul3(s[1]) ^ GMul1(s[2]) ^ GMul1(s[3]);
	res[1]  = GMul1(s[0]) ^ GMul2(s[1]) ^ GMul3(s[2]) ^ GMul1(s[3]);
	res[2]  = GMul1(s[0]) ^ GMul1(s[1]) ^ GMul2(s[2]) ^ GMul3(s[3]);
	res[3]  = GMul3(s[0]) ^ GMul1(s[1]) ^ GMul1(s[2]) ^ GMul2(s[3]);

	res[4]  = GMul2(s[4]) ^ GMul3(s[5]) ^ GMul1(s[6]) ^ GMul1(s[7]);
	res[5]  = GMul1(s[4]) ^ GMul2(s[5]) ^ GMul3(s[6]) ^ GMul1(s[7]);
	res[6]  = GMul1(s[4]) ^ GMul1(s[5]) ^ GMul2(s[6]) ^ GMul3(s[7]);
	res[7]  = GMul3(s[4]) ^ GMul1(s[5]) ^ GMul1(s[6]) ^ GMul2(s[7]);

	res[8]  = GMul2(s[8]) ^ GMul3(s[9]) ^ GMul1(s[10]) ^ GMul1(s[11]);
	res[9]  = GMul1(s[8]) ^ GMul2(s[9]) ^ GMul3(s[10]) ^ GMul1(s[11]);
	res[10] = GMul1(s[8]) ^ GMul1(s[9]) ^ GMul2(s[10]) ^ GMul3(s[11]);
	res[11] = GMul3(s[8]) ^ GMul1(s[9]) ^ GMul1(s[10]) ^ GMul2(s[11]);

	res[12] = GMul2(s[12]) ^ GMul3(s[13]) ^ GMul1(s[14]) ^ GMul1(s[15]);
	res[13] = GMul1(s[12]) ^ GMul2(s[13]) ^ GMul3(s[14]) ^ GMul1(s[15]);
	res[14] = GMul1(s[12]) ^ GMul1(s[13]) ^ GMul2(s[14]) ^ GMul3(s[15]);
	res[15] = GMul3(s[12]) ^ GMul1(s[13]) ^ GMul1(s[14]) ^ GMul2(s[15]);


	return res;
}

template<size_t KeySize>
inline uint8_t AESEncryptor<KeySize>::GMul1(const uint8_t b)
{
	return uint8_t(b);
}

template<size_t KeySize>
inline uint8_t AESEncryptor<KeySize>::GMul2(const uint8_t b)
{
	return uint8_t(G2Mul[b]);
}

template<size_t KeySize>
inline uint8_t AESEncryptor<KeySize>::GMul3(const uint8_t b)
{
	return uint8_t(G3Mul[b]);
}

