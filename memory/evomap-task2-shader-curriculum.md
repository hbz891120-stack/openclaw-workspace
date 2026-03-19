# Shader 编程视觉特效课程设计

**任务 ID**: cm859dfd996cec94db23b8c07  
**领域**: AI Game Generation & Game Development  
**输出类型**: curriculum  
**完成时间**: 2026-03-19  
**模块数量**: 8 模块（入门→精通）

---

## 📋 课程概述

本课程专为游戏开发者、技术美术和 3D 艺术家设计，从 Shader 编程零基础到能够独立创作 AAA 级游戏视觉特效。课程涵盖 GLSL/HLSL 手写着色器、Unity Shader Graph、Unreal Material Editor 三大技术栈。

### 课程目标
- 理解 GPU 渲染管线和着色器工作原理
- 掌握 GLSL 和 HLSL 着色器语言
- 熟练使用 Unity Shader Graph 和 Unreal Material Editor
- 能够独立创作高质量游戏 VFX（魔法、火焰、水流、全息等）
- 建立个人 Shader 作品集

### 目标受众
- 游戏开发初学者（有基础编程经验）
- 3D 艺术家希望学习技术美术技能
- Unity/Unreal 开发者想提升视觉效果
- 技术美术（TA）职业转型者

### 预计学习周期
- **全职学习**: 8-12 周
- **兼职学习**: 16-24 周
- **每模块**: 1-2 周（含实践项目）

---

## 📚 模块大纲

### 模块 1: Shader 编程基础与 GPU 渲染管线
**级别**: 入门 | **时长**: 1-2 周

#### 学习目标
- 理解 GPU 与 CPU 的区别
- 掌握渲染管线各阶段（顶点处理→光栅化→像素处理）
- 了解顶点着色器和片元着色器的作用
- 搭建第一个开发环境

#### 核心内容
1. **GPU 架构简介**
   - 并行计算原理
   - GPU vs CPU 应用场景
   - 着色器执行模型

2. **渲染管线详解**
   - 应用阶段（Application）
   - 几何处理（顶点着色器）
   - 光栅化（Rasterization）
   - 像素处理（片元着色器）
   - 输出合并（Output Merger）

3. **开发环境搭建**
   - 安装 Unity/Unreal Engine
   - 配置 GLSL/HLSL 编辑器（VS Code + 插件）
   - ShaderToy 账号注册（在线练习平台）

4. **第一个 Shader**
   - 纯色输出
   - 简单渐变
   - UV 坐标可视化

#### 实践项目
- **项目 1.1**: 在 ShaderToy 上创建彩虹渐变效果
- **项目 1.2**: Unity 中创建纯色材质并应用到 3D 模型
- **项目 1.3**: 可视化 UV 坐标和法线方向

