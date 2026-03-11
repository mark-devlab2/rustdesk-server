# 阿里云部署说明

`rustdesk-server` 按统一标准走：

1. `push main`
2. GitHub Actions 读取 `.deploy/build.yaml`
3. 运行 `sh test/validate.sh`
4. 构建并推送：
   - `crpi-vbmaa8d6ek5k7rjt.cn-beijing.personal.cr.aliyuncs.com/himark/rustdesk-server-hbbs:sha-<gitsha>`
   - `crpi-vbmaa8d6ek5k7rjt.cn-beijing.personal.cr.aliyuncs.com/himark/rustdesk-server-hbbr:sha-<gitsha>`
5. GitHub Actions 通过 `aliyun-deploy-platform` 触发远端部署
6. 服务器拉取镜像、重启容器、执行 TCP 健康检查

## 远端运行时

默认平台目录：

```text
/opt/aliyun-deploy-platform
```

RustDesk 运行时目录：

```text
/opt/aliyun-deploy-platform/runtime/rustdesk-server
```

至少包含：

- `service.env`
- `compose.env`
- `data/`
- `releases/current.json`
- `releases/previous.json`

## 首发前检查

- `uname -m`
- `docker --version`
- `docker compose version`
- `ss -lntup | grep -E '21115|21116|21117'`
- 阿里云安全组已放通：
  - `21115/TCP`
  - `21116/TCP+UDP`
  - `21117/TCP`

## 运行时配置

模板来源：

```text
aliyun-deploy-platform/services/rustdesk-server/compose.prod.env.example
```

复制到远端：

```text
/opt/aliyun-deploy-platform/runtime/rustdesk-server/service.env
```

必填：

- `RUSTDESK_PUBLIC_HOST=<ecs-public-ip>`

## 部署后验收

- `docker compose ps`
- `ss -lntup | grep -E '21115|21116|21117'`
- `cat /opt/aliyun-deploy-platform/runtime/rustdesk-server/data/id_ed25519.pub`
- RustDesk 客户端使用 `ECS 公网 IP + 公钥` 成功连接
