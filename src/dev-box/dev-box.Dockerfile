FROM quay.io/podman/stable

# Add retries and fastmirror to skip bad servers
RUN echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf && \
    echo "fastestmirror=True" >> /etc/dnf/dnf.conf

RUN dnf install -y \
    --setopt=install_weak_deps=False \
    neovim \
    podman-compose \
    git \
    gcc \
    make \
    ripgrep \
    && dnf clean all

WORKDIR /workspace
