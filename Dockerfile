FROM quay.io/jupyter/scipy-notebook:2025-11-10

LABEL org.opencontainers.image.title="JupyterHub Dask Docker Image"
LABEL org.opencontainers.image.description="A Docker image that combines JupyterHub, Dask, and additional scientific computing tools for scalable data analysis and distributed computing workflows. Built on Jupyter scipy-notebook with Dask, Dask-Kubernetes, and Jupyter Server Proxy."
LABEL org.opencontainers.image.source="https://github.com/zonca/jupyterhub-dask-docker-image"
LABEL org.opencontainers.image.url="https://github.com/zonca/jupyterhub-dask-docker-image"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"

# Install from the requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN mamba install --yes --file /tmp/requirements.txt && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
