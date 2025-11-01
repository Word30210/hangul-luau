local assemble = require("@self/core/assemble")
local canBe = require("@self/core/canBe")
local combine = require("@self/core/combine")
local disassemble = require("@self/core/disassemble")
local getChoseong = require("@self/core/getChoseong")
local hasBatchim = require("@self/core/hasBatchim")
local josa = require("@self/core/josa")
local removeLastCharacter = require("@self/core/removeLastCharacter")

return {
    assemble = assemble;
    canBe = canBe;
    combine = combine;
    disassemble = disassemble;
    getChoseong = getChoseong;
    hasBatchim = hasBatchim;
    josa = josa;
    removeLastCharacter = removeLastCharacter;
}