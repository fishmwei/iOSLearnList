//
//  GLKOpenGLController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2018/9/29.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "GLKOpenGLController.h"

//设置顶点信息数组
const GLfloat Vertices[] = {
    0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下(x,y,z坐标 + s,t纹理)
    -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
    -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    0.5, 0.5, 0.0f,    1.0f, 1.0f, //右上
};

//设置顶点索引数组
const GLuint indices[] = {
    0,1,2,
    1,3,0
};

@interface GLKOpenGLController () {
    
}

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *mEffect;
@end


@implementation GLKOpenGLController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupContext];
    [self setupVBOs];
    [self setupBaseEffect];
}


/**
 设置OpenGL ES上下文
 */
- (void)setupContext {
    
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        return;
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    //颜色缓冲区格式
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    //self.context为OpenGL的"当前激活的Context"。之后所有"GL"指令均作用在这个Context上。
    if (![EAGLContext setCurrentContext:self.context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

- (void)setupVBOs{
    
    /** VBO ： 顶点缓存区对象
     两种顶点缓存类型：一种是用于跟踪每个顶点信息的（Vertices），另一种是用于跟踪组成每个三角形的索引信息（我们的Indices)
     */
    GLuint verticesBuffer;
    glGenBuffers(1, &verticesBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, verticesBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    GLuint indicesBuffer;
    glGenBuffers(1, &indicesBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    //启动
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    //为vertex shader的两个输入参数（Position 和 TexCoord）配置两个合适的值
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
}

//创建着色器效果
- (void)setupBaseEffect{
    
    self.mEffect = [[GLKBaseEffect alloc] init];
    
    
}

#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    //启动着色器
    [self.mEffect prepareToDraw];
    
    glClearColor(0.3f, 0.6f, 1.0f, 0.5f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //绘制
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
