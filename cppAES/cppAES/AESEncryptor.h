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
class AESEncryptor
{
	static_assert(KeySize == 16U || KeySize == 24U || KeySize == 32U, "Only 16-, 24-, and 32-byte keys are allowed.");
private:
	using StrCIter = std::string::const_iterator;
	static constexpr size_t N = 16U;  // Block Size.

public:
	AESEncryptor();
	AESEncryptor(const std::string&, const std::string&);
	size_t blocks() const;
	std::string_view GetBlock(size_t) const;

	void load(const std::string&);
	void loadFile(const std::string&);

private:
public:
	void Encrypt(); // TODO: Implement.

	void GenerateKeys();
	std::string XORStr(const std::string&, const std::string&);

	std::string AddRoundKey(const std::string&, const std::string&);
	std::string SubBytes(const std::string&);
	std::string ShiftRows(const std::string&);
	std::string MixColumns(const std::string&);

	std::string GBlock(const std::string&, const uint8_t);
	std::string GetKeyWord(const std::string&, uint8_t);
	std::string CombineWords(const std::string&, const std::string&,
							 const std::string&, const std::string&);

	uint8_t GMul1(const uint8_t);
	uint8_t GMul2(const uint8_t);
	uint8_t GMul3(const uint8_t);

private:
	void SplitData(const std::string&);

private:
	size_t numBlocks;
	uint8_t numRounds;
	std::vector<std::string> data; // data stored in chars (bytes), organized as blocks (each block in a string.)
	std::string key;
	std::vector<std::string> SubKeys;
	static uint8_t SBox [(1U << 8)];
	static uint8_t G2Mul[(1U << 8)];
	static uint8_t G3Mul[(1U << 8)];
	static std::vector<uint8_t> RC;
};

#include "RC.h"
#include "SBox.h"
#include "G2Mul.h"
#include "G3Mul.h"
#include "AESEncryptor_impl.h"

