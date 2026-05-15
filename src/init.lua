local ffi = require("ffi")

ffi.cdef([[#embed "ffi/ffidefs.h"]])

---@class gl: gl.RawEnums
local gl = {}

local glEnums = require("glapi.ffi.enums")
for k, v in pairs(glEnums) do
	gl[k] = v
end

---@type table<string, string>
---@format disable-next
local nonCoreFnDefs = {
	glCreateShaderProgramv = "GLuint(*)(GLenum, GLsizei, const GLchar**)",
	glGetProgramiv = "void(*)(GLuint, GLenum, GLint*)",
	glGetProgramInfoLog = "void(*)(GLuint, GLsizei, GLsizei*, GLchar*)",
	glUseProgram = "void(*)(GLuint)",
	glDeleteProgram = "void(*)(GLuint)",

	glGenProgramPipelines = "void(*)(GLsizei, GLuint*)",
	glUseProgramStages = "void(*)(GLuint, unsigned int, GLuint)",
	glBindProgramPipeline = "void(*)(GLuint)",
	glDeleteProgramPipelines = "void(*)(GLsizei, const GLuint*)",

	glProgramUniform1i = "void(*)(GLuint, GLint, GLint)",
	glProgramUniform1f = "void(*)(GLuint, GLint, GLfloat)",
	glProgramUniform2i = "void(*)(GLuint, GLint, GLint, GLint)",
	glProgramUniform2f = "void(*)(GLuint, GLint, GLfloat, GLfloat)",
	glProgramUniform3f = "void(*)(GLuint, GLint, GLfloat, GLfloat, GLfloat)",
	glProgramUniform4f = "void(*)(GLuint, GLint, GLfloat, GLfloat, GLfloat, GLfloat)",
	glProgramUniformMatrix4fv = "void(*)(GLuint, GLint, GLsizei, unsigned char, const GLfloat*)",

	glVertexArrayVertexBuffer = "void(*)(GLuint, GLuint, GLuint, GLintptr, GLsizei)",
	glVertexArrayElementBuffer = "void(*)(GLuint, GLuint)",
	glEnableVertexArrayAttrib = "void(*)(GLuint, GLuint)",
	glVertexArrayAttribFormat = "void(*)(GLuint, GLuint, GLint, GLenum, unsigned char, GLuint)",
	glVertexArrayAttribBinding = "void(*)(GLuint, GLuint, GLuint)",
	glBindVertexArray = "void(*)(GLuint)",
	glCreateVertexArrays = "void(*)(GLsizei, GLuint*)",

	glCreateBuffers = "void(*)(GLsizei, GLuint*)",
	glDeleteBuffers = "void(*)(GLsizei, const GLuint*)",
	glBindBuffer = "void(*)(GLenum, GLuint)",
	glNamedBufferData = "void(*)(GLuint, GLsizeiptr, const void*, GLenum)",
	glNamedBufferSubData = "void(*)(GLuint, GLintptr, GLsizeiptr, const void*)",

	glCreateTextures = "void(*)(GLenum, GLsizei, GLuint*)",
	glTextureStorage1D = "void(*)(GLuint, GLsizei, GLenum, GLsizei)",
	glTextureSubImage1D = "void(*)(GLuint, GLsizei, GLint, GLsizei, GLenum, GLenum, const void*)",
	glTextureStorage2D = "void(*)(GLuint, GLsizei, GLenum, GLsizei, GLsizei)",
	glTextureSubImage2D = "void(*)(GLuint, GLsizei, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, const void*)",
	glTextureStorage3D = "void(*)(GLuint, GLsizei, GLenum, GLsizei, GLsizei, GLsizei)",
	glTextureSubImage3D = "void(*)(GLuint, GLsizei, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const void*)",
	glBindTextureUnit = "void(*)(GLuint, GLuint)",
	glCopyImageSubData = "void(*)(GLuint, GLenum, GLint, GLint, GLint, GLint, GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei)",
	glGetTextureSubImage = "void(*)(GLuint, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLsizei, void*)",

	glBindBufferBase = "void(*)(GLenum, GLuint, GLuint)",

	glDispatchCompute = "void(*)(GLuint, GLuint, GLuint)",
	glMemoryBarrier = "void(*)(unsigned int)",
	glBindImageTexture = "void(*)(GLuint, GLuint, GLint, unsigned char, GLint, GLenum, GLenum)",

	glCreateFramebuffers = "void(*)(GLsizei, GLuint*)",
	glBindFramebuffer = "void(*)(GLenum, GLuint)",
	glNamedFramebufferTexture = "void(*)(GLuint, GLenum, GLuint, GLint)",
	glNamedFramebufferTextureLayer = "void(*)(GLuint, GLenum, GLuint, GLint, GLint)",
	glCheckNamedFramebufferStatus = "GLenum(*)(GLuint, GLenum)",
	glDeleteFramebuffers = "void(*)(GLsizei, const GLuint*)",

	glGenSamplers = "void(*)(GLsizei, GLuint*)",
	glDeleteSamplers = "void(*)(GLsizei, const GLuint*)",
	glSamplerParameteri = "void(*)(GLuint, GLenum, GLint)",
	glSamplerParameterf = "void(*)(GLuint, GLenum, GLfloat)",
	glBindSampler = "void(*)(GLuint, GLuint)",

	glIsVertexArray = "GLboolean(*)(GLuint)",
	glIsBuffer = "GLboolean(*)(GLuint)",

	glPixelStorei = "void(*)(GLenum, GLint)",

	glClearDepthf = "void(*)(GLfloat)",

	glCullFace = "void(*)(GLenum)",
	glFrontFace = "void(*)(GLenum)",

	glDebugMessageCallback = "void(*)(GLDEBUGPROC, const void*)",
	glDebugMessageControl = "void(*)(GLenum, GLenum, GLenum, GLsizei, const GLuint*, unsigned char)",
}

---@type fun(name: string): function
local fetchNonCoreFn

if jit.os == "Linux" then
	local glx = require("x11api.glx")

	function fetchNonCoreFn(name)
		---@type function: We ensure nonCoreFnDefs has only function types
		return ffi.cast(nonCoreFnDefs[name], glx.getProcAddress(name))
	end
elseif jit.os == "Windows" then
	local wgl = require("winapi.wgl")

	function fetchNonCoreFn(name)
		local cached

		-- todo: investigate if using varargs here will cause jit to fail
		return function(...)
			if cached then
				return cached(...)
			end

			local fn = ffi.cast(nonCoreFnDefs[name], wgl.getProcAddress(name))
			if fn == nil then
				error("Cannot call OpenGL function: " .. name .. " when context is not ready")
			end

			cached = fn
			return fn(...)
		end
	end
end

---@type table<string, function>
local C = {}
for name in pairs(nonCoreFnDefs) do
	C[name] = fetchNonCoreFn(name)
end

local coreFns =
	jit.os == "Linux" and ffi.load("libGL.so.1")
	or jit.os == "Windows" and ffi.load("opengl32")
	or error("Unsupported platform for OpenGL: " .. ffi.os)

setmetatable(C, { __index = coreFns })

--- @param type gl.ShaderType
--- @param src string
--- @return number
gl.createShaderProgram = function(type, src)
	local srcs = ffi.new("const char*[1]", { src })
	local program = C.glCreateShaderProgramv(type, 1, srcs)

	local status = ffi.new("GLint[1]")
	C.glGetProgramiv(program, 0x8B82 --[[GL_LINK_STATUS]], status)

	if status[0] == 0 then
		local infoLogLength = ffi.new("GLint[1]")
		C.glGetProgramiv(program, 0x8B84 --[[GL_INFO_LOG_LENGTH]], infoLogLength)

		local infoLog = ffi.new("GLchar[?]", infoLogLength[0])
		C.glGetProgramInfoLog(program, infoLogLength[0], nil, infoLog)

		error("Shader compilation failed: " .. ffi.string(infoLog))
	end

	return program
end

---@type fun(mask: number)
gl.clear = C.glClear

---@type fun(r: number, g: number, b: number, a: number)
gl.clearColor = C.glClearColor

---@type fun(x: number, y: number, width: number, height: number)
gl.viewport = C.glViewport

---@param n number
---@return number[]
gl.genProgramPipelines = function(n)
	local handle = ffi.new("GLuint[?]", n)
	C.glGenProgramPipelines(n, handle)

	local pipelineIds = {}
	for i = 0, n - 1 do
		pipelineIds[i + 1] = handle[i]
	end

	return pipelineIds
end

---@type fun(pipeline: number, stages: number, program: number)
gl.useProgramStages = C.glUseProgramStages

---@type fun(pipeline: number)
gl.bindProgramPipeline = C.glBindProgramPipeline

---@type fun(program: number)
gl.deleteProgram = C.glDeleteProgram

---@type fun(n: number, pipelines: ffi.cdata*)
gl.deleteProgramPipelines = C.glDeleteProgramPipelines

---@type fun(n: number, buffers: ffi.cdata*)
gl.createBuffers = C.glCreateBuffers

---@type fun(buffer: number, size: number, data: ffi.cdata*?, usage: number)
gl.namedBufferData = C.glNamedBufferData

---@type fun(n: number, buffers: ffi.cdata*)
gl.destroyBuffers = C.glDeleteBuffers

---@type fun(target: number, buffer: number)
gl.bindBuffer = C.glBindBuffer

---@type fun(buffer: number, offset: number, size: number, data: ffi.cdata*)
gl.namedBufferSubData = C.glNamedBufferSubData

---@type fun(vaobj: number, bindingindex: number, buffer: number, offset: number, stride: number)
gl.vertexArrayVertexBuffer = C.glVertexArrayVertexBuffer

---@type fun(vaobj: number, buffer: number)
gl.vertexArrayElementBuffer = C.glVertexArrayElementBuffer

---@type fun(vaobj: number, attribindex: number)
gl.enableVertexArrayAttrib = C.glEnableVertexArrayAttrib

---@type fun(vaobj: number, attribindex: number, size: number, type: number, normalized: number, relativeoffset: number)
gl.vertexArrayAttribFormat = C.glVertexArrayAttribFormat

---@type fun(vaobj: number, attribindex: number, bindingindex: number)
gl.vertexArrayAttribBinding = C.glVertexArrayAttribBinding

---@type fun(array: number)
gl.bindVertexArray = C.glBindVertexArray

---@type fun(n: number, arrays: ffi.cdata*)
gl.createVertexArrays = C.glCreateVertexArrays

---@type fun(mode: number, count: number, type: number, indices: ffi.cdata*?)
gl.drawElements = C.glDrawElements

---@type fun(name: number): string
gl.getString = function(name)
	local str = C.glGetString(name)
	return ffi.string(str)
end

---@type fun(pId: number, uId: number, v0: ffi.cdata*)
gl.programUniform1i = C.glProgramUniform1i

---@type fun(pId: number, uId: number, v0: number)
gl.programUniform1f = C.glProgramUniform1f

---@type fun(pId: number, uId: number, v0: number, v1: number)
gl.programUniform2i = C.glProgramUniform2i

---@type fun(pId: number, uId: number, v0: number, v1: number)
gl.programUniform2f = C.glProgramUniform2f

---@type fun(pId: number, uId: number, v0: number, v1: number, v2: number)
gl.programUniform3f = C.glProgramUniform3f

---@type fun(pId: number, uId: number, v0: number, v1: number, v2: number, v3: number)
gl.programUniform4f = C.glProgramUniform4f

---@type fun(pId: number, uId: number, count: number, transpose: number, value: ffi.cdata*)
gl.programUniformMatrix4fv = C.glProgramUniformMatrix4fv

---@type fun(target: number, n: number): number[]
gl.createTextures = function(target, n)
	local handle = ffi.new("GLuint[?]", n)
	C.glCreateTextures(target, n, handle)

	local textureIds = {}
	for i = 0, n - 1 do
		textureIds[i + 1] = handle[i]
	end

	return textureIds
end

---@type fun(texture: number, levels: number, internalformat: number, width: number)
gl.textureStorage1D = C.glTextureStorage1D

---@type fun(texture: number, level: number, xoffset: number, width: number, format: number, type: number, pixels: ffi.cdata*)
gl.textureSubImage1D = C.glTextureSubImage1D

---@type fun(texture: number, levels: number, internalformat: number, width: number, height: number)
gl.textureStorage2D = C.glTextureStorage2D

---@type fun(texture: number, level: number, xoffset: number, yoffset: number, width: number, height: number, format: number, type: number, pixels: ffi.cdata*)
gl.textureSubImage2D = C.glTextureSubImage2D

---@type fun(texture: number, levels: number, internalformat: number, width: number, height: number, depth: number)
gl.textureStorage3D = C.glTextureStorage3D

---@type fun(texture: number, level: number, xoffset: number, yoffset: number, zoffset: number, width: number, height: number, depth: number, format: number, type: number, pixels: ffi.cdata*)
gl.textureSubImage3D = C.glTextureSubImage3D

---@type fun(texture: number, level: number, xoffset: number, yoffset: number, zoffset: number, width: number, height: number, depth: number, format: number, type: number, bufSize: number, pixels: ffi.cdata*)
gl.getTextureSubImage = C.glGetTextureSubImage

---@type fun(unit: number, texture: number)
gl.bindTextureUnit = C.glBindTextureUnit

---@type fun(textures: number[])
gl.deleteTextures = function(textures)
	local n = #textures
	local handle = ffi.new("GLuint[?]", n, textures)
	C.glDeleteTextures(n, handle)
end

---@type fun(target: number, index: number, buffer: number)
gl.bindBufferBase = C.glBindBufferBase

---@type fun(num_groups_x: number, num_groups_y: number, num_groups_z: number)
gl.dispatchCompute = C.glDispatchCompute

---@type fun(barriers: number)
gl.memoryBarrier = C.glMemoryBarrier

---@type fun(cap: number)
gl.enable = C.glEnable

---@type fun(cap: number)
gl.disable = C.glDisable

---@type fun(mode: number)
gl.cullFace = C.glCullFace

---@type fun(mode: number)
gl.frontFace = C.glFrontFace

---@type fun(sfactor: number, dfactor: number)
gl.blendFunc = C.glBlendFunc

---@type fun(unit: number, texture: number, level: number, layered: number, layer: number, access: number, format: number)
gl.bindImageTexture = C.glBindImageTexture

---@type fun()
gl.finish = C.glFinish

---@type fun()
gl.flush = C.glFlush

---@type fun(srcName: number, srcTarget: number, srcLevel: number, srcX: number, srcY: number, srcZ: number, dstName: number, dstTarget: number, dstLevel: number, dstX: number, dstY: number, dstZ: number, width: number, height: number, depth: number)
gl.copyImageSubData = C.glCopyImageSubData

---@type fun(func: number)
gl.depthFunc = C.glDepthFunc

---@type fun(flag: boolean)
gl.depthMask = function(flag)
	C.glDepthMask(flag and 1 or 0)
end

---@type fun(depth: number)
gl.clearDepthf = C.glClearDepthf

---@return number
gl.createFramebuffer = function()
	local fboId = ffi.new("GLuint[1]")
	C.glCreateFramebuffers(1, fboId)
	return fboId[0]
end

---@type fun(n: number, framebuffers: ffi.cdata*)
gl.createFramebuffers = C.glCreateFramebuffers

---@type fun(framebuffer: number, attachment: number, texture: number, level: number)
gl.namedFramebufferTexture = C.glNamedFramebufferTexture

---@type fun(framebuffer: number, attachment: number, texture: number, level: number, layer: number)
gl.namedFramebufferTextureLayer = C.glNamedFramebufferTextureLayer

---@type fun(framebuffer: number, target: number): number
gl.checkNamedFramebufferStatus = C.glCheckNamedFramebufferStatus

---@type fun(target: number, framebuffer: number)
gl.bindFramebuffer = C.glBindFramebuffer

---@type fun(n: number, framebuffers: ffi.cdata*)
gl.deleteFramebuffers = C.glDeleteFramebuffers

---@type fun(n: number): number[]
gl.genSamplers = function(n)
	local handle = ffi.new("GLuint[?]", n)
	C.glGenSamplers(n, handle)

	local samplerIds = {}
	for i = 0, n - 1 do
		samplerIds[i + 1] = handle[i]
	end

	return samplerIds
end

---@type fun(n: number, samplers: ffi.cdata*)
gl.deleteSamplers = C.glDeleteSamplers

---@type fun(sampler: number, pname: number, param: number)
gl.samplerParameteri = C.glSamplerParameteri

---@type fun(sampler: number, pname: number, param: number)
gl.samplerParameterf = C.glSamplerParameterf

---@type fun(unit: number, sampler: number)
gl.bindSampler = C.glBindSampler

---@alias gl.DebugMessageCallback fun(source: number, type: number, id: number, severity: number, length: number, message: string)

---@type fun(callback: gl.DebugMessageCallback)
gl.debugMessageCallback = function(callback)
	local cCallback = ffi.cast(
		"GLDEBUGPROC",
		function(source, type, id, severity, length, message, _userParam)
			callback(source, type, id, severity, length, ffi.string(message, length))
		end
	)

	C.glDebugMessageCallback(cCallback, nil)
end

---@type fun(source: number, type: number, severity: number, count: number, ids: ffi.cdata*, enabled: number)
gl.debugMessageControl = C.glDebugMessageControl

---@type fun(pname: number): number
gl.getInteger = function(pname)
	local data = ffi.new("GLint[1]")
	C.glGetIntegerv(pname, data)
	return data[0]
end

---@type fun(): number
gl.getError = C.glGetError

---@type fun(id: number): boolean
gl.isVertexArray = function(id)
	return C.glIsVertexArray(id) ~= 0
end

---@type fun(id: number): boolean
gl.isBuffer = function(id)
	return C.glIsBuffer(id) ~= 0
end

---@type fun(pname: number, param: number)
gl.pixelStorei = C.glPixelStorei

return gl
