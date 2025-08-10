local MAJOR = "PNK_LibStub";
local MINOR = 1;

local lib_stub = _G[MAJOR];

if lib_stub ~= nil and lib_stub.minor >= MINOR then
    return;
end

PNK_LibStub = PNK_LibStub or {
    libraries = {},
    revisions = {},
};

function PNK_LibStub:NewLibrary(major, minor)
    assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (expected string).");
    assert(type(minor) == "number", "Bad argument #3 to `NewLibrary' (expected number).");

    local existing_revision = self.revisions[major];
    if existing_revision ~= nil and existing_revision >= minor then
        return nil;
    end

    self.libraries[major] = self.libraries[major] or {};
    self.revisions[major] = minor;
    return self.libraries[major], existing_revision;
end

function PNK_LibStub:GetLibrary(major, silence_errors)
    assert(type(major) == "string", "Bad argument #2 to `GetLibrary' (expected string).");

    if self.libraries[major] == nil and not silence_errors then
        error(string.format("Cannot find a library instance of `%q'.", major), 2);
    end

    return self.libraries[major], self.revisions[major];
end
