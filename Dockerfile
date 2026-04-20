FROM debian:13.4-slim

ENV DEBIAN_FRONTEND=noninteractive

# 1. Actualizar e Instalar dependencias oficiales
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential procps curl git sudo file locales nodejs npm jq && \
    rm -rf /var/lib/apt/lists/*

# Configurar locales (Crítico para Brew)
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# 2. Crear usuario y permisos
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER developer
WORKDIR /home/developer

# 3. Instalar Homebrew (Método Seguro: Descarga -> Ejecución)
RUN curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o install.sh && \
    /bin/bash install.sh && \
    rm install.sh

# 4. Añadir Homebrew al PATH (Instrucciones oficiales)
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/developer/.bashrc

# 5. Instalamos opencode y el paquete que contiene el ambiente agentico (gentle-ai)
# Forzamos la actualización de brew antes de instalar para evitar errores de clonación
RUN brew update && \
    brew install Gentleman-Programming/tap/gentle-ai && \
    brew install go 
    
# ... (después de instalar opencode)
RUN mkdir -p /home/developer/.config/opencode && \
    # Usar sudo aquí para asegurar que el cambio ocurra sobre cualquier residuo
    sudo chown -R developer:developer /home/developer && \
    chmod -R 777 /home/developer/.config/opencode    

# Configurar el entorno para cada vez que inicies sesión
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/developer/.bashrc

WORKDIR /home/developer/workspace
CMD ["/bin/bash"]
