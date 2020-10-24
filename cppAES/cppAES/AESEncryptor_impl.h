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
	res[0] = G2Mul[s[0]] ^ G3Mul[s[1]] ^ s[2] ^ s[3];
	res[1] = s[0] ^ G2Mul[s[1]] ^ G3Mul[s[2]] ^ s[3];
	res[2] = s[0] ^ s[1] ^ G2Mul[s[2]] ^ G3Mul[s[3]];
	res[3] = G3Mul[s[0]] ^ s[1] ^ s[2] ^ G2Mul[s[3]];

	res[4] = G2Mul[s[4]] ^ G3Mul[s[5]] ^ s[6] ^ s[7];
	res[5] = s[4] ^ G2Mul[s[5]] ^ G3Mul[s[6]] ^ s[7];
	res[6] = s[4] ^ s[5] ^ G2Mul[s[6]] ^ G3Mul[s[7]];
	res[7] = G3Mul[s[4]] ^ s[5] ^ s[6] ^ G2Mul[s[7]];

	res[8] = G2Mul[s[8]] ^ G3Mul[s[9]] ^ s[10] ^ s[11];
	res[9] = s[8] ^ G2Mul[s[9]] ^ G3Mul[s[10]] ^ s[11];
	res[10] = s[8] ^ s[9] ^ G2Mul[s[10]] ^ G3Mul[s[11]];
	res[11] = G3Mul[s[8]] ^ s[9] ^ s[10] ^ G2Mul[s[11]];

	res[12] = G2Mul[s[12]] ^ G3Mul[s[13]] ^ s[14] ^ s[15];
	res[13] = s[12] ^ G2Mul[s[13]] ^ G3Mul[s[14]] ^ s[15];
	res[14] = s[12] ^ s[13] ^ G2Mul[s[14]] ^ G3Mul[s[15]];
	res[15] = G3Mul[s[12]] ^ s[13] ^ s[14] ^ G2Mul[s[15]];


	return res;
}