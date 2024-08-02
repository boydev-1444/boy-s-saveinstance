local function writefile(name, data)
    local file, err = io.open(name, "w")
    if not file then
        print("Error opening file: " .. err)
        return false, err
    end
    file:write(data)

    file:close()

    print("File written successfully at path: " .. name)
    return true
end

return writefile
