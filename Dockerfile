FROM rockylinux/rockylinux:9-minimal

# Définir l'environnement pour libguestfs avec logs minimaux
ENV LIBGUESTFS_BACKEND=direct \
    LIBGUESTFS_DEBUG=0 \
    LIBGUESTFS_TRACE=0 \
    LIBGUESTFS_PROGRESS=1 \
    LIBGUESTFS_VERBOSE=0 \
    LIBGUESTFS_MEMSIZE=500

# Installation des dépendances nécessaires en une seule étape
# avec options d'optimisation et nettoyage des caches
RUN microdnf -y install dnf && \
    dnf -y update && \
    dnf -y install epel-release && \
    dnf -y install --allowerasing --setopt=install_weak_deps=False --nodocs \
        qemu-img \
        qemu-kvm \
        libguestfs \
        libguestfs-tools-c \
        virt-v2v \
        curl \
        tar \
        gzip \
        python3-libguestfs \
        e2fsprogs \
        xfsprogs \
        btrfs-progs \
        ntfs-3g \
        dosfstools \
        openssh-clients \
        file \
        procps-ng \
        iproute && \
    dnf clean all && \
    microdnf clean all && \
    rm -rf /var/cache/dnf /var/cache/yum /var/log/* /tmp/* /var/tmp/* && \
    rm -rf /usr/share/{doc,man,info}/* && \
    mkdir -p /workspace/images

# Définir le répertoire de travail
WORKDIR /workspace

# Point d'entrée par défaut
CMD ["/bin/bash"]
