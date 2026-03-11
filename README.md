# RustDesk Server

用于阿里云生产部署的 `RustDesk OSS` 服务仓。

## 内容

- 固定上游镜像版本：`rustdesk/rustdesk-server:1.1.15`
- 发布目标：
  - `rustdesk-server-hbbs`
  - `rustdesk-server-hbbr`
- 发布链路：
  - `GitHub Actions`
  - `ACR`
  - `aliyun-deploy-platform`
  - 阿里云服务器 `pull + restart`

## 本地校验

```bash
sh test/validate.sh
```

## 生产运行时

运行时配置位于平台仓：

- `services/rustdesk-server/deploy.yaml`
- `services/rustdesk-server/compose.prod.yml`
- `services/rustdesk-server/compose.prod.env.example`

首次部署后，从远端读取公钥：

```text
/opt/aliyun-deploy-platform/runtime/rustdesk-server/data/id_ed25519.pub
```

客户端统一填：

- `ID Server`: ECS 公网 IP
- `Relay Server`: ECS 公网 IP
- `Key`: 上述公钥
