# syntax=docker/dockerfile:1
FROM almalinux/10-init:latest

# mlmmj 運用に必要な最小限のパッケージ
RUN --mount=type=cache,target=/var/cache/dnf \
    dnf install -y epel-release && \
    dnf install -y \
        mlmmj \
        postfix

# 検証・テスト用のツール
RUN --mount=type=cache,target=/var/cache/dnf \
    dnf install -y \
        s-nail \
        swaks \
        procps-ng \
        diffutils \
        python3 \
        which

# Postfix を systemd で自動起動
RUN systemctl enable postfix

# テストスクリプト等配置用のディレクトリ
WORKDIR /workspace
