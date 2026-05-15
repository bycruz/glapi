---@class gl.RawEnums
local gl = {}

---@enum gl.DebugOutput
gl.DebugOutput = {
	DebugOutput = 0x92E0,
	DebugOutputSynchronous = 0x8242
}

---@enum gl.Constants
gl.Constants = {
	DontCare = 0x1100,
	TextureMaxAnisotropy = 0x84FE,
	Framebuffer = 0x8D40,
	ColorAttachment0 = 0x8CE0,
	FramebufferComplete = 0x8CD5,
	SyncGpuCommandsComplete = 0x9117,
	SyncFlushCommandsBit = 0x00000001
}

---@enum gl.Error
gl.Error = {
	InvalidValue = 0x0501,
	InvalidOperation = 0x0502
}

---@enum gl.BufferBit
gl.BufferBit = {
	ColorBufferBit = 0x4000,
	DepthBufferBit = 0x0100
}

---@enum gl.Capability
gl.Capability = {
	DepthTest = 0x0B71,
	Blend = 0x0BE2,
	CullFace = 0x0B44
}

---@enum gl.CullMode
gl.CullMode = {
	Front = 0x0404,
	Back = 0x0405,
	FrontAndBack = 0x0408
}

---@enum gl.FrontFace
gl.FrontFace = {
	Cw = 0x0900,
	Ccw = 0x0901
}

---@enum gl.DrawMode
gl.DrawMode = {
	StaticDraw = 0x88E4,
	DynamicDraw = 0x88E8
}

---@enum gl.ShaderBit
gl.ShaderBit = {
	VertexShaderBit = 0x00000001,
	FragmentShaderBit = 0x00000002,
	ComputeShaderBit = 0x00000020
}

---@enum gl.DataType
gl.DataType = {
	Float = 0x1406,
	UnsignedInt = 0x1405,
	UnsignedShort = 0x1403,
	Int = 0x1404,
	UnsignedByte = 0x1401
}

---@enum gl.PrimitiveType
gl.PrimitiveType = {
	Triangles = 0x0004
}

---@enum gl.ShaderType
gl.ShaderType = {
	Vertex = 0x8B31,
	Fragment = 0x8B30,
	Compute = 0x91B9
}

---@enum gl.TextureTarget
gl.TextureTarget = {
	Texture1D = 0x0DE0,
	Texture1DArray = 0x8C18,
	Texture2D = 0x0DE1,
	Texture2DArray = 0x8C1A,
	Texture3D = 0x806F
}

---@enum gl.InternalFormat
gl.InternalFormat = {
	Rgba8 = 0x8058,
	DepthComponent24 = 0x81A6
}

---@enum gl.PixelFormat
gl.PixelFormat = {
	Rg = 0x8227,
	Rgb = 0x1907,
	Rgba = 0x1908
}

---@enum gl.TextureWrap
gl.TextureWrap = {
	TextureWrapS = 0x2802,
	TextureWrapT = 0x2803,
	TextureWrapR = 0x8072,
	ClampToEdge = 0x812F,
	Repeat = 0x2901,
	MirroredRepeat = 0x8370
}

---@enum gl.TextureFilter
gl.TextureFilter = {
	TextureMinFilter = 0x2801,
	TextureMagFilter = 0x2800,
	Nearest = 0x2600,
	Linear = 0x2601
}

---@enum gl.TextureCompareMode
gl.TextureCompareMode = {
	TextureCompareMode = 0x884C,
	TextureCompareFunc = 0x884D,
	CompareRefToTexture = 0x884E,
	None = 0x0000
}

---@enum gl.TextureLodRange
gl.TextureLodRange = {
	TextureMinLod = 0x813A,
	TextureMaxLod = 0x813B
}

---@enum gl.BufferTarget
gl.BufferTarget = {
	UniformBuffer = 0x8A11,
	ShaderStorageBuffer = 0x90D2,
	PixelPackBuffer = 0x88EB
}

---@enum gl.BarrierBit
gl.BarrierBit = {
	ShaderStorageBarrierBit = 0x00002000,
	BufferUpdateBarrierBit = 0x00000200,
	ShaderImageAccessBarrierBit = 0x00000020,
	AllBarrierBits = 0xFFFFFFFF
}

