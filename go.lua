VERSION = "1.0.1"

if GetOption("goimports") == nil then
    AddOption("goimports", false)
end
if GetOption("gofmt") == nil then
    AddOption("gofmt", true)
end

MakeCommand("goimports", "go.goimports", 0)
MakeCommand("gofmt", "go.gofmt", 0)
MakeCommand("gorename", "go.gorename", 0)

function onViewOpen(view)
    if view.Buf:FileType() == "go" then
        SetLocalOption("tabstospaces", "off", view)
    end
end

function onSave(view)
    if CurView().Buf:FileType() == "go" then
        if GetOption("goimports") then
            goimports()
        elseif GetOption("gofmt") then
            gofmt()
        end
    end
end

function gofmt()
    CurView():Save(false)
    local handle = io.popen("gofmt -w " .. CurView().Buf.Path)
    local result = handle:read("*a")
    handle:close()

    CurView():ReOpen()
end

function gorename()
    local res, canceled = messenger:Prompt("Rename to:", "", 0)
    if not canceled then
        gorenameCmd(res)
        CurView():Save(false)
    end
end

function gorenameCmd(res)
    CurView():Save(false)
    local v = CurView()
    local c = v.Cursor
    local buf = v.Buf
    local loc = Loc(c.X, c.Y)
    local offset = ByteOffset(loc, buf)
    if #res > 0 then
        local cmd = "gorename --offset " .. CurView().Buf.Path .. ":#" .. tostring(offset) .. " --to " .. res
        JobStart(cmd, "", "go.renameStderr", "go.renameExit")
        messenger:Message("Renaming...")
    end
end

function renameStderr(err)
    messenger:Error(err)
end

function renameExit()
    CurView():ReOpen()
    messenger:Message("Done")
end

function goimports()
    CurView():Save(false)
    local handle = io.popen("goimports -w " .. CurView().Buf.Path)
    local result = split(handle:read("*a"), ":")
    handle:close()

    CurView():ReOpen()
end

function split(str, sep)
    local result = {}
    local regex = ("([^%s]+)"):format(sep)
    for each in str:gmatch(regex) do
        table.insert(result, each)
    end
    return result
end

AddRuntimeFile("go", "help", "help/go-plugin.md")
BindKey("F6", "go.gorename")
MakeCommand("gorename", "go.gorenameCmd", 0)
