--#[ Head Variables ]#--
local module = {}

--#[ Variables ]#--
local _table = table

--#[ Functions ]#--
--

--#[ Main ]#--
function module.keys<K>(
    table: { [K]: any }
): { K }
    local keys = {}

    for key, _ in next, table, nil do
        _table.insert(keys, key)
    end

    return keys
end

function module.values<V>(
    table: { [any]: V }
): { V }
    local values = {}

    for _, value in next, table, nil do
        _table.insert(values, value)
    end

    return values
end

function module.entries<K, V>(
    table: { [K]: V }
): { { key: K, value: V } }
    local entries = {}

    for key, value in next, table, nil do
        _table.insert(
            entries,
            {
                key = key;
                value = value;
            }
        )
    end

    return entries
end

function module.fromEntries<K, V>(
    entries: { { key: K, value: V } }
): { [K]: V }
    local table: { [K]: V } = {}

    for _, entry in next, entries, nil do
        table[entry.key] = entry.value
    end

    return table
end

function module.assemble<K, V>(
    keys: { K },
    values: { V }
): { [K]: V }
    local table: { [K]: V } = {}

    local length = math.min(#keys, #values)

    for i = 1, length do
        table[keys[i]] = values[i]
    end

    return table
end

function module.merge<V>(
    ...: { V }
): { V }
    local tables = { ... }
    local mergedTable: { V } = {}

    for _, table in next, tables, nil do
        for _, value in next, table, nil do
            _table.insert(mergedTable, value)
        end
    end

    return mergedTable
end

function module.is(
    a: { [any]: any },
    b: { [any]: any }
): boolean
    if a == b then
        return true
    end

    for key, value in next, a do
        if b[key] ~= value then
            return false
        end
    end

    for key, _ in next, b do
        if a[key] == nil then
            return false
        end
    end

    return true
end

function module.foreach<K, V>(
    table: { [K]: V },
    callback: (key: K, value: V) -> ()
)
    for key, value in next, table, nil do
        callback(key, value)
    end
end

function module.map<K, V, U>(
    table: { [K]: V },
    callback: (key: K, value: V) -> U
): { [K]: U }
    local mappedTable: { [K]: U } = {}

    for key, value in next, table, nil do
        mappedTable[key] = callback(key, value)
    end

    return mappedTable
end

function module.filter<K, V>(
    table: { [K]: V },
    callback: (key: K, value: V) -> boolean
): { [K]: V }
    local filteredTable: { [K]: V } = {}

    for key, value in next, table, nil do
        if callback(key, value) then
            filteredTable[key] = value
        end
    end

    return filteredTable
end

function module.assign<K, V>(
    target: { [K]: V },
    ...: { [K]: V }
): { [K]: V }
    local sources = { ... }

    for _, source in next, sources, nil do
        for key, value in next, source, nil do
            target[key] = value
        end
    end

    return target
end

function module.assignIfNil<K, V>(
    target: { [K]: V },
    ...: { [K]: V }
): { [K]: V }
    local sources = { ... }

    for _, source in next, sources, nil do
        for key, value in next, source, nil do
            if target[key] == nil then
                target[key] = value
            end
        end
    end

    return target
end

function module.reduce<K, V, U>(
    table: { [K]: V },
    callback: (accumulator: U, key: K, value: V) -> U,
    initialValue: U
): U
    local accumulator: U = initialValue

    for key, value in next, table, nil do
        accumulator = callback(accumulator, key, value)
    end

    return accumulator
end

function module.size<K, V>(
    table: { [K]: V }
): number
    local count = 0

    for _, _ in next, table, nil do
        count += 1
    end

    return count
end

return module