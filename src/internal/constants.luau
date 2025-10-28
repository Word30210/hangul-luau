--#[ Modules ]#--
local better_table = require("@packages/better-table")

--#[ Variables ]#--
local COMPLETE_HANGUL_START_CHARCODE = string.byte("가");
local COMPLETE_HANGUL_END_CHARCODE = string.byte("힣");

local NUMBER_OF_JONGSEONG = 28;
local NUMBER_OF_JUNGSEONG = 21;

local DISASSEMBLE_CONSONANTS_BY_CONSONANT = {
    ["ㄱ"] = "ㄱ";
    ["ㄲ"] = "ㄲ";
    ["ㄳ"] = "ㄱㅅ";
    ["ㄴ"] = "ㄴ";
    ["ㄵ"] = "ㄴㅈ";
    ["ㄶ"] = "ㄴㅎ";
    ["ㄷ"] = "ㄷ";
    ["ㄸ"] = "ㄸ";
    ["ㄹ"] = "ㄹ";
    ["ㄺ"] = "ㄹㄱ";
    ["ㄻ"] = "ㄹㅁ";
    ["ㄼ"] = "ㄹㅂ";
    ["ㄽ"] = "ㄹㅅ";
    ["ㄾ"] = "ㄹㅌ";
    ["ㄿ"] = "ㄹㅍ";
    ["ㅀ"] = "ㄹㅎ";
    ["ㅁ"] = "ㅁ";
    ["ㅂ"] = "ㅂ";
    ["ㅃ"] = "ㅃ";
    ["ㅄ"] = "ㅂㅅ";
    ["ㅅ"] = "ㅅ";
    ["ㅆ"] = "ㅆ";
    ["ㅇ"] = "ㅇ";
    ["ㅈ"] = "ㅈ";
    ["ㅉ"] = "ㅉ";
    ["ㅊ"] = "ㅊ";
    ["ㅋ"] = "ㅋ";
    ["ㅌ"] = "ㅌ";
    ["ㅍ"] = "ㅍ";
    ["ㅎ"] = "ㅎ";
};

local DISASSEMBLE_VOWELS_BY_VOWEL = {
    ["ㅏ"] = "ㅏ";
    ["ㅐ"] = "ㅐ";
    ["ㅑ"] = "ㅑ";
    ["ㅒ"] = "ㅒ";
    ["ㅓ"] = "ㅓ";
    ["ㅔ"] = "ㅔ";
    ["ㅕ"] = "ㅕ";
    ["ㅖ"] = "ㅖ";
    ["ㅗ"] = "ㅗ";
    ["ㅘ"] = "ㅗㅏ";
    ["ㅙ"] = "ㅗㅐ";
    ["ㅚ"] = "ㅗㅣ";
    ["ㅛ"] = "ㅛ";
    ["ㅜ"] = "ㅜ";
    ["ㅝ"] = "ㅜㅓ";
    ["ㅞ"] = "ㅜㅔ";
    ["ㅟ"] = "ㅜㅣ";
    ["ㅠ"] = "ㅠ";
    ["ㅡ"] = "ㅡ";
    ["ㅢ"] = "ㅡㅣ";
    ["ㅣ"] = "ㅣ";
};

local CHOSEONGS = {
    "ㄱ";
    "ㄲ";
    "ㄴ";
    "ㄷ";
    "ㄸ";
    "ㄹ";
    "ㅁ";
    "ㅂ";
    "ㅃ";
    "ㅅ";
    "ㅆ";
    "ㅇ";
    "ㅈ";
    "ㅉ";
    "ㅊ";
    "ㅋ";
    "ㅌ";
    "ㅍ";
    "ㅎ";
}

local JUNGSEONGS = better_table.values(DISASSEMBLE_VOWELS_BY_VOWEL)

--// 종성으로 올 수 있는 자모에는 ㄸ, ㅃ, ㅉ이 없기 때문에 따로 적음.
local JONGSEONGS = better_table.map(
    {
        "ㄱ";
        "ㄲ";
        "ㄳ";
        "ㄴ";
        "ㄵ";
        "ㄶ";
        "ㄷ";
        "ㄹ";
        "ㄺ";
        "ㄻ";
        "ㄼ";
        "ㄽ";
        "ㄾ";
        "ㄿ";
        "ㅀ";
        "ㅁ";
        "ㅂ";
        "ㅄ";
        "ㅅ";
        "ㅆ";
        "ㅇ";
        "ㅈ";
        "ㅊ";
        "ㅋ";
        "ㅌ";
        "ㅍ";
        "ㅎ";
    },
    function(
        _,
        consonant
    )
        return DISASSEMBLE_CONSONANTS_BY_CONSONANT[consonant];
    end
)

local HANGUL_DIGITS = {
  "만";
  "억";
  "조";
  "경";
  "해";
  "자";
  "양";
  "구";
  "간";
  "정";
  "재";
  "극";
  "항하사";
  "아승기";
  "나유타";
  "불가사의";
  "무량대수";
  "겁";
  "업";
}

local HANGUL_DIGITS_MAX = #HANGUL_DIGITS * 4
local HANGUL_NUMBERS = { "일", "이", "삼", "사", "오", "육", "칠", "팔", "구" }
local HANGUL_NUMBERS_FOR_DECIMAL = { "영", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구" }
local HANGUL_CARDINAL = { "십", "백", "천" }

local ALPHABET_TO_KOREAN = {
    ["A"] = "에이";
    ["B"] = "비";
    ["C"] = "씨";
    ["D"] = "디";
    ["E"] = "이";
    ["F"] = "에프";
    ["G"] = "지";
    ["H"] = "에이치";
    ["I"] = "아이";
    ["J"] = "제이";
    ["K"] = "케이";
    ["L"] = "엘";
    ["M"] = "엠";
    ["N"] = "엔";
    ["O"] = "오";
    ["P"] = "피";
    ["Q"] = "큐";
    ["R"] = "알";
    ["S"] = "에스";
    ["T"] = "티";
    ["U"] = "유";
    ["V"] = "브이";
    ["W"] = "더블유";
    ["X"] = "엑스";
    ["Y"] = "와이";
    ["Z"] = "지";
};