---
# 电磁场偶极子近场仿真可视化系统
# Electromagnetic Dipole Near-Field Simulation & Visualization
## 📖 项目简介 | Introduction

本项目是针对**工程电磁场**课程设计的学术实现。通过 MATLAB 编程，系统地实现了电偶极子与磁偶极子在近场区域的物理建模与数值仿真。

This project provides a systematic MATLAB implementation for simulating and visualizing the near-field distributions of electric and magnetic dipoles.

---

## ✨ 核心模块 | Core Features

### 1. 三维空间电场仿真 (3D Electric Field)
**物理精度**：基于欧几里得距离矩阵计算空间任一点的电势 。
**可视化渲染**：利用 `streamline` 函数追踪天蓝色的空间电场线轨迹 。
**动态交互**：用户可自定义电荷坐标及电场线采样密度（角度间隔 ） 。
**电性区分**：红色代表正电荷，蓝色代表负电荷，直观展示场线发散与汇聚 。
### 2. 二维平面场线与等势面 (2D Electric Field & Equipotential)
**多场共存**：在同一平面内同时绘制电场线（实线）与等势线（黑色虚线） 。
**正交性演示**：通过数值梯度算法准确展示电场线始终垂直于等势面的物理特性 。
**细节控制**：支持动态调整等势面差值间隔 ，以获得更细致的电势梯度分布 。
### 3. 三维磁偶极子建模 (3D Magnetic Dipole)
**等效模型**：基于“双磁荷模型”模拟磁偶极子的 N/S 极分布 。
**视觉优化**：利用 `sphere` 函数与 `gouraud` 光照模型，增强磁极球体的立体感 。
**闭合特性**：清晰展示亮紫色的磁感线从北极出发并回到南极的闭合路径 。
---
## 📐 数学理论 | Theoretical Background
### 电偶极子模型 (Electric Dipole)
电偶极矩定义为点电荷量与位移矢量的乘积：
在场点产生的电场强度公式为：
### 磁偶极子模型 (Magnetic Dipole)
磁偶极子通常由微小电流环构成，其磁场分布与电偶极子具有数学对称性：
---
## 🛠️ 技术实现 | Technical Stack
| 类别 | 描述 |
| --- | --- |
| **计算引擎** | MATLAB 数值计算 |
| **核心算法** | 梯度下降法 (`gradient`)、空间网格化 (`meshgrid`) 
| **绘图函数** | <br>`streamline`, `contour`, `surf`, `plot3` 
| **异常处理** | 引入 `eps` 处理距离为零的奇异值，防止计算崩溃 
---
## 🚀 快速开始 | Quick Start
1. **克隆仓库**：
```bash
git clone https://github.com/YourUsername/Electromagnetic-Dipole-Simulation.git
```
2. **运行仿真**：
* 运行 `1.m` 进行三维电场仿真 。
* 运行 `2.m` 进行二维综合场分析 。
* 运行 `3.m` 查看磁偶极子分布 。
