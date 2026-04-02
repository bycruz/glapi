typedef unsigned int GLenum;
typedef unsigned int GLuint;
typedef int32_t GLsizei;
typedef int32_t GLint;
typedef uint8_t GLubyte;
typedef float GLfloat;
typedef char GLchar;
typedef intptr_t GLintptr;
typedef intptr_t GLsizeiptr;
typedef void *GLsync;
typedef uint8_t GLboolean;

typedef void (*GLDEBUGPROC)(unsigned int, unsigned int, unsigned int,
                            unsigned int, int, const char *, const void *);

// Core OpenGL 1.1 functions which should be available on all platforms
void glClear(unsigned int mask);
void glClearColor(float r, float g, float b, float a);
void glViewport(int x, int y, GLsizei width, GLsizei height);
void glDrawElements(GLenum mode, GLsizei count, GLenum type,
                    const void *indices);
void glDeleteTextures(GLsizei n, const GLuint *textures);
char *glGetString(GLenum name);
void glGetIntegerv(GLenum pname, GLint *data);
GLenum glGetError();
void glEnable(GLenum cap);
void glDisable(GLenum cap);
void glBlendFunc(GLenum sfactor, GLenum dfactor);
void glFinish();
void glFlush();
void glDepthFunc(GLenum func);
void glDepthMask(GLboolean flag);
void glClearDepthf(GLfloat depth);
void glDebugMessageCallback(GLDEBUGPROC callback, const void *userParam);
void glDebugMessageControl(GLenum source, GLenum type, GLenum severity,
                           GLsizei count, const GLuint *ids,
                           unsigned char enabled);
