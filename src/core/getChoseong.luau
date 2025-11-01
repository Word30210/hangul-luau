--[[
    Luau에는 normalize관련 기능이 없기 때문에 다른 방식으로 초성을 구한다.
]]

--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local better_table = require("@lune_packages/better_table")
local disassemble = require("../core/disassemble")
local constants = require("../internal/constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
--

--#[ Main ]#--
function module.getChoseong(
    word: string
): string
    return better_table.reduce(
        disassemble.disassembleToGroups(word),
        function(
            accumulator: string,
            key: number,
            value: { string }
        )
            local choseong = value[1]

            return `{ accumulator }{ choseong }`
        end,
        ""
    )
end

return module