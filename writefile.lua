local function writefile(name, data)
    -- Imprimir los datos y el nombre del archivo (para depuración)
    print("Data: ", data)
    print("File Name: ", name)

    -- Abrir el archivo en modo de escritura
    local file, err = io.open(name, "w")
    if not file then
        -- Si ocurre un error al abrir el archivo, imprimir el error y salir de la función
        print("Error opening file: " .. err)
        return false, err
    end

    -- Escribir los datos en el archivo
    file:write(data)

    -- Cerrar el archivo
    file:close()

    print("File written successfully at path: " .. name)
    return true
end

return writefile