#### 推荐资源
- [The Book of Shaders](https://thebookofshaders.com/) - 第 1-3 章
- [Unity Learn - Shader Graph 入门](https://learn.unity.com/course/ai-ml-curricular-framework-resources/tutorial/get-started-with-shader-graph)
- YouTube: "Introduction to Shaders" - Brackeys

#### 评估标准
- [ ] 能解释渲染管线各阶段作用
- [ ] 成功运行第一个 Shader
- [ ] 完成 3 个实践项目

---

### 模块 2: GLSL/HLSL 语言基础
**级别**: 入门 | **时长**: 2 周

#### 学习目标
- 掌握 GLSL 和 HLSL 基本语法
- 理解数据类型、变量、函数
- 学会使用数学函数创建图案
- 理解向量和矩阵运算

#### 核心内容
1. **语法基础**
   - 数据类型（float, vec2/3/4, mat2/3/4）
   - 变量声明与修饰符（uniform, varying, in, out）
   - 函数定义与调用
   - 条件语句与循环

2. **内置变量**
   - gl_FragCoord / SV_Position
   - gl_FragColor / SV_Target
   - 时间变量（iTime / _Time）
   - 分辨率变量（iResolution / _ScreenParams）

3. **数学函数**
   - 三角函数（sin, cos, tan）
   - 平滑函数（smoothstep, mix, clamp）
   - 距离函数（length, distance, normalize）
   - 噪声函数基础

4. **向量与矩阵运算**
   - 点积与叉积
   - 矩阵变换
   - 坐标空间转换

#### 实践项目
- **项目 2.1**: 使用 sin/cos 创建动画波浪
- **项目 2.2**: 使用 smoothstep 创建条纹图案
- **项目 2.3**: 实现简单的圆形渐变动画
- **项目 2.4**: 创建棋盘格图案

#### 推荐资源
- [GLSL 官方文档](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))
- [HLSL 教程 - Microsoft](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl)
- [The Book of Shaders](https://thebookofshaders.com/) - 第 4-8 章

#### 评估标准
- [ ] 能独立编写 50 行以上 GLSL/HLSL 代码
- [ ] 完成 4 个图案生成项目
- [ ] 理解向量运算在 Shader 中的应用

---

### 模块 3: 程序化纹理与图案生成
**级别**: 中级 | **时长**: 2 周

#### 学习目标
- 掌握程序化纹理生成技术
- 学会使用噪声函数
- 创建复杂的程序化图案
- 理解 UV 变换技巧

#### 核心内容
1. **噪声函数**
   - Value Noise
   - Perlin Noise
   - Simplex Noise
   - Worley Noise（Voronoi）

2. **分形噪声（FBM）**
   - 多倍频叠加原理
   - 实现分形布朗运动
   - 地形生成应用

3. **图案生成技术**
   - 重复与平铺
   - 旋转与缩放
   - 对称与镜像
   - 扭曲与变形

4. **UV 变换技巧**
   - 平移、旋转、缩放
   - 极坐标变换
   - 空间扭曲效果

#### 实践项目
- **项目 3.1**: 实现 Perlin 噪声函数
- **项目 3.2**: 创建程序化大理石纹理
- **项目 3.3**: 生成程序化木纹效果
- **项目 3.4**: 制作全息网格动画

#### 推荐资源
- [Inigo Quilez 博客](https://iquilezles.org/articles/)
- [Procedural Generation 书籍](https://www.amazon.com/Procedural-Generation-Game-Development-Chapman/dp/1138089518)
- ShaderToy: 搜索 "noise", "procedural"

#### 评估标准
- [ ] 能从零实现噪声函数
- [ ] 完成 4 种程序化纹理
- [ ] 理解 FBM 原理并能应用

---

### 模块 4: 光照模型与材质基础
**级别**: 中级 | **时长**: 2 周

#### 学习目标
- 理解光照基本原理
- 掌握常见光照模型
- 学会创建 PBR 材质
- 理解 BRDF 基础概念

#### 核心内容
1. **光照基础**
   - 光的物理属性
   - 环境光、漫反射、高光
   - 法线与光照计算

2. **经典光照模型**
   - Lambert 漫反射
   - Phong 高光模型
   - Blinn-Phong 改进
   - Toon/Cel Shading

3. **PBR 基础**
   - 能量守恒原理
   - 金属度 - 粗糙度工作流
   - 菲涅尔效应
   - 微表面理论简介

4. **材质类型**
   - 漫反射材质
   - 高光材质
   - 透明材质
   - 自发光材质

#### 实践项目
- **项目 4.1**: 实现 Lambert + Blinn-Phong 光照
- **项目 4.2**: 创建卡通渲染材质
- **项目 4.3**: 制作 PBR 金属材质
- **项目 4.4**: 实现透明玻璃效果

#### 推荐资源
- [LearnOpenGL - Lighting](https://learnopengl.com/Lighting/Basic-Lighting)
- [Unity PBR 文档](https://docs.unity3d.com/Manual/PBRMaterials.html)
- [Real-Time Rendering 书籍](https://www.realtimerendering.com/)

#### 评估标准
- [ ] 能解释常见光照模型区别
- [ ] 实现至少 3 种光照模型
- [ ] 理解 PBR 基本原理

---

### 模块 5: Unity Shader Graph 实战
**级别**: 中级 | **时长**: 2 周

#### 学习目标
- 熟练掌握 Unity Shader Graph
- 理解节点式编程思维
- 创建可复用的 Shader 图
- 掌握性能优化技巧

#### 核心内容
1. **Shader Graph 界面**
   - 节点类型与功能
   - 属性面板配置
   - 预览窗口使用
   - 子图（Sub Graph）创建

2. **常用节点详解**
   - UV 节点（UV, Triplanar）
   - 数学节点（Lerp, Step, Smoothstep）
   - 噪声节点（Simple Noise, Gradient Noise）
   - 时间节点（Time, Sine Time）

3. **高级技巧**
   - 顶点动画
   - 溶解效果
   - 滚动纹理
   - 边缘光（Rim Light）

4. **性能优化**
   - 节点数量控制
   - 避免过度计算
   - LOD 策略
   - 移动端优化

#### 实践项目
- **项目 5.1**: 创建可溶解的护盾效果
- **项目 5.2**: 制作流动的水面材质
- **项目 5.3**: 实现角色轮廓光
- **项目 5.4**: 创建传送门特效

#### 推荐资源
- [Unity Shader Graph 官方教程](https://learn.unity.com/course/ai-ml-curricular-framework-resources/tutorial/get-started-with-shader-graph)
- YouTube: "Ben Cloward" Shader Graph 系列
- Unity Asset Store: 免费 Shader Graph 示例

#### 评估标准
- [ ] 能独立创建复杂 Shader Graph
- [ ] 完成 4 个实战项目
- [ ] 理解性能优化原则

---

### 模块 6: Unreal Engine Material Editor 实战
**级别**: 中级 | **时长**: 2 周

#### 学习目标
- 熟练掌握 Unreal Material Editor
- 理解 Unreal 材质系统
- 创建高质量游戏材质
- 掌握材质函数与材质实例

#### 核心内容
1. **Material Editor 界面**
   - 节点类型与功能
   - 材质域（Surface, Post Process 等）
   - 混合模式（Opaque, Translucent 等）
   - 着色模型（Default Lit, Subsurface 等）

2. **常用节点详解**
   - PBR 输入节点（Base Color, Metallic, Roughness）
   - 纹理采样节点
   - 向量运算节点
   - 时间相关节点

3. **材质函数与实例**
   - 创建材质函数（Material Function）
   - 材质参数集合
   - 材质实例（Material Instance）
   - 动态材质控制

4. **Niagara VFX 集成**
   - 材质与粒子系统配合
   - GPU 粒子材质
   -  ribbon 材质
   - 网格体粒子

#### 实践项目
- **项目 6.1**: 创建风化金属材质
- **项目 6.2**: 制作积雪地形材质
- **项目 6.3**: 实现能量流动效果
- **项目 6.4**: 创建 Niagara 粒子材质

#### 推荐资源
- [Unreal Engine 材质文档](https://docs.unrealengine.com/5.0/en-US/materials-in-unreal-engine/)
- YouTube: "Unsensei" 材质教程
- Unreal Marketplace: 免费材质示例

#### 评估标准
- [ ] 能创建复杂材质网络
- [ ] 完成 4 个实战项目
- [ ] 理解材质实例化优势

---

### 模块 7: 游戏 VFX 特效实战
**级别**: 高级 | **时长**: 2-3 周

#### 学习目标
- 掌握常见游戏 VFX 类型
- 学会特效设计与实现
- 理解特效性能优化
- 能够创作完整特效序列

#### 核心内容
1. **元素特效**
   - 火焰（Fire）
   - 水流（Water）
   - 烟雾（Smoke）
   - 爆炸（Explosion）

2. **魔法特效**
   - 能量球（Energy Orb）
   - 闪电链（Lightning Chain）
   - 传送门（Portal）
   - 护盾（Shield）

3. **环境特效**
   - 雨雪雾（Weather）
   - 尘埃粒子（Dust）
   - 体积光（God Rays）
   - 热浪扭曲（Heat Distortion）

4. **UI 特效**
   - 按钮高亮
   - 进度条动画
   - 获得物品特效
   - 升级特效

#### 实践项目
- **项目 7.1**: 制作火球术特效（发射 + 命中 + 爆炸）
- **项目 7.2**: 创建角色传送特效
- **项目 7.3**: 实现动态天气系统
- **项目 7.4**: 设计 UI 获得物品特效

#### 推荐资源
- [Unity VFX Graph 教程](https://learn.unity.com/course/unity-for-artists-curricular-framework-resources/tutorial/get-started-with-vfx)
- [Unreal Niagara 教程](https://dev.epicgames.com/community/learning/tutorials/Yxq7/unreal-engine-how-to-get-started-with-niagara)
- YouTube: "Gabriel Aguiar Prod." VFX 教程

#### 评估标准
- [ ] 完成 4 个完整 VFX 项目
- [ ] 特效性能达标（<2ms/frame）
- [ ] 能够独立设计特效方案

---

### 模块 8: 高级技巧与作品集构建
**级别**: 精通 | **时长**: 2-3 周

#### 学习目标
- 掌握高级 Shader 技术
- 了解行业最佳实践
- 构建个人作品集
- 准备技术美术求职

#### 核心内容
1. **高级技术**
   - 屏幕空间效果（SSAO, SSR）
   - 体积渲染（Volumetric）
   -  tessellation 与 displacement
   - 计算着色器基础

2. **优化与调试**
   - GPU 性能分析工具
   - Shader 变体管理
   - 内存优化
   - 跨平台兼容

3. **作品集构建**
   - 选择展示项目
   - 录制演示视频
   - 编写技术文档
   - GitHub/ArtStation 展示

4. **职业发展**
   - 技术美术岗位职责
   - 面试准备
   - 行业趋势
   - 持续学习路径

#### 实践项目
- **项目 8.1**: 实现屏幕空间反射（SSR）
- **项目 8.2**: 创建体积云效果
- **项目 8.3**: 完成个人作品集网站
- **项目 8.4**: 录制 3 个特效演示视频

#### 推荐资源
- [Real-Time Rendering 第 4 版](https://www.realtimerendering.com/)
- [GPU Gems 系列](https://developer.nvidia.com/gpugems/gpugems/contributors)
- ArtStation: 关注顶级技术美术作品

#### 评估标准
- [ ] 完成毕业作品集（至少 5 个高质量作品）
- [ ] 能够解释作品技术细节
- [ ] 理解行业最佳实践

---

## 📊 评估体系

### 模块评估
每个模块包含：
- **理论测试** (20%) - 选择题 + 简答题
- **实践项目** (50%) - 代码/Shader 实现
- **代码审查** (20%) - 代码质量与优化
- **同伴评审** (10%) - 互评与反馈

### 毕业要求
- 完成全部 8 个模块
- 总体评分 ≥ 75 分
- 提交完整作品集
- 通过最终答辩（可选）

---

## 🛠️ 工具与软件

| 工具 | 用途 | 费用 |
|------|------|------|
| Unity 2022+ | Shader Graph、VFX Graph | 免费（个人版） |
| Unreal Engine 5 | Material Editor、Niagara | 免费（收入分成） |
| VS Code | 代码编辑 | 免费 |
| ShaderToy | 在线练习 | 免费 |
| RenderDoc | GPU 调试 | 免费 |
| Blender | 3D 模型准备 | 免费 |

---

## 📚 推荐书籍

1. **《The Book of Shaders》** - Patricio Gonzalez Vivo
   - 免费在线版，最佳入门资源

2. **《Real-Time Rendering》第 4 版** - Tomas Akenine-Möller
   - 图形学圣经，深入理论

3. **《GPU Gems》系列** - NVIDIA
   - 实战技巧集合

4. **《OpenGL 4 Shading Language Cookbook》** - David Wolff
   - GLSL 实战指南

---

## 🎯 学习路径建议

### 零基础学员
```
模块 1 → 模块 2 → 模块 3 → 模块 4 → 模块 5/6 (选一个引擎) → 模块 7 → 模块 8
```

### 有编程基础学员
```
模块 1 (快速) → 模块 2 → 模块 4 → 模块 5/6 → 模块 7 → 模块 8
```

### 3D 艺术家转型
```
模块 1 → 模块 5/6 (优先) → 模块 4 → 模块 7 → 模块 8
```

---

## 💡 教学建议

1. **循序渐进** - 不要跳过基础模块
2. **多动手** - 每个概念都要实践
3. **善用社区** - Reddit、Discord、Stack Overflow
4. **建立习惯** - 每天至少 1 小时练习
5. **分享作品** - 获取反馈，持续改进

---

*课程设计完成时间：2026-03-19*  
*由 EvoMap 节点 node_0fcf0712db423018 设计提交*
