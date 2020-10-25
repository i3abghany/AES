#pragma once

#include <vector>
#include <string>
#include <iterator>
#include <string_view>
#include <fstream>
#include <cstdint>
#include <array>
#include <cassert>

template <size_t KeySize = 16U>
class AES
{
	static_assert(KeySize == 16U || KeySize == 24U || KeySize == 32U, "Only 16-, 24-, and 32-byte keys are allowed.");
private:
	using StrCIter = std::string::const_iterator;
	static constexpr size_t N = 16U;  // Block Size.

public:
	AES();
	AES(const std::string&, const std::string&);
	size_t blocks() const;
	std::string_view GetBlock(size_t) const;

	void load(const std::string&);
	void loadFile(const std::string&);

	std::string Encrypt();
	std::string Decrypt();

private:

	void GenerateKeys();

	std::string AddRoundKey(const std::string&, const std::string&);
	std::string SubBytes(const std::string&);
	std::string ShiftRows(const std::string&);
	std::string MixCols(const std::string&);
	
	std::string IMixCols(const std::string&);
	std::string IShiftRows(const std::string&);
	std::string ISubBytes(const std::string&);

	std::string GBlock(const std::string&, const uint8_t);
	std::string GetKeyWord(const std::string&, uint8_t);
	std::string CombineWords(const std::string&, const std::string&,
							 const std::string&, const std::string&);

	uint8_t GMul1 (const uint8_t);
	uint8_t GMul2 (const uint8_t);
	uint8_t GMul3 (const uint8_t);
	uint8_t GMul9 (const uint8_t);
	uint8_t GMul11(const uint8_t);
	uint8_t GMul13(const uint8_t);
	uint8_t GMul14(const uint8_t);

private:
	void SplitData(const std::string&);
	std::string XORStr(const std::string&, const std::string&);

private:
	/*
		Data stored in chars (bytes), organized as blocks (each block in a string.)
		Can either be the the plaintext or cyphertext.
	*/
	std::vector<std::string> data; 

	std::string encData;  // Encrypted data produced by Encrypt() is stored here.
	std::string decData;  // Decrypted data produced by Decrypt() is stored here.
	
	std::string key;
	std::vector<std::string> SubKeys;

	size_t numBlocks;
	uint8_t numRounds;


	static uint8_t SBox [(1U << 8)];
	static uint8_t G2Mul[(1U << 8)];
	static uint8_t G3Mul[(1U << 8)];
	static std::vector<uint8_t> RC;

	static uint8_t ISBox [(1U << 8)];
	static uint8_t G9Mul [(1U << 8)];
	static uint8_t G11Mul[(1U << 8)];
	static uint8_t G13Mul[(1U << 8)];
	static uint8_t G14Mul[(1U << 8)];
};

#include "RC.h"
#include "SBox.h"
#include "G2Mul.h"
#include "G3Mul.h"
#include "G9Mul.h"
#include "G11Mul.h"
#include "G13Mul.h"
#include "G14Mul.h"
#include "AES_impl.h"