---@enum gl.BlendFactor
gl.BlendFactor = {
	SrcAlpha = 0x0302,
	OneMinusSrcAlpha = 0x0303
}

---@enum gl.BufferAccess
gl.BufferAccess = {
	ReadWrite = 0x88BA,
	WriteOnly = 0x88B9,
	ReadOnly = 0x88B8
}

---@enum gl.CompareFunc
gl.CompareFunc = {
	Less = 0x0201,
	LessEqual = 0x0203,
	Greater = 0x0204,
	GreaterEqual = 0x0206,
	Equal = 0x0202,
	NotEqual = 0x0205,
	Always = 0x0207,
	Never = 0x0200
}

---@enum gl.UnpackParam
gl.UnpackParam = {
	UnpackAlignment = 0x0CF5,
	UnpackRowLength = 0x0CF2,
	UnpackImageHeight = 0x806E
}

---@enum gl.PackParam
gl.PackParam = {
	PackAlignment = 0x0D05,
	PackRowLength = 0x0D02,
	PackImageHeight = 0x806C
}

do
	-- Backwards-compatible aliases for raw GL constant names
	gl.DEBUG_OUTPUT = gl.DebugOutput.DebugOutput
	gl.DEBUG_OUTPUT_SYNCHRONOUS = gl.DebugOutput.DebugOutputSynchronous

	gl.DONT_CARE = gl.Constants.DontCare

	gl.INVALID_VALUE = gl.Error.InvalidValue
	gl.INVALID_OPERATION = gl.Error.InvalidOperation

	gl.COLOR_BUFFER_BIT = gl.BufferBit.ColorBufferBit
	gl.DEPTH_BUFFER_BIT = gl.BufferBit.DepthBufferBit

	gl.DEPTH_TEST = gl.Capability.DepthTest

	gl.STATIC_DRAW = gl.DrawMode.StaticDraw
	gl.DYNAMIC_DRAW = gl.DrawMode.DynamicDraw

	gl.VERTEX_SHADER_BIT = gl.ShaderBit.VertexShaderBit
	gl.FRAGMENT_SHADER_BIT = gl.ShaderBit.FragmentShaderBit
	gl.COMPUTE_SHADER_BIT = gl.ShaderBit.ComputeShaderBit

	gl.FLOAT = gl.DataType.Float
	gl.UNSIGNED_INT = gl.DataType.UnsignedInt
	gl.UNSIGNED_SHORT = gl.DataType.UnsignedShort
	gl.INT = gl.DataType.Int
	gl.UNSIGNED_BYTE = gl.DataType.UnsignedByte

	gl.TRIANGLES = gl.PrimitiveType.Triangles

	gl.VERTEX_SHADER = gl.ShaderType.Vertex
	gl.FRAGMENT_SHADER = gl.ShaderType.Fragment
	gl.COMPUTE_SHADER = gl.ShaderType.Compute

	gl.TEXTURE_1D = gl.TextureTarget.Texture1D
	gl.TEXTURE_1D_ARRAY = gl.TextureTarget.Texture1DArray
	gl.TEXTURE_2D = gl.TextureTarget.Texture2D
	gl.TEXTURE_2D_ARRAY = gl.TextureTarget.Texture2DArray
	gl.TEXTURE_3D = gl.TextureTarget.Texture3D

	gl.RGBA8 = gl.InternalFormat.Rgba8
	gl.DEPTH_COMPONENT24 = gl.InternalFormat.DepthComponent24

	gl.RG = gl.PixelFormat.Rg
	gl.RGB = gl.PixelFormat.Rgb
	gl.RGBA = gl.PixelFormat.Rgba

	gl.TEXTURE_WRAP_S = gl.TextureWrap.TextureWrapS
	gl.TEXTURE_WRAP_T = gl.TextureWrap.TextureWrapT
	gl.TEXTURE_WRAP_R = gl.TextureWrap.TextureWrapR
	gl.CLAMP_TO_EDGE = gl.TextureWrap.ClampToEdge
	gl.REPEAT = gl.TextureWrap.Repeat
	gl.MIRRORED_REPEAT = gl.TextureWrap.MirroredRepeat

	gl.TEXTURE_MIN_FILTER = gl.TextureFilter.TextureMinFilter
	gl.TEXTURE_MAG_FILTER = gl.TextureFilter.TextureMagFilter
	gl.NEAREST = gl.TextureFilter.Nearest
	gl.LINEAR = gl.TextureFilter.Linear

	gl.TEXTURE_COMPARE_MODE = gl.TextureCompareMode.TextureCompareMode
	gl.TEXTURE_COMPARE_FUNC = gl.TextureCompareMode.TextureCompareFunc
	gl.COMPARE_REF_TO_TEXTURE = gl.TextureCompareMode.CompareRefToTexture
	gl.NONE = gl.TextureCompareMode.None

	gl.TEXTURE_MIN_LOD = gl.TextureLodRange.TextureMinLod
	gl.TEXTURE_MAX_LOD = gl.TextureLodRange.TextureMaxLod

	gl.TEXTURE_MAX_ANISOTROPY = gl.Constants.TextureMaxAnisotropy

	gl.UNIFORM_BUFFER = gl.BufferTarget.UniformBuffer
	gl.SHADER_STORAGE_BUFFER = gl.BufferTarget.ShaderStorageBuffer

	gl.SHADER_STORAGE_BARRIER_BIT = gl.BarrierBit.ShaderStorageBarrierBit
	gl.BUFFER_UPDATE_BARRIER_BIT = gl.BarrierBit.BufferUpdateBarrierBit
	gl.SHADER_IMAGE_ACCESS_BARRIER_BIT = gl.BarrierBit.ShaderImageAccessBarrierBit
	gl.ALL_BARRIER_BITS = gl.BarrierBit.AllBarrierBits

	gl.BLEND = gl.Capability.Blend
	gl.SRC_ALPHA = gl.BlendFactor.SrcAlpha
	gl.ONE_MINUS_SRC_ALPHA = gl.BlendFactor.OneMinusSrcAlpha

	gl.READ_WRITE = gl.BufferAccess.ReadWrite
	gl.WRITE_ONLY = gl.BufferAccess.WriteOnly
	gl.READ_ONLY = gl.BufferAccess.ReadOnly

	gl.SYNC_GPU_COMMANDS_COMPLETE = gl.Constants.SyncGpuCommandsComplete
	gl.SYNC_FLUSH_COMMANDS_BIT = gl.Constants.SyncFlushCommandsBit

	gl.LESS = gl.CompareFunc.Less
	gl.LESS_EQUAL = gl.CompareFunc.LessEqual
	gl.GREATER = gl.CompareFunc.Greater
	gl.GREATER_EQUAL = gl.CompareFunc.GreaterEqual
	gl.EQUAL = gl.CompareFunc.Equal
	gl.NOTEQUAL = gl.CompareFunc.NotEqual
	gl.ALWAYS = gl.CompareFunc.Always
	gl.NEVER = gl.CompareFunc.Never

	gl.FRAMEBUFFER = gl.Constants.Framebuffer
	gl.COLOR_ATTACHMENT0 = gl.Constants.ColorAttachment0
	gl.FRAMEBUFFER_COMPLETE = gl.Constants.FramebufferComplete

	gl.UNPACK_ALIGNMENT = gl.UnpackParam.UnpackAlignment
	gl.UNPACK_ROW_LENGTH = gl.UnpackParam.UnpackRowLength
	gl.UNPACK_IMAGE_HEIGHT = gl.UnpackParam.UnpackImageHeight

	gl.PACK_ALIGNMENT = gl.PackParam.PackAlignment
	gl.PACK_ROW_LENGTH = gl.PackParam.PackRowLength
	gl.PACK_IMAGE_HEIGHT = gl.PackParam.PackImageHeight

	gl.PIXEL_PACK_BUFFER = gl.BufferTarget.PixelPackBuffer

	gl.CULL_FACE = gl.Capability.CullFace

	gl.FRONT = gl.CullMode.Front
	gl.BACK = gl.CullMode.Back
	gl.FRONT_AND_BACK = gl.CullMode.FrontAndBack

	gl.CW = gl.FrontFace.Cw
	gl.CCW = gl.FrontFace.Ccw
end

return gl
