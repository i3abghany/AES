#pragma once

#include <vector>
#include <string>
#include <iterator>
#include <string_view>
#include <fstream>
#include <cstdint>
#include <array>

template <size_t KeySize = 16U>
class AESEncryptor
{
	static_assert(KeySize == 16U || KeySize == 24U || KeySize == 32U, "Only 16-, 24-, and 32-byte keys are allowed.");
private:
	using StrCIter = std::string::const_iterator;
	static constexpr size_t N = 16U;  // Block Size.

public:
	AESEncryptor();
	AESEncryptor(const std::string& data);
	size_t blocks() const;
	std::string_view GetBlock(size_t) const;

	void load(const std::string&);
	void loadFile(const std::string&);

private:
	void Encrypt(); // TODO: Implement.

	std::string AddRoundKey(const std::string&, const std::string&);

	std::string SubBytes(const std::string&);
	std::string ShiftRows(const std::string&);
	std::string MixColumns(const std::string&);

	uint8_t GMul1(const uint8_t);
	uint8_t GMul2(const uint8_t);
	uint8_t GMul3(const uint8_t);

private:
	void SplitData(const std::string&);

private:
	size_t numBlocks;
	uint8_t numRounds;
	std::vector<std::string> data; // data stored in chars (bytes).
	static uint8_t SBox[(1U << 8)];
	static uint8_t G2Mul[(1U << 8)];
	static uint8_t G3Mul[(1U << 8)];
};

#include "AESEncryptor_impl.h"
#include "G2Mul.h"
#include "G3Mul.h"
#include "SBox.h"
