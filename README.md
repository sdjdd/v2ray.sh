## 自用 v2ray 脚本

暂时未找到 MacOS 下合适的图形客户端（V2rayX 也太难用了吧），遂制作该启动脚本。

### 0. 准备工作

设置 `v2ray` 路径

```bash
export v2ray_bin='/path/to/v2ray'
```

设置 `v2ray.sh` 快捷命令

```bash
alias v2ray='/path/to/v2ray.sh'
```

### 1. 生成配置

交互式生成配置文件

```bash
./genconf.sh
```

### 2. 启动路由代理
```bash
v2ray r
```

### 3. 启动全局代理
```bash
v2ray g
```

### 4. 关闭代理
```bash
v2ray stop
```
