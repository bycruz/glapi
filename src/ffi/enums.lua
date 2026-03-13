---@class gl.Enums
local gl = {}

--- @enum gl.Debug
gl.Debug = {
    OUTPUT = 0x92E0,
    OUTPUT_SYNCHRONOUS = 0x8242,
}

--- @enum gl.Error
gl.Error = {
    INVALID_VALUE = 0x0501,
    INVALID_OPERATION = 0x0502,
}

--- @enum gl.Hint
gl.Hint = {
    DONT_CARE = 0x1100,
}

--- @enum gl.BufferBit
gl.BufferBit = {
    COLOR = 0x4000,
    DEPTH = 0x0100,
}

--- @enum gl.Capability
gl.Capability = {
    DEPTH_TEST = 0x0B71,
    BLEND = 0x0BE2,
    CULL_FACE = 0x0B44,
}

--- @enum gl.Usage
gl.Usage = {
    STATIC_DRAW = 0x88E4,
    DYNAMIC_DRAW = 0x88E8,
}

--- @enum gl.ShaderBit
gl.ShaderBit = {
    VERTEX = 0x00000001,
    FRAGMENT = 0x00000002,
    COMPUTE = 0x00000020,
}

--- @enum gl.Type
gl.Type = {
    FLOAT = 0x1406,
    UNSIGNED_INT = 0x1405,
    UNSIGNED_SHORT = 0x1403,
    UNSIGNED_BYTE = 0x1401,
    INT = 0x1404,
}

--- @enum gl.Primitive
gl.Primitive = {
    TRIANGLES = 0x0004,
}

--- @enum gl.ShaderType
gl.ShaderType = {
    VERTEX = 0x8B31,
    FRAGMENT = 0x8B30,
    COMPUTE = 0x91B9,
}

--- @enum gl.TextureTarget
gl.TextureTarget = {
    TEXTURE_1D = 0x0DE0,
    TEXTURE_1D_ARRAY = 0x8C18,
    TEXTURE_2D = 0x0DE1,
    TEXTURE_2D_ARRAY = 0x8C1A,
    TEXTURE_3D = 0x806F,
}

--- @enum gl.InternalFormat
gl.InternalFormat = {
    RGBA8 = 0x8058,
    DEPTH_COMPONENT24 = 0x81A6,
}

--- @enum gl.PixelFormat
gl.PixelFormat = {
    RG = 0x8227,
    RGB = 0x1907,
    RGBA = 0x1908,
}

--- @enum gl.TextureParam
gl.TextureParam = {
    WRAP_S = 0x2802,
    WRAP_T = 0x2803,
    WRAP_R = 0x8072,
    MIN_FILTER = 0x2801,
    MAG_FILTER = 0x2800,
    COMPARE_MODE = 0x884C,
    COMPARE_FUNC = 0x884D,
    MIN_LOD = 0x813A,
    MAX_LOD = 0x813B,
    MAX_ANISOTROPY = 0x84FE,
}

--- @enum gl.TextureWrap
gl.TextureWrap = {
    CLAMP_TO_EDGE = 0x812F,
    REPEAT = 0x2901,
    MIRRORED_REPEAT = 0x8370,
}

--- @enum gl.TextureFilter
gl.TextureFilter = {
    NEAREST = 0x2600,
    LINEAR = 0x2601,
}

--- @enum gl.TextureCompare
gl.TextureCompare = {
    COMPARE_REF_TO_TEXTURE = 0x884E,
    NONE = 0x0000,
}

--- @enum gl.BufferTarget
gl.BufferTarget = {
    UNIFORM = 0x8A11,
    SHADER_STORAGE = 0x90D2,
}

--- @enum gl.BarrierBit
gl.BarrierBit = {
    SHADER_STORAGE = 0x00002000,
    BUFFER_UPDATE = 0x00000200,
    SHADER_IMAGE_ACCESS = 0x00000020,
    ALL = 0xFFFFFFFF,
}

--- @enum gl.BlendFactor
gl.BlendFactor = {
    SRC_ALPHA = 0x0302,
    ONE_MINUS_SRC_ALPHA = 0x0303,
}

--- @enum gl.Access
gl.Access = {
    READ_WRITE = 0x88BA,
    WRITE_ONLY = 0x88B9,
    READ_ONLY = 0x88B8,
}

--- @enum gl.SyncCondition
gl.SyncCondition = {
    GPU_COMMANDS_COMPLETE = 0x9117,
}

--- @enum gl.SyncBit
gl.SyncBit = {
    FLUSH_COMMANDS = 0x00000001,
}

--- @enum gl.DepthFunc
gl.DepthFunc = {
    LESS = 0x0201,
    LESS_EQUAL = 0x0203,
    GREATER = 0x0204,
    GREATER_EQUAL = 0x0206,
    EQUAL = 0x0202,
    NOTEQUAL = 0x0205,
    ALWAYS = 0x0207,
    NEVER = 0x0200,
}

--- @enum gl.Framebuffer
gl.Framebuffer = {
    FRAMEBUFFER = 0x8D40,
    COLOR_ATTACHMENT0 = 0x8CE0,
    COMPLETE = 0x8CD5,
}

--- @enum gl.PixelStore
gl.PixelStore = {
    UNPACK_ALIGNMENT = 0x0CF5,
    UNPACK_ROW_LENGTH = 0x0CF2,
    UNPACK_IMAGE_HEIGHT = 0x806E,
}

return gl
